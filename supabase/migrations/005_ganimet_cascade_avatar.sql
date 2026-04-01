-- =============================================
-- gooffgrid — Migration 005: Ganimet Noktalari + Cascade Audit + Avatar
-- =============================================

-- =============================================
-- 1. AVATAR_URL — Zaten mevcut, idempotent kontrol
-- =============================================

ALTER TABLE profiles ADD COLUMN IF NOT EXISTS avatar_url text;

-- =============================================
-- 2. AVATARS STORAGE BUCKET — Zaten 002'de olusturuldu, idempotent
-- =============================================

INSERT INTO storage.buckets (id, name, public)
VALUES ('avatars', 'avatars', true)
ON CONFLICT (id) DO NOTHING;

-- Storage RLS: 002'de zaten mevcut, tekrar olusturmaya gerek yok
-- (CREATE POLICY IF NOT EXISTS yok PG'de, bu yuzden atliyoruz)

-- =============================================
-- 3. GANIMET NOKTALARI — Harita uzerinde odul/hazine lokasyonlari
-- =============================================

CREATE TABLE IF NOT EXISTS ganimet_noktalari (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mekan_adi     text NOT NULL,
  lat           double precision NOT NULL,
  lng           double precision NOT NULL,
  odul_baslik   text NOT NULL,
  odul_aciklama text,
  o2_maliyet    int NOT NULL DEFAULT 100,
  kategori      text DEFAULT 'genel',
  aktif         boolean DEFAULT true,
  logo_url      text,
  created_at    timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ganimet_aktif ON ganimet_noktalari(aktif) WHERE aktif = true;
CREATE INDEX IF NOT EXISTS idx_ganimet_kategori ON ganimet_noktalari(kategori);

ALTER TABLE ganimet_noktalari ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Ganimet noktalari herkese acik"
  ON ganimet_noktalari FOR SELECT
  USING (aktif = true);

-- =============================================
-- 4. CASCADE DELETE AUDIT
-- Tum user-referencing FK'lari kontrol et ve ON DELETE CASCADE ekle
-- =============================================

-- profiles -> auth.users (zaten CASCADE, 001'de tanimli — idempotent)
ALTER TABLE profiles DROP CONSTRAINT IF EXISTS profiles_id_fkey;
ALTER TABLE profiles ADD CONSTRAINT profiles_id_fkey
  FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;

-- screen_time_daily -> profiles (zaten CASCADE)
ALTER TABLE screen_time_daily DROP CONSTRAINT IF EXISTS screen_time_daily_user_id_fkey;
ALTER TABLE screen_time_daily ADD CONSTRAINT screen_time_daily_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- app_usage -> profiles (zaten CASCADE)
ALTER TABLE app_usage DROP CONSTRAINT IF EXISTS app_usage_user_id_fkey;
ALTER TABLE app_usage ADD CONSTRAINT app_usage_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- friendships -> profiles (zaten CASCADE)
ALTER TABLE friendships DROP CONSTRAINT IF EXISTS friendships_requester_id_fkey;
ALTER TABLE friendships ADD CONSTRAINT friendships_requester_id_fkey
  FOREIGN KEY (requester_id) REFERENCES profiles(id) ON DELETE CASCADE;

ALTER TABLE friendships DROP CONSTRAINT IF EXISTS friendships_addressee_id_fkey;
ALTER TABLE friendships ADD CONSTRAINT friendships_addressee_id_fkey
  FOREIGN KEY (addressee_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- duel_players -> profiles (zaten CASCADE)
ALTER TABLE duel_players DROP CONSTRAINT IF EXISTS duel_players_user_id_fkey;
ALTER TABLE duel_players ADD CONSTRAINT duel_players_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- duels.winner_id -> profiles (SET NULL — dogru, winner silinince duel kalir)
ALTER TABLE duels DROP CONSTRAINT IF EXISTS duels_winner_id_fkey;
ALTER TABLE duels ADD CONSTRAINT duels_winner_id_fkey
  FOREIGN KEY (winner_id) REFERENCES profiles(id) ON DELETE SET NULL;

-- tribes.owner_id -> profiles (002'de CASCADE eklendi)
ALTER TABLE tribes DROP CONSTRAINT IF EXISTS tribes_owner_id_fkey;
ALTER TABLE tribes ADD CONSTRAINT tribes_owner_id_fkey
  FOREIGN KEY (owner_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- tribe_members -> profiles (zaten CASCADE)
ALTER TABLE tribe_members DROP CONSTRAINT IF EXISTS tribe_members_user_id_fkey;
ALTER TABLE tribe_members ADD CONSTRAINT tribe_members_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- user_badges -> profiles (zaten CASCADE)
ALTER TABLE user_badges DROP CONSTRAINT IF EXISTS user_badges_user_id_fkey;
ALTER TABLE user_badges ADD CONSTRAINT user_badges_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- user_task_progress -> profiles (zaten CASCADE)
ALTER TABLE user_task_progress DROP CONSTRAINT IF EXISTS user_task_progress_user_id_fkey;
ALTER TABLE user_task_progress ADD CONSTRAINT user_task_progress_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- reactions -> profiles (zaten CASCADE)
ALTER TABLE reactions DROP CONSTRAINT IF EXISTS reactions_from_user_id_fkey;
ALTER TABLE reactions ADD CONSTRAINT reactions_from_user_id_fkey
  FOREIGN KEY (from_user_id) REFERENCES profiles(id) ON DELETE CASCADE;

ALTER TABLE reactions DROP CONSTRAINT IF EXISTS reactions_to_user_id_fkey;
ALTER TABLE reactions ADD CONSTRAINT reactions_to_user_id_fkey
  FOREIGN KEY (to_user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- report_cards -> profiles (zaten CASCADE)
ALTER TABLE report_cards DROP CONSTRAINT IF EXISTS report_cards_user_id_fkey;
ALTER TABLE report_cards ADD CONSTRAINT report_cards_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- anti_social_posts -> profiles (zaten CASCADE)
ALTER TABLE anti_social_posts DROP CONSTRAINT IF EXISTS anti_social_posts_user_id_fkey;
ALTER TABLE anti_social_posts ADD CONSTRAINT anti_social_posts_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- story_views -> profiles (zaten CASCADE)
ALTER TABLE story_views DROP CONSTRAINT IF EXISTS story_views_viewer_id_fkey;
ALTER TABLE story_views ADD CONSTRAINT story_views_viewer_id_fkey
  FOREIGN KEY (viewer_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- story_reactions -> profiles (zaten CASCADE)
ALTER TABLE story_reactions DROP CONSTRAINT IF EXISTS story_reactions_user_id_fkey;
ALTER TABLE story_reactions ADD CONSTRAINT story_reactions_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- devices -> profiles (zaten CASCADE)
ALTER TABLE devices DROP CONSTRAINT IF EXISTS devices_user_id_fkey;
ALTER TABLE devices ADD CONSTRAINT devices_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- subscriptions -> profiles (zaten CASCADE)
ALTER TABLE subscriptions DROP CONSTRAINT IF EXISTS subscriptions_user_id_fkey;
ALTER TABLE subscriptions ADD CONSTRAINT subscriptions_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- notification_log -> profiles (zaten CASCADE)
ALTER TABLE notification_log DROP CONSTRAINT IF EXISTS notification_log_user_id_fkey;
ALTER TABLE notification_log ADD CONSTRAINT notification_log_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- o2_transactions -> profiles (zaten CASCADE)
ALTER TABLE o2_transactions DROP CONSTRAINT IF EXISTS o2_transactions_user_id_fkey;
ALTER TABLE o2_transactions ADD CONSTRAINT o2_transactions_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- focus_sessions -> profiles (zaten CASCADE)
ALTER TABLE focus_sessions DROP CONSTRAINT IF EXISTS focus_sessions_user_id_fkey;
ALTER TABLE focus_sessions ADD CONSTRAINT focus_sessions_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- market_redemptions -> profiles (zaten CASCADE)
ALTER TABLE market_redemptions DROP CONSTRAINT IF EXISTS market_redemptions_user_id_fkey;
ALTER TABLE market_redemptions ADD CONSTRAINT market_redemptions_user_id_fkey
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- =============================================
-- BITTI! Ganimet tablosu + Cascade audit tamamlandi
-- =============================================
