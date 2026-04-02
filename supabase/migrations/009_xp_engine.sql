-- ═══════════════════════════════════════
-- XP ENGINE — Level & Badge System
-- Migration 009
-- ═══════════════════════════════════════

-- 1. XP Tracking Table
CREATE TABLE IF NOT EXISTS user_xp (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  amount INTEGER NOT NULL CHECK (amount > 0),
  source TEXT NOT NULL CHECK (source IN ('focus', 'duel_win', 'duel_participate', 'daily_goal', 'streak', 'story', 'reaction', 'badge', 'season_task', 'referral', 'first_time')),
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_user_xp_user_id ON user_xp(user_id);
CREATE INDEX IF NOT EXISTS idx_user_xp_created_at ON user_xp(created_at);

ALTER TABLE user_xp ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Users can see own XP' AND tablename = 'user_xp') THEN
    CREATE POLICY "Users can see own XP" ON user_xp FOR SELECT USING (auth.uid() = user_id);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'System can insert XP' AND tablename = 'user_xp') THEN
    CREATE POLICY "System can insert XP" ON user_xp FOR INSERT WITH CHECK (auth.uid() = user_id);
  END IF;
END $$;

-- 2. Add XP columns to profiles (total_xp is new; level already exists from 001)
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS total_xp INTEGER DEFAULT 0;
-- level already exists from 001_initial_schema, no need to add

-- 3. Logarithmic Level Calculation Function
-- Formula: XP_needed = floor(100 * level^1.2)
-- Level 1: 100 XP, Level 2: 230 XP cumulative, Level 10: ~1585 XP cumulative
-- Level 50: ~13,000 XP, Level 100: ~31,600 XP
CREATE OR REPLACE FUNCTION calculate_level(xp INTEGER)
RETURNS INTEGER AS $$
DECLARE
  lvl INTEGER := 1;
  cumulative INTEGER := 0;
  needed INTEGER;
BEGIN
  LOOP
    needed := floor(100 * power(lvl, 1.2))::INTEGER;
    cumulative := cumulative + needed;
    IF xp < cumulative THEN
      RETURN lvl;
    END IF;
    lvl := lvl + 1;
    IF lvl > 999 THEN RETURN 999; END IF;
  END LOOP;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- XP needed for next level
CREATE OR REPLACE FUNCTION xp_for_next_level(current_level INTEGER)
RETURNS INTEGER AS $$
BEGIN
  RETURN floor(100 * power(current_level, 1.2))::INTEGER;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Cumulative XP needed to reach a level
CREATE OR REPLACE FUNCTION cumulative_xp_for_level(target_level INTEGER)
RETURNS INTEGER AS $$
DECLARE
  total INTEGER := 0;
  i INTEGER;
BEGIN
  FOR i IN 1..target_level-1 LOOP
    total := total + floor(100 * power(i, 1.2))::INTEGER;
  END LOOP;
  RETURN total;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 4. Grant XP RPC (server-side, updates level too)
CREATE OR REPLACE FUNCTION grant_xp(
  target_user_id UUID,
  xp_amount INTEGER,
  xp_source TEXT,
  xp_description TEXT DEFAULT NULL
)
RETURNS TABLE(new_total_xp INTEGER, new_level INTEGER, leveled_up BOOLEAN) AS $$
DECLARE
  old_level INTEGER;
  new_xp INTEGER;
  new_lvl INTEGER;
BEGIN
  -- Get current state
  SELECT level INTO old_level FROM profiles WHERE id = target_user_id;

  -- Insert XP record
  INSERT INTO user_xp (user_id, amount, source, description)
  VALUES (target_user_id, xp_amount, xp_source, xp_description);

  -- Update total
  UPDATE profiles
  SET total_xp = total_xp + xp_amount
  WHERE id = target_user_id
  RETURNING total_xp INTO new_xp;

  -- Recalculate level
  new_lvl := calculate_level(new_xp);
  UPDATE profiles SET level = new_lvl WHERE id = target_user_id;

  RETURN QUERY SELECT new_xp, new_lvl, (new_lvl > old_level);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. Badges Table
