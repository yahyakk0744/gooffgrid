-- =============================================
-- gooffgrid — Tam Veritabanı Şeması
-- Supabase SQL Editor'a yapıştır ve Run bas
-- =============================================

-- 1. PROFILES
CREATE TABLE profiles (
  id            UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username      TEXT UNIQUE,
  display_name  TEXT,
  avatar_url    TEXT,
  avatar_color  TEXT DEFAULT '#FF6B00',
  city          TEXT,
  country       TEXT DEFAULT 'TR',
  birth_year    INT,
  level         INT DEFAULT 1,
  xp            INT DEFAULT 0,
  current_streak INT DEFAULT 0,
  best_streak   INT DEFAULT 0,
  streak_date   DATE,
  daily_goal_minutes INT DEFAULT 120,
  is_premium    BOOLEAN DEFAULT FALSE,
  locale        TEXT DEFAULT 'tr',
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_profiles_city ON profiles(city);
CREATE INDEX idx_profiles_country ON profiles(country);
CREATE INDEX idx_profiles_birth_year ON profiles(birth_year);

-- Yeni kullanıcı kayıt olunca otomatik profil oluştur
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id)
  VALUES (NEW.id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 2. SCREEN TIME DAILY
CREATE TABLE screen_time_daily (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  date          DATE NOT NULL,
  total_minutes INT NOT NULL DEFAULT 0,
  phone_pickups INT DEFAULT 0,
  longest_off_minutes INT DEFAULT 0,
  goal_minutes  INT,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, date)
);

CREATE INDEX idx_screen_time_user_date ON screen_time_daily(user_id, date DESC);
CREATE INDEX idx_screen_time_date ON screen_time_daily(date);
CREATE INDEX idx_screen_time_date_minutes ON screen_time_daily(date, total_minutes ASC);

-- 3. APP USAGE
CREATE TABLE app_usage (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  date          DATE NOT NULL,
  package_name  TEXT NOT NULL,
  app_name      TEXT NOT NULL,
  minutes       INT NOT NULL DEFAULT 0,
  category      TEXT,
  UNIQUE(user_id, date, package_name)
);

CREATE INDEX idx_app_usage_user_date ON app_usage(user_id, date);

-- 4. FRIENDSHIPS
CREATE TYPE friendship_status AS ENUM ('pending', 'accepted', 'blocked');

CREATE TABLE friendships (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  requester_id  UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  addressee_id  UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  status        friendship_status DEFAULT 'pending',
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(requester_id, addressee_id),
  CHECK (requester_id != addressee_id)
);

CREATE INDEX idx_friendships_addressee ON friendships(addressee_id, status);
CREATE INDEX idx_friendships_requester ON friendships(requester_id, status);

-- 5. DUELS
CREATE TYPE duel_status AS ENUM ('pending', 'active', 'completed', 'cancelled');

