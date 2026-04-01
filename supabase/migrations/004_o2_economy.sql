-- =============================================
-- gooffgrid — Migration 004: O2 (Oksijen) Ekonomisi
-- Anti-Cheat, Off-Grid Market, Focus Sessions
-- =============================================

-- =============================================
-- 1. O2 BALANCE — Kullanıcı O2 bakiyesi
-- =============================================

ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS o2_balance INT DEFAULT 0,
  ADD COLUMN IF NOT EXISTS o2_lifetime INT DEFAULT 0;

-- =============================================
-- 2. O2 TRANSACTIONS — Kazanım/Harcama logları
-- =============================================

CREATE TYPE o2_tx_type AS ENUM (
  'focus_earn',      -- Odak modu ile kazanım
  'offscreen_earn',  -- Ekransız geçen süreden kazanım
  'streak_bonus',    -- Streak bonus
  'badge_bonus',     -- Rozet kazanımı bonus
  'market_spend',    -- Off-Grid Market harcama
  'admin_grant',     -- Admin tarafından verilen
  'daily_bonus'      -- Günlük giriş bonusu
);

CREATE TABLE o2_transactions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  amount        INT NOT NULL,
  type          o2_tx_type NOT NULL,
  description   TEXT,
  metadata      JSONB,
  date          DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_o2_tx_user ON o2_transactions(user_id, created_at DESC);
CREATE INDEX idx_o2_tx_user_date ON o2_transactions(user_id, date);
CREATE INDEX idx_o2_tx_type ON o2_transactions(type);

ALTER TABLE o2_transactions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi O2 logunu oku" ON o2_transactions
  FOR SELECT USING (user_id = auth.uid());

-- =============================================
-- 3. FOCUS SESSIONS — Odak modu oturumları
-- =============================================

CREATE TYPE focus_status AS ENUM ('active', 'completed', 'timeout', 'cancelled');

CREATE TABLE focus_sessions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  started_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  ended_at      TIMESTAMPTZ,
  duration_minutes INT,
  status        focus_status DEFAULT 'active',
  o2_earned     INT DEFAULT 0,
  date          DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_focus_user ON focus_sessions(user_id, date);
CREATE INDEX idx_focus_active ON focus_sessions(user_id) WHERE status = 'active';

ALTER TABLE focus_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi focus oku" ON focus_sessions
  FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "Kendi focus yaz" ON focus_sessions
  FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "Kendi focus guncelle" ON focus_sessions
  FOR UPDATE USING (user_id = auth.uid());

-- =============================================
-- 4. OFF-GRID MARKET — Kupon & İndirim
-- =============================================

