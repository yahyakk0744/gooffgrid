-- =============================================
-- gooffgrid — Migration 006: O2 Anti-Fraud Enhancements
-- Kullanici timezone'una gore zaman penceresi kontrolu
-- Gunluk tavan sunucu tarafinda kesin uygulama
-- =============================================

-- =============================================
-- 1. Profil tablosuna timezone alani ekle
-- =============================================

ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS timezone TEXT DEFAULT 'Europe/Istanbul';

-- =============================================
-- 2. earn_o2 fonksiyonunu guncelle — kullanici timezone destegi
-- =============================================

CREATE OR REPLACE FUNCTION earn_o2(
  p_user_id UUID,
  p_amount INT,
  p_type o2_tx_type,
  p_description TEXT DEFAULT NULL,
  p_metadata JSONB DEFAULT NULL
) RETURNS JSONB AS $$
DECLARE
  v_tz TEXT;
  v_local_hour INT;
  v_daily_earned INT;
  v_final_amount INT;
  v_new_balance INT;
BEGIN
  -- Kullanicinin timezone'unu al
  SELECT COALESCE(timezone, 'Europe/Istanbul') INTO v_tz
  FROM profiles WHERE id = p_user_id;

  -- ANTI-CHEAT KURAL 1: Saat kontrolu (08:00-00:00 kullanici yerel saati)
  v_local_hour := EXTRACT(HOUR FROM NOW() AT TIME ZONE v_tz);
  IF v_local_hour < 8 THEN
    RETURN jsonb_build_object(
      'success', false,
      'error', 'night_blocked',
      'message', 'O2 sadece 08:00-00:00 arasi kazanilir. Yerel saatiniz: ' || v_local_hour || ':00'
    );
  END IF;

  -- ANTI-CHEAT KURAL 2: Gunluk tavan (500 O2)
  SELECT COALESCE(SUM(amount), 0) INTO v_daily_earned
  FROM o2_transactions
  WHERE user_id = p_user_id
    AND date = (NOW() AT TIME ZONE v_tz)::DATE
    AND amount > 0;

  IF v_daily_earned >= 500 THEN
    RETURN jsonb_build_object(
      'success', false,
      'error', 'daily_cap',
      'message', 'Gunluk 500 O2 limitine ulastin',
      'daily_total', v_daily_earned
    );
  END IF;

  -- Kalan kapasiteyi hesapla
  v_final_amount := LEAST(p_amount, 500 - v_daily_earned);
  IF v_final_amount <= 0 THEN
    RETURN jsonb_build_object(
      'success', false,
      'error', 'daily_cap',
      'message', 'Gunluk 500 O2 limitine ulastin',
      'daily_total', v_daily_earned
    );
  END IF;

  -- Negatif miktar kontrolu (ek guvenlik)
  IF p_amount <= 0 THEN
    RETURN jsonb_build_object(
      'success', false,
      'error', 'invalid_amount',
      'message', 'Miktar 0 dan buyuk olmali'
    );
  END IF;

  -- O2 ver
  INSERT INTO o2_transactions (user_id, amount, type, description, metadata, date)
  VALUES (p_user_id, v_final_amount, p_type, p_description, p_metadata,
          (NOW() AT TIME ZONE v_tz)::DATE);

  -- Bakiye guncelle
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
-- 3. Rate limiting: Ayni kullanici cok hizli earn cagiramaz
-- =============================================

-- Son 10 saniye icinde ayni kullanicidan birden fazla earn engelle
CREATE OR REPLACE FUNCTION check_earn_rate_limit(p_user_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
  v_last_earn TIMESTAMPTZ;
BEGIN
  SELECT MAX(created_at) INTO v_last_earn
  FROM o2_transactions
  WHERE user_id = p_user_id AND amount > 0;

  IF v_last_earn IS NOT NULL AND (NOW() - v_last_earn) < INTERVAL '10 seconds' THEN
    RETURN FALSE;
  END IF;

  RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- 4. Audit log: Engellenen kazanim denemeleri
-- =============================================

CREATE TABLE IF NOT EXISTS o2_fraud_log (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  reason        TEXT NOT NULL,
  attempted_amount INT,
  metadata      JSONB,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_fraud_log_user ON o2_fraud_log(user_id, created_at DESC);

ALTER TABLE o2_fraud_log ENABLE ROW LEVEL SECURITY;
-- Kullanicilar kendi fraud loglarini goremez, sadece admin
CREATE POLICY "Admin only fraud log" ON o2_fraud_log
  FOR SELECT USING (false);

-- =============================================
-- BITTI! O2 Anti-Fraud Enhancements
-- =============================================