CREATE TABLE duels (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  share_code    TEXT UNIQUE NOT NULL,
  status        duel_status DEFAULT 'pending',
  duration_hours INT NOT NULL,
  started_at    TIMESTAMPTZ,
  ends_at       TIMESTAMPTZ,
  winner_id     UUID REFERENCES profiles(id),
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_duels_status ON duels(status);
CREATE INDEX idx_duels_share_code ON duels(share_code);

CREATE TABLE duel_players (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  duel_id       UUID NOT NULL REFERENCES duels(id) ON DELETE CASCADE,
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  total_minutes INT DEFAULT 0,
  is_creator    BOOLEAN DEFAULT FALSE,
  UNIQUE(duel_id, user_id)
);

CREATE INDEX idx_duel_players_user ON duel_players(user_id);

-- 6. TRIBES (KABİLELER)
CREATE TABLE tribes (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name          TEXT NOT NULL,
  description   TEXT,
  avatar_url    TEXT,
  invite_code   TEXT UNIQUE NOT NULL,
  owner_id      UUID NOT NULL REFERENCES profiles(id),
  challenge_target_minutes INT,
  challenge_description TEXT,
  max_members   INT DEFAULT 20,
  is_public     BOOLEAN DEFAULT TRUE,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_tribes_invite ON tribes(invite_code);

CREATE TABLE tribe_members (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tribe_id      UUID NOT NULL REFERENCES tribes(id) ON DELETE CASCADE,
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  role          TEXT DEFAULT 'member',
  joined_at     TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(tribe_id, user_id)
);

CREATE INDEX idx_tribe_members_user ON tribe_members(user_id);

-- 7. BADGES
CREATE TABLE badges (
  id            TEXT PRIMARY KEY,
  name_key      TEXT NOT NULL,
  description_key TEXT NOT NULL,
  icon          TEXT NOT NULL,
  category      TEXT NOT NULL,
  requirement   JSONB,
  is_premium    BOOLEAN DEFAULT FALSE,
  sort_order    INT DEFAULT 0
);

CREATE TABLE user_badges (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  badge_id      TEXT NOT NULL REFERENCES badges(id),
  earned_at     TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, badge_id)
);

CREATE INDEX idx_user_badges_user ON user_badges(user_id);

-- 8. SEASONS & TASKS
CREATE TABLE seasons (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name          TEXT NOT NULL,
  starts_at     TIMESTAMPTZ NOT NULL,
  ends_at       TIMESTAMPTZ NOT NULL,
  is_active     BOOLEAN DEFAULT FALSE
);

CREATE TABLE season_tasks (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  season_id     UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
  title_key     TEXT NOT NULL,
  description_key TEXT NOT NULL,
  xp_reward     INT NOT NULL,
  requirement   JSONB NOT NULL,
  is_premium    BOOLEAN DEFAULT FALSE,
  sort_order    INT DEFAULT 0
);

CREATE TABLE user_task_progress (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  task_id       UUID NOT NULL REFERENCES season_tasks(id) ON DELETE CASCADE,
  current_value INT DEFAULT 0,
  completed_at  TIMESTAMPTZ,
  UNIQUE(user_id, task_id)
);

-- 9. REACTIONS
CREATE TABLE reactions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  from_user_id  UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  to_user_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  emoji         TEXT NOT NULL,
  context_type  TEXT,
  context_id    UUID,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  CHECK (from_user_id != to_user_id)
);

CREATE INDEX idx_reactions_to ON reactions(to_user_id, created_at DESC);

-- 10. REPORT CARDS
CREATE TABLE report_cards (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  week_start    DATE NOT NULL,
  avg_daily_minutes INT NOT NULL,
  total_minutes     INT NOT NULL,
  best_day_minutes  INT,
  worst_day_minutes INT,
  total_pickups     INT,
  grade         CHAR(1) NOT NULL,
  grade_change  INT DEFAULT 0,
  friend_rank   INT,
  city_rank     INT,
  country_rank  INT,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, week_start)
);

-- 11. ANTI-SOCIAL POSTS
CREATE TABLE anti_social_posts (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  date          DATE NOT NULL,
  image_url     TEXT,
  caption       TEXT,
  activity_type TEXT,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, date)
);

CREATE INDEX idx_antisocial_date ON anti_social_posts(date DESC);

