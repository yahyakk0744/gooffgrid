-- =============================================
-- gooffgrid — Migration 002: Stories, Enhanced RLS, Cron Functions
-- =============================================

-- =============================================
-- 1. STORIES (Anti-Social Stories — Snapchat-tarzı zamanlı)
-- =============================================

-- Mevcut anti_social_posts tablosunu Stories'e dönüştür
-- Yeni kolonlar: expires_at, visibility, view_count, story_type
ALTER TABLE anti_social_posts
  ADD COLUMN IF NOT EXISTS expires_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS visibility TEXT DEFAULT 'friends',
  ADD COLUMN IF NOT EXISTS view_count INT DEFAULT 0,
  ADD COLUMN IF NOT EXISTS story_type TEXT DEFAULT 'photo',
  ADD COLUMN IF NOT EXISTS duration_hours INT DEFAULT 24;

-- Varsayılan: 24 saat sonra expire
-- Trigger: INSERT'te expires_at otomatik set
CREATE OR REPLACE FUNCTION set_story_expiry()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.expires_at IS NULL THEN
    NEW.expires_at := NOW() + (COALESCE(NEW.duration_hours, 24) || ' hours')::INTERVAL;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_story_expiry
  BEFORE INSERT ON anti_social_posts
  FOR EACH ROW EXECUTE FUNCTION set_story_expiry();

-- Story görüntüleme takibi
CREATE TABLE IF NOT EXISTS story_views (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id    UUID NOT NULL REFERENCES anti_social_posts(id) ON DELETE CASCADE,
  viewer_id   UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  viewed_at   TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(story_id, viewer_id)
);

CREATE INDEX idx_story_views_story ON story_views(story_id);
CREATE INDEX idx_story_views_viewer ON story_views(viewer_id);

-- Story reactions (emoji tepkiler)
CREATE TABLE IF NOT EXISTS story_reactions (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id    UUID NOT NULL REFERENCES anti_social_posts(id) ON DELETE CASCADE,
  user_id     UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  emoji       TEXT NOT NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(story_id, user_id)
);

CREATE INDEX idx_story_reactions_story ON story_reactions(story_id);

-- Expire olmuş story'leri temizle (unique constraint kaldır, günde birden fazla story)
ALTER TABLE anti_social_posts DROP CONSTRAINT IF EXISTS anti_social_posts_user_id_date_key;

-- Expire indeksi
CREATE INDEX idx_stories_expires ON anti_social_posts(expires_at) WHERE expires_at IS NOT NULL;
CREATE INDEX idx_stories_user_active ON anti_social_posts(user_id, created_at DESC) WHERE expires_at > NOW();

-- =============================================
-- 2. PROFILES — Ek alanlar
-- =============================================

ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS bio TEXT,
  ADD COLUMN IF NOT EXISTS friend_code TEXT UNIQUE,
  ADD COLUMN IF NOT EXISTS notification_enabled BOOLEAN DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS daily_reminder_enabled BOOLEAN DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS duel_notifications_enabled BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS location_sharing_enabled BOOLEAN DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS onboarded BOOLEAN DEFAULT FALSE;

-- Friend code otomatik üret (6 karakter alfanumerik)
CREATE OR REPLACE FUNCTION generate_friend_code()
RETURNS TRIGGER AS $$
DECLARE
  code TEXT;
  exists_count INT;
BEGIN
  IF NEW.friend_code IS NULL THEN
    LOOP
      code := upper(substr(md5(random()::text), 1, 6));
      SELECT COUNT(*) INTO exists_count FROM profiles WHERE friend_code = code;
      EXIT WHEN exists_count = 0;
    END LOOP;
    NEW.friend_code := code;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_friend_code
  BEFORE INSERT ON profiles
  FOR EACH ROW EXECUTE FUNCTION generate_friend_code();

-- =============================================
-- 3. ENHANCED RLS — Stories
-- =============================================

-- Story Views RLS
ALTER TABLE story_views ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Story view oku" ON story_views
  FOR SELECT USING (
    viewer_id = auth.uid()
    OR story_id IN (SELECT id FROM anti_social_posts WHERE user_id = auth.uid())
  );

CREATE POLICY "Story view yaz" ON story_views
  FOR INSERT WITH CHECK (viewer_id = auth.uid());

-- Story Reactions RLS
ALTER TABLE story_reactions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Story reaction oku" ON story_reactions
  FOR SELECT USING (true);

