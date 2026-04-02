-- =============================================
-- gooffgrid — Migration 008: Social Layer v2
-- Stories: likes, comments, profanity filter, privacy
-- Profiles: first_name, last_name, username format
-- =============================================

-- =============================================
-- 1. PROFILES — New columns + username constraints
-- =============================================

ALTER TABLE profiles ADD COLUMN IF NOT EXISTS first_name TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS last_name TEXT;
-- username and city already exist from 001

-- Username format check (lowercase, alphanumeric, underscores, 3-20 chars)
-- profiles already has UNIQUE on username from 001, add format check
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'profiles_username_format') THEN
    ALTER TABLE profiles ADD CONSTRAINT profiles_username_format
      CHECK (username ~ '^[a-z0-9_]{3,20}$');
  END IF;
END $$;

-- =============================================
-- 2. ANTI_SOCIAL_POSTS (stories) — Privacy column
-- =============================================

-- visibility already exists from 002, add privacy as a separate explicit column
ALTER TABLE anti_social_posts ADD COLUMN IF NOT EXISTS privacy TEXT DEFAULT 'friends';

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'anti_social_posts_privacy_check') THEN
    ALTER TABLE anti_social_posts ADD CONSTRAINT anti_social_posts_privacy_check
      CHECK (privacy IN ('friends', 'everyone'));
  END IF;
END $$;

-- expires_at already exists from 002 (custom expiry supported via set_story_expiry trigger)

-- =============================================
-- 3. STORY_LIKES — Dedicated like table (separate from story_reactions)
-- =============================================

