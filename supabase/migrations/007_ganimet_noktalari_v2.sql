-- =============================================
-- gooffgrid — Migration 007: Ganimet Noktalari v2 — Google Places fields
-- =============================================

ALTER TABLE ganimet_noktalari
  ADD COLUMN IF NOT EXISTS place_id TEXT,
  ADD COLUMN IF NOT EXISTS adres TEXT,
  ADD COLUMN IF NOT EXISTS photo_url TEXT;

-- place_id: Google Places place_id
-- adres: Full address from Google
-- photo_url: Google Places photo reference URL