CREATE POLICY "Story reaction yaz" ON story_reactions
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Story reaction sil" ON story_reactions
  FOR DELETE USING (user_id = auth.uid());

-- Anti-Social Posts — Geliştirilmiş RLS (sadece aktif story'ler + arkadaşlar)
DROP POLICY IF EXISTS "Post oku" ON anti_social_posts;

CREATE POLICY "Aktif storyleri oku" ON anti_social_posts
  FOR SELECT USING (
    -- Kendi story'leri her zaman
    user_id = auth.uid()
    -- Veya arkadaşların aktif story'leri
    OR (
      (expires_at IS NULL OR expires_at > NOW())
      AND (
        visibility = 'public'
        OR (
          visibility = 'friends'
          AND user_id IN (
            SELECT CASE WHEN requester_id = auth.uid() THEN addressee_id ELSE requester_id END
            FROM friendships
            WHERE status = 'accepted'
              AND (requester_id = auth.uid() OR addressee_id = auth.uid())
          )
        )
      )
    )
  );

-- Anti-Social Posts — Kendi story'sini silebilir
CREATE POLICY "Kendi storysini sil" ON anti_social_posts
  FOR DELETE USING (user_id = auth.uid());

-- Anti-Social Posts — Kendi story'sini güncelleyebilir
CREATE POLICY "Kendi storysini guncelle" ON anti_social_posts
  FOR UPDATE USING (user_id = auth.uid());

-- =============================================
-- 4. CASCADE DELETE — Tribes owner cleanup
-- =============================================

-- Tribe owner silinince tribe da silinsin
ALTER TABLE tribes DROP CONSTRAINT IF EXISTS tribes_owner_id_fkey;
ALTER TABLE tribes ADD CONSTRAINT tribes_owner_id_fkey
  FOREIGN KEY (owner_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- Duel winner referansı — SET NULL (winner silinince duel kalır)
ALTER TABLE duels DROP CONSTRAINT IF EXISTS duels_winner_id_fkey;
ALTER TABLE duels ADD CONSTRAINT duels_winner_id_fkey
  FOREIGN KEY (winner_id) REFERENCES profiles(id) ON DELETE SET NULL;

-- =============================================
-- 5. NOTIFICATION LOG (Push notification tracking)
-- =============================================

CREATE TABLE IF NOT EXISTS notification_log (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  title         TEXT NOT NULL,
  body          TEXT NOT NULL,
  type          TEXT NOT NULL DEFAULT 'general',
  data          JSONB,
  sent_at       TIMESTAMPTZ DEFAULT NOW(),
  read_at       TIMESTAMPTZ
);

CREATE INDEX idx_notifications_user ON notification_log(user_id, sent_at DESC);
CREATE INDEX idx_notifications_unread ON notification_log(user_id) WHERE read_at IS NULL;

ALTER TABLE notification_log ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi bildirimlerini oku" ON notification_log
  FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "Kendi bildirimlerini guncelle" ON notification_log
  FOR UPDATE USING (user_id = auth.uid());

-- =============================================
-- 6. FUNCTIONS — Yardımcı fonksiyonlar
-- =============================================

-- Haftalık ranking'i yenile
CREATE OR REPLACE FUNCTION refresh_weekly_rankings()
RETURNS VOID AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY weekly_rankings;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Expire olmuş story'leri temizle
CREATE OR REPLACE FUNCTION cleanup_expired_stories()
RETURNS VOID AS $$
BEGIN
  DELETE FROM anti_social_posts
  WHERE expires_at IS NOT NULL AND expires_at < NOW() - INTERVAL '7 days';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Kullanıcı streak hesapla ve güncelle
CREATE OR REPLACE FUNCTION update_user_streak(p_user_id UUID)
RETURNS VOID AS $$
DECLARE
  streak INT := 0;
  check_date DATE := CURRENT_DATE;
  has_data BOOLEAN;
BEGIN
  LOOP
    SELECT EXISTS(
      SELECT 1 FROM screen_time_daily
      WHERE user_id = p_user_id AND date = check_date
    ) INTO has_data;

    EXIT WHEN NOT has_data;
    streak := streak + 1;
    check_date := check_date - 1;
  END LOOP;

  UPDATE profiles
  SET current_streak = streak,
      best_streak = GREATEST(best_streak, streak),
      streak_date = CURRENT_DATE,
      updated_at = NOW()
  WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Haftalık rapor kartı üret
CREATE OR REPLACE FUNCTION generate_report_card(p_user_id UUID)
RETURNS VOID AS $$
DECLARE
  v_week_start DATE := date_trunc('week', CURRENT_DATE)::DATE;
  v_avg INT;
  v_total INT;
  v_best INT;
  v_worst INT;
  v_pickups INT;
  v_grade CHAR(1);
  v_prev_grade CHAR(1);
BEGIN
  SELECT
    COALESCE(AVG(total_minutes), 0)::INT,
    COALESCE(SUM(total_minutes), 0)::INT,
    COALESCE(MIN(total_minutes), 0)::INT,
    COALESCE(MAX(total_minutes), 0)::INT,
    COALESCE(SUM(phone_pickups), 0)::INT
  INTO v_avg, v_total, v_best, v_worst, v_pickups
  FROM screen_time_daily
  WHERE user_id = p_user_id
    AND date >= v_week_start
    AND date < v_week_start + 7;

  -- Not hesapla (düşük = iyi)
  v_grade := CASE
    WHEN v_avg <= 60 THEN 'A'
    WHEN v_avg <= 120 THEN 'B'
    WHEN v_avg <= 180 THEN 'C'
    WHEN v_avg <= 240 THEN 'D'
    ELSE 'F'
  END;

  -- Önceki hafta notu
  SELECT grade INTO v_prev_grade FROM report_cards
  WHERE user_id = p_user_id
  ORDER BY week_start DESC LIMIT 1;

  INSERT INTO report_cards (user_id, week_start, avg_daily_minutes, total_minutes, best_day_minutes, worst_day_minutes, total_pickups, grade, grade_change)
  VALUES (p_user_id, v_week_start, v_avg, v_total, v_best, v_worst, v_pickups, v_grade,
    CASE
      WHEN v_prev_grade IS NULL THEN 0
      WHEN v_grade < v_prev_grade THEN 1   -- iyileşme
      WHEN v_grade > v_prev_grade THEN -1  -- kötüleşme
      ELSE 0
    END
  )
  ON CONFLICT (user_id, week_start) DO UPDATE SET
    avg_daily_minutes = EXCLUDED.avg_daily_minutes,
    total_minutes = EXCLUDED.total_minutes,
    best_day_minutes = EXCLUDED.best_day_minutes,
    worst_day_minutes = EXCLUDED.worst_day_minutes,
    total_pickups = EXCLUDED.total_pickups,
    grade = EXCLUDED.grade,
    grade_change = EXCLUDED.grade_change;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- 7. SUPABASE CRON JOBS (pg_cron)
-- =============================================

-- Saatlik: ranking yenile
SELECT cron.schedule(
  'refresh-rankings',
  '0 * * * *',
  $$SELECT refresh_weekly_rankings()$$
);

-- Günlük gece 3'te: expired story cleanup
SELECT cron.schedule(
  'cleanup-stories',
  '0 3 * * *',
  $$SELECT cleanup_expired_stories()$$
);

-- =============================================
-- 8. STORAGE BUCKETS
-- =============================================

-- Profil fotoğrafları
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES ('avatars', 'avatars', true, 5242880, ARRAY['image/jpeg', 'image/png', 'image/webp'])
ON CONFLICT (id) DO NOTHING;

-- Story görselleri
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES ('stories', 'stories', true, 10485760, ARRAY['image/jpeg', 'image/png', 'image/webp', 'video/mp4'])
ON CONFLICT (id) DO NOTHING;

-- Storage RLS: avatars
CREATE POLICY "Avatar herkes okur" ON storage.objects
  FOR SELECT USING (bucket_id = 'avatars');
CREATE POLICY "Kendi avatarini yukle" ON storage.objects
  FOR INSERT WITH CHECK (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);
CREATE POLICY "Kendi avatarini guncelle" ON storage.objects
  FOR UPDATE USING (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);
CREATE POLICY "Kendi avatarini sil" ON storage.objects
  FOR DELETE USING (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);

-- Storage RLS: stories
CREATE POLICY "Story herkes okur" ON storage.objects
  FOR SELECT USING (bucket_id = 'stories');
CREATE POLICY "Kendi storysini yukle" ON storage.objects
  FOR INSERT WITH CHECK (bucket_id = 'stories' AND (storage.foldername(name))[1] = auth.uid()::text);
CREATE POLICY "Kendi storysini sil" ON storage.objects
  FOR DELETE USING (bucket_id = 'stories' AND (storage.foldername(name))[1] = auth.uid()::text);

-- =============================================
-- BITTI! Stories + Enhanced RLS + Cron + Storage
-- =============================================