CREATE TABLE IF NOT EXISTS story_likes (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id   UUID NOT NULL REFERENCES anti_social_posts(id) ON DELETE CASCADE,
  user_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(story_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_story_likes_story ON story_likes(story_id);
CREATE INDEX IF NOT EXISTS idx_story_likes_user ON story_likes(user_id);

-- RLS
ALTER TABLE story_likes ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  DROP POLICY IF EXISTS "Users can see likes" ON story_likes;
  CREATE POLICY "Users can see likes"
    ON story_likes FOR SELECT USING (true);
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$ BEGIN
  DROP POLICY IF EXISTS "Users can like stories" ON story_likes;
  CREATE POLICY "Users can like stories"
    ON story_likes FOR INSERT WITH CHECK (auth.uid() = user_id);
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$ BEGIN
  DROP POLICY IF EXISTS "Users can unlike" ON story_likes;
  CREATE POLICY "Users can unlike"
    ON story_likes FOR DELETE USING (auth.uid() = user_id);
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- =============================================
-- 4. STORY_COMMENTS — With reply support
-- =============================================

CREATE TABLE IF NOT EXISTS story_comments (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id   UUID NOT NULL REFERENCES anti_social_posts(id) ON DELETE CASCADE,
  user_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  content    TEXT NOT NULL CHECK (char_length(content) BETWEEN 1 AND 500),
  parent_id  UUID REFERENCES story_comments(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_story_comments_story ON story_comments(story_id);
CREATE INDEX IF NOT EXISTS idx_story_comments_user ON story_comments(user_id);
CREATE INDEX IF NOT EXISTS idx_story_comments_parent ON story_comments(parent_id) WHERE parent_id IS NOT NULL;

-- RLS
ALTER TABLE story_comments ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  DROP POLICY IF EXISTS "Users can see comments" ON story_comments;
  CREATE POLICY "Users can see comments"
    ON story_comments FOR SELECT USING (true);
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$ BEGIN
  DROP POLICY IF EXISTS "Users can comment" ON story_comments;
  CREATE POLICY "Users can comment"
    ON story_comments FOR INSERT WITH CHECK (auth.uid() = user_id);
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$ BEGIN
  DROP POLICY IF EXISTS "Users can delete own comments" ON story_comments;
  CREATE POLICY "Users can delete own comments"
    ON story_comments FOR DELETE USING (auth.uid() = user_id);
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- =============================================
-- 5. PROFANITY FILTER — Multi-language
-- =============================================

CREATE OR REPLACE FUNCTION check_profanity(input_text TEXT)
RETURNS BOOLEAN AS $$
DECLARE
  lower_text TEXT;
  bad_words TEXT[] := ARRAY[
    -- Turkish
    'amk', 'aq', 'orospu', 'siktir', 'yarrak', 'mal', 'aptal', 'salak',
    'dangalak', 'pezevenk', 'ibne', 'gavat', 'kahpe', 'bok', 'sik',
    -- English
    'fuck', 'shit', 'bitch', 'dick', 'cock', 'pussy', 'bastard', 'slut',
    'whore', 'cunt', 'nigger', 'fag', 'retard',
    -- German
    'scheisse', 'fick', 'arsch', 'hurensohn', 'wichser', 'fotze', 'hure',
    -- French
    'merde', 'putain', 'connard', 'salaud', 'bordel', 'nique', 'pute',
    -- Spanish
    'mierda', 'puta', 'joder', 'pendejo', 'chingar', 'verga', 'culo',
    -- Italian
    'cazzo', 'merda', 'stronzo', 'puttana', 'vaffanculo', 'minchia', 'coglione',
    -- Portuguese
    'porra', 'caralho', 'foda', 'buceta',
    -- Russian (transliterated)
    'suka', 'blyad', 'pidar', 'nahui', 'mudak', 'govno',
    -- Arabic (transliterated)
    'sharmouta', 'zibbi', 'khara'
  ];
  word TEXT;
BEGIN
  lower_text := lower(input_text);
  FOREACH word IN ARRAY bad_words LOOP
    IF lower_text LIKE '%' || word || '%' THEN
      RETURN TRUE;
    END IF;
  END LOOP;
  RETURN FALSE;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Trigger: reject profane comments
CREATE OR REPLACE FUNCTION reject_profane_comment()
RETURNS TRIGGER AS $$
BEGIN
  IF check_profanity(NEW.content) THEN
    RAISE EXCEPTION 'Yorumunuz uygunsuz icerik barindiriyor.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS profanity_check_comments ON story_comments;
CREATE TRIGGER profanity_check_comments
  BEFORE INSERT OR UPDATE ON story_comments
  FOR EACH ROW EXECUTE FUNCTION reject_profane_comment();

-- Trigger: reject profane story captions
CREATE OR REPLACE FUNCTION reject_profane_story()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.caption IS NOT NULL AND check_profanity(NEW.caption) THEN
    RAISE EXCEPTION 'Hikayeniz uygunsuz icerik barindiriyor.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS profanity_check_stories ON anti_social_posts;
CREATE TRIGGER profanity_check_stories
  BEFORE INSERT OR UPDATE ON anti_social_posts
  FOR EACH ROW EXECUTE FUNCTION reject_profane_story();

-- =============================================
-- 6. HELPER FUNCTIONS
-- =============================================

-- Username availability check (for real-time UI)
CREATE OR REPLACE FUNCTION check_username_available(desired_username TEXT)
RETURNS BOOLEAN AS $$
BEGIN
  IF NOT (desired_username ~ '^[a-z0-9_]{3,20}$') THEN
    RETURN FALSE;
  END IF;
  RETURN NOT EXISTS (SELECT 1 FROM profiles WHERE username = desired_username);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Like count for a story
CREATE OR REPLACE FUNCTION get_story_like_count(target_story_id UUID)
RETURNS INTEGER AS $$
  SELECT COUNT(*)::INTEGER FROM story_likes WHERE story_id = target_story_id;
$$ LANGUAGE sql STABLE;

-- Check if current user liked a story
CREATE OR REPLACE FUNCTION has_user_liked_story(target_story_id UUID)
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM story_likes
    WHERE story_id = target_story_id AND user_id = auth.uid()
  );
$$ LANGUAGE sql STABLE;

-- Comment count for a story
CREATE OR REPLACE FUNCTION get_story_comment_count(target_story_id UUID)
RETURNS INTEGER AS $$
  SELECT COUNT(*)::INTEGER FROM story_comments WHERE story_id = target_story_id;
$$ LANGUAGE sql STABLE;