-- 12. DEVICES (Push Notification)
CREATE TABLE devices (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  fcm_token     TEXT NOT NULL,
  platform      TEXT NOT NULL,
  is_active     BOOLEAN DEFAULT TRUE,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_devices_user ON devices(user_id);

-- 13. SUBSCRIPTIONS
CREATE TABLE subscriptions (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  rc_customer_id  TEXT,
  product_id      TEXT NOT NULL,
  status          TEXT DEFAULT 'active',
  starts_at       TIMESTAMPTZ NOT NULL,
  expires_at      TIMESTAMPTZ,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_subscriptions_user ON subscriptions(user_id, status);

-- =============================================
-- ROW LEVEL SECURITY (RLS)
-- =============================================

-- Profiles: herkes okur, sadece kendi günceller
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Herkes profil okuyabilir" ON profiles FOR SELECT USING (true);
CREATE POLICY "Kendi profilini guncelle" ON profiles FOR UPDATE USING (auth.uid() = id);

-- Screen Time: kendi yazar, arkadaşlar okur
ALTER TABLE screen_time_daily ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi verisini yaz" ON screen_time_daily FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Kendi verisini guncelle" ON screen_time_daily FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Kendi ve arkadaslarin verisini oku" ON screen_time_daily FOR SELECT USING (
  user_id = auth.uid()
  OR user_id IN (
    SELECT CASE WHEN requester_id = auth.uid() THEN addressee_id ELSE requester_id END
    FROM friendships
    WHERE status = 'accepted'
      AND (requester_id = auth.uid() OR addressee_id = auth.uid())
  )
);

-- App Usage: kendi yazar/okur
ALTER TABLE app_usage ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi app verisini yaz" ON app_usage FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Kendi app verisini oku" ON app_usage FOR SELECT USING (auth.uid() = user_id);

-- Friendships
ALTER TABLE friendships ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi arkadasliklarini oku" ON friendships FOR SELECT USING (
  requester_id = auth.uid() OR addressee_id = auth.uid()
);
CREATE POLICY "Arkadaslik istegi gonder" ON friendships FOR INSERT WITH CHECK (requester_id = auth.uid());
CREATE POLICY "Arkadaslik guncelle" ON friendships FOR UPDATE USING (
  addressee_id = auth.uid() OR requester_id = auth.uid()
);

-- Duels
ALTER TABLE duels ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Duello oku" ON duels FOR SELECT USING (true);
CREATE POLICY "Duello olustur" ON duels FOR INSERT WITH CHECK (true);
CREATE POLICY "Duello guncelle" ON duels FOR UPDATE USING (true);

ALTER TABLE duel_players ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Duello oyuncu oku" ON duel_players FOR SELECT USING (true);
CREATE POLICY "Duello oyuncu ekle" ON duel_players FOR INSERT WITH CHECK (user_id = auth.uid());

-- Tribes
ALTER TABLE tribes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kabile oku" ON tribes FOR SELECT USING (true);
CREATE POLICY "Kabile olustur" ON tribes FOR INSERT WITH CHECK (owner_id = auth.uid());
CREATE POLICY "Kabile guncelle" ON tribes FOR UPDATE USING (owner_id = auth.uid());

ALTER TABLE tribe_members ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kabile uyeleri oku" ON tribe_members FOR SELECT USING (true);
CREATE POLICY "Kabileye katil" ON tribe_members FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "Kabielden ayril" ON tribe_members FOR DELETE USING (user_id = auth.uid());

-- Badges (read-only for users)
ALTER TABLE badges ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Rozet oku" ON badges FOR SELECT USING (true);

ALTER TABLE user_badges ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi rozetlerini oku" ON user_badges FOR SELECT USING (user_id = auth.uid());

-- Seasons (read-only)
ALTER TABLE seasons ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Sezon oku" ON seasons FOR SELECT USING (true);

ALTER TABLE season_tasks ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Gorev oku" ON season_tasks FOR SELECT USING (true);

ALTER TABLE user_task_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi ilerlemesini oku" ON user_task_progress FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "Kendi ilerlemesini yaz" ON user_task_progress FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "Kendi ilerlemesini guncelle" ON user_task_progress FOR UPDATE USING (user_id = auth.uid());

-- Reactions
ALTER TABLE reactions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Reaksiyon oku" ON reactions FOR SELECT USING (
  from_user_id = auth.uid() OR to_user_id = auth.uid()
);
CREATE POLICY "Reaksiyon gonder" ON reactions FOR INSERT WITH CHECK (from_user_id = auth.uid());

-- Report Cards
ALTER TABLE report_cards ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi karnesini oku" ON report_cards FOR SELECT USING (user_id = auth.uid());

-- Anti-Social Posts
ALTER TABLE anti_social_posts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Post oku" ON anti_social_posts FOR SELECT USING (true);
CREATE POLICY "Post yaz" ON anti_social_posts FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Devices
ALTER TABLE devices ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi cihazini yaz" ON devices FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Kendi cihazini oku" ON devices FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Kendi cihazini guncelle" ON devices FOR UPDATE USING (auth.uid() = user_id);

-- Subscriptions
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Kendi aboneligini oku" ON subscriptions FOR SELECT USING (auth.uid() = user_id);

