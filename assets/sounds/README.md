# Focus Sounds

Drop 30-60 second looping MP3 files here with these exact names:

- `rain.mp3` — steady rain / forest rain ambient
- `cafe.mp3` — cafe chatter / coffee shop ambient
- `brown.mp3` — brown noise (deeper than white noise, more relaxing)
- `waves.mp3` — ocean waves

Free CC0 sources:
- https://pixabay.com/sound-effects (filter: "loop", "ambient")
- https://freesound.org (filter: license "Creative Commons 0")
- https://mixkit.co/free-sound-effects/ambience

Keep files under 1 MB each. Loops should be seamless.

`FocusSoundService` (lib/services/focus_sound_service.dart) loads these via
`AssetSource`. If a file is missing, the service silently fails — UI still works.