CREATE TABLE IF NOT EXISTS badges (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  emoji TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('cyber', 'nature', 'rebel', 'god', 'social', 'streak', 'duel', 'explorer', 'seasonal', 'secret')),
  tier TEXT NOT NULL CHECK (tier IN ('bronze', 'silver', 'gold', 'diamond', 'legendary')),
  xp_reward INTEGER NOT NULL DEFAULT 50,
  required_value INTEGER,
  sort_order INTEGER DEFAULT 0
);

-- 6. User Badges (earned)
CREATE TABLE IF NOT EXISTS user_badges (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  badge_id TEXT NOT NULL REFERENCES badges(id) ON DELETE CASCADE,
  earned_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(user_id, badge_id)
);

CREATE INDEX IF NOT EXISTS idx_user_badges_user_id ON user_badges(user_id);

ALTER TABLE user_badges ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Anyone can see badges' AND tablename = 'user_badges') THEN
    CREATE POLICY "Anyone can see badges" ON user_badges FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'System grants badges' AND tablename = 'user_badges') THEN
    CREATE POLICY "System grants badges" ON user_badges FOR INSERT WITH CHECK (auth.uid() = user_id);
  END IF;
END $$;

-- 7. XP Source Values (for reference)
-- Focus: 1 XP per minute (max 120/session = 120 XP)
-- Duel Win: 50 XP
-- Duel Participate: 15 XP
-- Daily Goal Met: 30 XP
-- Streak Day: 10 XP * streak_day (capped at 100)
-- Story Posted: 10 XP
-- Reaction Sent: 2 XP
-- Badge Earned: varies (50-500 XP)
-- Season Task: varies (100-300 XP)
-- Referral: 200 XP
-- First Time bonuses: 50 XP each

-- 8. Friendship management RPCs
CREATE OR REPLACE FUNCTION send_friend_request(target_user_id UUID)
RETURNS VOID AS $$
BEGIN
  IF target_user_id = auth.uid() THEN
    RAISE EXCEPTION 'Kendinize arkadaşlık isteği gönderemezsiniz';
  END IF;

  IF EXISTS (SELECT 1 FROM friendships WHERE
    (user_id = auth.uid() AND friend_id = target_user_id) OR
    (user_id = target_user_id AND friend_id = auth.uid())) THEN
    RAISE EXCEPTION 'Zaten arkadaşsınız veya bekleyen istek var';
  END IF;

  INSERT INTO friendships (user_id, friend_id, status)
  VALUES (auth.uid(), target_user_id, 'pending');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION accept_friend_request(request_user_id UUID)
RETURNS VOID AS $$
BEGIN
  UPDATE friendships SET status = 'accepted'
  WHERE user_id = request_user_id AND friend_id = auth.uid() AND status = 'pending';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION remove_friend(target_user_id UUID)
RETURNS VOID AS $$
BEGIN
  DELETE FROM friendships WHERE
    (user_id = auth.uid() AND friend_id = target_user_id) OR
    (user_id = target_user_id AND friend_id = auth.uid());
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Friendship status check
CREATE OR REPLACE FUNCTION get_friendship_status(target_user_id UUID)
RETURNS TEXT AS $$
DECLARE
  result RECORD;
BEGIN
  SELECT * INTO result FROM friendships WHERE
    (user_id = auth.uid() AND friend_id = target_user_id) OR
    (user_id = target_user_id AND friend_id = auth.uid())
  LIMIT 1;

  IF NOT FOUND THEN RETURN 'none'; END IF;
  IF result.status = 'accepted' THEN RETURN 'friends'; END IF;
  IF result.user_id = auth.uid() THEN RETURN 'sent'; END IF;
  RETURN 'received';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