-- =============================================
-- SEED DATA: Rozetler
-- =============================================

INSERT INTO badges (id, name_key, description_key, icon, category, requirement, is_premium, sort_order) VALUES
  ('first_step',    'badge.first_step',    'badge.first_step.desc',    '👣', 'milestone', '{"type":"signup"}', false, 1),
  ('streak_3',      'badge.streak_3',      'badge.streak_3.desc',      '🔥', 'streak',    '{"type":"streak","value":3}', false, 2),
  ('streak_7',      'badge.streak_7',      'badge.streak_7.desc',      '🔥', 'streak',    '{"type":"streak","value":7}', false, 3),
  ('streak_30',     'badge.streak_30',     'badge.streak_30.desc',     '🔥', 'streak',    '{"type":"streak","value":30}', false, 4),
  ('streak_100',    'badge.streak_100',    'badge.streak_100.desc',    '💎', 'streak',    '{"type":"streak","value":100}', true, 5),
  ('duel_first',    'badge.duel_first',    'badge.duel_first.desc',    '⚔️', 'duel',      '{"type":"duel_win","value":1}', false, 6),
  ('duel_king',     'badge.duel_king',     'badge.duel_king.desc',     '👑', 'duel',      '{"type":"duel_win","value":10}', false, 7),
  ('social_5',      'badge.social_5',      'badge.social_5.desc',      '🤝', 'social',    '{"type":"friends","value":5}', false, 8),
  ('social_20',     'badge.social_20',     'badge.social_20.desc',     '🌐', 'social',    '{"type":"friends","value":20}', true, 9),
  ('early_bird',    'badge.early_bird',    'badge.early_bird.desc',    '🌅', 'milestone', '{"type":"no_usage_before","hour":8}', false, 10),
  ('night_owl',     'badge.night_owl',     'badge.night_owl.desc',     '🦉', 'milestone', '{"type":"no_usage_after","hour":22}', false, 11),
  ('under_60',      'badge.under_60',      'badge.under_60.desc',      '⚡', 'milestone', '{"type":"daily_under","value":60}', false, 12),
  ('city_top3',     'badge.city_top3',     'badge.city_top3.desc',     '🏆', 'ranking',   '{"type":"city_rank","value":3}', false, 13),
  ('country_top10', 'badge.country_top10', 'badge.country_top10.desc', '🗺️', 'ranking',   '{"type":"country_rank","value":10}', true, 14),
  ('offgrid_god',   'badge.offgrid_god',   'badge.offgrid_god.desc',   '🧘', 'milestone', '{"type":"level","value":10}', true, 15);

-- =============================================
-- HAFTALIK SIRALAMA MATERIALIZED VIEW
-- =============================================

CREATE MATERIALIZED VIEW weekly_rankings AS
SELECT
  p.id AS user_id,
  p.display_name,
  p.username,
  p.city,
  p.country,
  p.birth_year,
  p.avatar_color,
  p.level,
  COALESCE(AVG(s.total_minutes), 0)::INT AS avg_minutes,
  COALESCE(SUM(s.total_minutes), 0)::INT AS total_minutes,
  RANK() OVER (ORDER BY COALESCE(AVG(s.total_minutes), 9999) ASC) AS global_rank,
  RANK() OVER (PARTITION BY p.city ORDER BY COALESCE(AVG(s.total_minutes), 9999) ASC) AS city_rank,
  RANK() OVER (PARTITION BY p.country ORDER BY COALESCE(AVG(s.total_minutes), 9999) ASC) AS country_rank
FROM profiles p
LEFT JOIN screen_time_daily s ON s.user_id = p.id
  AND s.date >= date_trunc('week', CURRENT_DATE)
GROUP BY p.id;

CREATE UNIQUE INDEX ON weekly_rankings(user_id);
CREATE INDEX ON weekly_rankings(city, city_rank);
CREATE INDEX ON weekly_rankings(country, country_rank);
CREATE INDEX ON weekly_rankings(global_rank);

-- =============================================
-- BITTI! 13 tablo + 1 view + 15 rozet + RLS
-- =============================================
