-- =============================================
-- Migration 003: Cron Job for Push Notifications
-- =============================================

-- Akşam 20:00'de provokatif bildirim gönder (UTC 17:00 = TR 20:00)
SELECT cron.schedule(
  'daily-provocative-notifications',
  '0 17 * * *',
  $$
  SELECT net.http_post(
    url := current_setting('supabase.functions_url') || '/send-notifications',
    headers := jsonb_build_object(
      'Authorization', 'Bearer ' || current_setting('supabase.service_role_key'),
      'Content-Type', 'application/json'
    ),
    body := '{}'::jsonb
  );
  $$
);

-- Haftalık rapor kartı üretimi (Pazartesi 06:00 UTC = TR 09:00)
SELECT cron.schedule(
  'weekly-report-cards',
  '0 6 * * 1',
  $$
  DO $$
  DECLARE
    r RECORD;
  BEGIN
    FOR r IN SELECT id FROM profiles LOOP
      PERFORM generate_report_card(r.id);
    END LOOP;
  END $$;
  $$
);

-- Story view_count increment fonksiyonu
CREATE OR REPLACE FUNCTION increment_story_view_count(p_story_id UUID)
RETURNS VOID AS $$
BEGIN
  UPDATE anti_social_posts
  SET view_count = COALESCE(view_count, 0) + 1
  WHERE id = p_story_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