CREATE TABLE market_offers (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  partner_name  TEXT NOT NULL,
  partner_logo  TEXT,
  title         TEXT NOT NULL,
  description   TEXT,
  o2_cost       INT NOT NULL,
  category      TEXT DEFAULT 'cafe',
  city          TEXT,
  max_redemptions INT,
  current_redemptions INT DEFAULT 0,
  is_active     BOOLEAN DEFAULT TRUE,
  starts_at     TIMESTAMPTZ DEFAULT NOW(),
  expires_at    TIMESTAMPTZ,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_market_active ON market_offers(is_active, city);

ALTER TABLE market_offers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Herkes market okur" ON market_offers
  FOR SELECT USING (is_active = true);

CREATE TABLE market_redemptions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  offer_id      UUID NOT NULL REFERENCES market_offers(id),
  o2_spent      INT NOT NULL,
  redeem_code   TEXT NOT NULL,
  status        TEXT DEFAULT 'active',
  redeemed_at   TIMESTAMPTZ,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_redemptions_user ON market_redemptions(user_id, created_at DESC);

ALTER TABLE market_redemptions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi kuponlarini oku" ON market_redemptions
  FOR SELECT USING (user_id = auth.uid());

-- =============================================
-- 5. ANTI-CHEAT: O2 Kazanım Fonksiyonu
-- =============================================

-- KURAL 1: Sadece 08:00-00:00 arası kazanım
-- KURAL 2: Günde max 500 O2
-- KURAL 3: Focus 120dk aşarsa timeout
-- KURAL 4: Transfer/bahis yok (tablo yapısında engellenmiş)

CREATE OR REPLACE FUNCTION earn_o2(
  p_user_id UUID,
  p_amount INT,
  p_type o2_tx_type,
  p_description TEXT DEFAULT NULL,
  p_metadata JSONB DEFAULT NULL
) RETURNS JSONB AS $$
DECLARE
  v_hour INT;
  v_daily_earned INT;
  v_final_amount INT;
  v_new_balance INT;
BEGIN
  -- ANTI-CHEAT KURAL 1: Saat kontrolü (TR saati = UTC+3)
  v_hour := EXTRACT(HOUR FROM NOW() AT TIME ZONE 'Europe/Istanbul');
  IF v_hour < 8 THEN
    RETURN jsonb_build_object('success', false, 'error', 'night_blocked',
      'message', 'O2 sadece 08:00-00:00 arası kazanılır');
  END IF;

  -- ANTI-CHEAT KURAL 2: Günlük tavan (500 O2)
  SELECT COALESCE(SUM(amount), 0) INTO v_daily_earned
  FROM o2_transactions
  WHERE user_id = p_user_id
    AND date = CURRENT_DATE
    AND amount > 0;

  IF v_daily_earned >= 500 THEN
    RETURN jsonb_build_object('success', false, 'error', 'daily_cap',
      'message', 'Günlük 500 O2 limitine ulaştın');
  END IF;

  -- Kalan kapasiteyi hesapla
  v_final_amount := LEAST(p_amount, 500 - v_daily_earned);
  IF v_final_amount <= 0 THEN
    RETURN jsonb_build_object('success', false, 'error', 'daily_cap',
      'message', 'Günlük 500 O2 limitine ulaştın');
  END IF;

  -- O2 ver
  INSERT INTO o2_transactions (user_id, amount, type, description, metadata, date)
  VALUES (p_user_id, v_final_amount, p_type, p_description, p_metadata, CURRENT_DATE);

  -- Bakiye güncelle
  UPDATE profiles
  SET o2_balance = o2_balance + v_final_amount,
      o2_lifetime = o2_lifetime + v_final_amount,
      updated_at = NOW()
  WHERE id = p_user_id
  RETURNING o2_balance INTO v_new_balance;

  RETURN jsonb_build_object(
    'success', true,
    'earned', v_final_amount,
    'requested', p_amount,
    'new_balance', v_new_balance,
    'daily_total', v_daily_earned + v_final_amount,
    'daily_remaining', 500 - (v_daily_earned + v_final_amount)
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- 6. MARKET REDEEM Fonksiyonu
-- =============================================

CREATE OR REPLACE FUNCTION redeem_offer(
  p_user_id UUID,
  p_offer_id UUID
) RETURNS JSONB AS $$
DECLARE
  v_offer market_offers%ROWTYPE;
  v_balance INT;
  v_code TEXT;
BEGIN
  -- Teklifi kontrol et
  SELECT * INTO v_offer FROM market_offers
  WHERE id = p_offer_id AND is_active = true;

  IF v_offer IS NULL THEN
    RETURN jsonb_build_object('success', false, 'error', 'offer_not_found');
  END IF;

  -- Stok kontrolü
  IF v_offer.max_redemptions IS NOT NULL
     AND v_offer.current_redemptions >= v_offer.max_redemptions THEN
    RETURN jsonb_build_object('success', false, 'error', 'sold_out');
  END IF;

  -- Bakiye kontrolü
  SELECT o2_balance INTO v_balance FROM profiles WHERE id = p_user_id;
  IF v_balance < v_offer.o2_cost THEN
    RETURN jsonb_build_object('success', false, 'error', 'insufficient_o2',
      'required', v_offer.o2_cost, 'balance', v_balance);
  END IF;

  -- Benzersiz redeem kodu üret
  v_code := 'OG-' || upper(substr(md5(random()::text || now()::text), 1, 8));

  -- O2 düş
  UPDATE profiles
  SET o2_balance = o2_balance - v_offer.o2_cost,
      updated_at = NOW()
  WHERE id = p_user_id;

  -- Transaction log
  INSERT INTO o2_transactions (user_id, amount, type, description, metadata, date)
  VALUES (p_user_id, -v_offer.o2_cost, 'market_spend', v_offer.title,
    jsonb_build_object('offer_id', p_offer_id, 'partner', v_offer.partner_name), CURRENT_DATE);

  -- Redemption oluştur
  INSERT INTO market_redemptions (user_id, offer_id, o2_spent, redeem_code)
  VALUES (p_user_id, p_offer_id, v_offer.o2_cost, v_code);

  -- Stok güncelle
  UPDATE market_offers
  SET current_redemptions = current_redemptions + 1
  WHERE id = p_offer_id;

  RETURN jsonb_build_object(
    'success', true,
    'redeem_code', v_code,
    'o2_spent', v_offer.o2_cost,
    'new_balance', v_balance - v_offer.o2_cost
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- 7. FOCUS SESSION COMPLETE Fonksiyonu
-- =============================================

CREATE OR REPLACE FUNCTION complete_focus_session(
  p_session_id UUID,
  p_user_id UUID
) RETURNS JSONB AS $$
DECLARE
  v_session focus_sessions%ROWTYPE;
  v_minutes INT;
  v_o2 INT;
  v_earn_result JSONB;
BEGIN
  SELECT * INTO v_session FROM focus_sessions
  WHERE id = p_session_id AND user_id = p_user_id AND status = 'active';

  IF v_session IS NULL THEN
    RETURN jsonb_build_object('success', false, 'error', 'session_not_found');
  END IF;

  v_minutes := EXTRACT(EPOCH FROM (NOW() - v_session.started_at))::INT / 60;

  -- ANTI-CHEAT KURAL 3: 120dk aşımı → timeout
  IF v_minutes > 120 THEN
    UPDATE focus_sessions
    SET status = 'timeout', ended_at = NOW(), duration_minutes = 120, o2_earned = 0
    WHERE id = p_session_id;

    RETURN jsonb_build_object('success', false, 'error', 'session_timeout',
      'message', '120dk aşıldı. Oturum zaman aşımına uğradı.');
  END IF;

  -- O2 hesapla: dakika başına 3 O2, minimum 5dk
  IF v_minutes < 5 THEN
    v_o2 := 0;
  ELSE
    v_o2 := v_minutes * 3;
  END IF;

  -- O2 kazan (anti-cheat kuralları uygulanır)
  IF v_o2 > 0 THEN
    v_earn_result := earn_o2(p_user_id, v_o2, 'focus_earn',
      v_minutes || ' dk odak modu',
      jsonb_build_object('session_id', p_session_id, 'minutes', v_minutes));
  ELSE
    v_earn_result := jsonb_build_object('earned', 0);
  END IF;

  -- Session kapat
  UPDATE focus_sessions
  SET status = 'completed',
      ended_at = NOW(),
      duration_minutes = v_minutes,
      o2_earned = COALESCE((v_earn_result->>'earned')::INT, 0)
  WHERE id = p_session_id;

  RETURN jsonb_build_object(
    'success', true,
    'minutes', v_minutes,
    'o2_earned', COALESCE((v_earn_result->>'earned')::INT, 0),
    'o2_details', v_earn_result
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- 8. GÜNLÜK OFF-SCREEN O2 HESAPLAMA (Cron)
-- =============================================

CREATE OR REPLACE FUNCTION calculate_daily_offscreen_o2()
RETURNS VOID AS $$
DECLARE
  r RECORD;
  v_goal INT;
  v_offscreen_minutes INT;
  v_o2 INT;
BEGIN
  FOR r IN
    SELECT st.user_id, st.total_minutes, st.longest_off_minutes,
           p.daily_goal_minutes
    FROM screen_time_daily st
    JOIN profiles p ON p.id = st.user_id
    WHERE st.date = CURRENT_DATE - 1  -- Dünün verisi
  LOOP
    v_goal := COALESCE(r.daily_goal_minutes, 120);

    -- Hedefin altındaysa bonus O2
    IF r.total_minutes < v_goal THEN
      -- Hedefe kıyasla tasarruf edilen dakika başına 1 O2
      v_offscreen_minutes := v_goal - r.total_minutes;
      v_o2 := LEAST(v_offscreen_minutes, 200); -- Max 200 offscreen bonus

      PERFORM earn_o2(r.user_id, v_o2, 'offscreen_earn',
        'Dün ' || r.total_minutes || 'dk kullandın, hedef ' || v_goal || 'dk',
        jsonb_build_object('total_minutes', r.total_minutes, 'goal', v_goal, 'saved', v_offscreen_minutes));
    END IF;
  END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Cron: Her gün 08:30'da (UTC 05:30 = TR 08:30) dünün O2'sini hesapla
SELECT cron.schedule(
  'daily-offscreen-o2',
  '30 5 * * *',
  $$SELECT calculate_daily_offscreen_o2()$$
);

-- =============================================
-- 9. STORY GATE — Sadece hedef altı story atabilir
-- =============================================

CREATE OR REPLACE FUNCTION check_story_eligibility(p_user_id UUID)
RETURNS JSONB AS $$
DECLARE
  v_today_minutes INT;
  v_goal INT;
BEGIN
  SELECT daily_goal_minutes INTO v_goal FROM profiles WHERE id = p_user_id;
  v_goal := COALESCE(v_goal, 120);

  SELECT total_minutes INTO v_today_minutes
  FROM screen_time_daily
  WHERE user_id = p_user_id AND date = CURRENT_DATE;

  v_today_minutes := COALESCE(v_today_minutes, 0);

  IF v_today_minutes <= v_goal THEN
    RETURN jsonb_build_object('eligible', true, 'minutes', v_today_minutes, 'goal', v_goal);
  ELSE
    RETURN jsonb_build_object('eligible', false, 'minutes', v_today_minutes, 'goal', v_goal,
      'message', 'Günlük hedefini aştın! Story paylaşmak için ekran sürenizi azaltın.');
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- 10. SEED: Örnek Market Teklifleri
-- =============================================

INSERT INTO market_offers (partner_name, title, description, o2_cost, category, city) VALUES
  ('Kahve Durağı', '%20 İndirim', 'Tüm içeceklerde geçerli', 100, 'cafe', 'İstanbul'),
  ('Kitapçı Sokağı', '%15 İndirim', 'Tüm kitaplarda geçerli', 80, 'bookstore', 'İstanbul'),
  ('Spor Salonu X', '1 Günlük Ücretsiz Giriş', 'Herhangi bir gün kullanılabilir', 200, 'fitness', NULL),
  ('Müzik Dünyası', '1 Aylık Premium', 'Müzik streaming premium', 300, 'entertainment', NULL),
  ('Sağlıklı Yaşam', '%10 İndirim', 'Organik ürünlerde geçerli', 50, 'health', NULL),
  ('Doğa Kampı', '%25 İndirim', 'Hafta sonu kamp rezervasyonlarında', 400, 'outdoor', NULL)
ON CONFLICT DO NOTHING;

-- =============================================
-- BİTTİ! O2 Ekonomisi + Anti-Cheat + Market
-- =============================================
