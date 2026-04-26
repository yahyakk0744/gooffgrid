import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Ambient focus sounds — loops quietly during Deep Focus / breathing.
///
/// Asset files live in `assets/sounds/` (see README there). If a file is
/// missing or playback fails, methods swallow the error silently so the UI
/// never crashes in emulator / dev builds.
enum FocusSound {
  none('Sessiz', '🤫', null),
  rain('Yağmur', '🌧️', 'sounds/rain.mp3'),
  cafe('Kafe', '☕', 'sounds/cafe.mp3'),
  brown('Brown noise', '〰️', 'sounds/brown.mp3'),
  waves('Dalgalar', '🌊', 'sounds/waves.mp3');

  const FocusSound(this.label, this.emoji, this.assetPath);

  final String label;
  final String emoji;
  final String? assetPath;
}

class FocusSoundService {
  FocusSoundService._();
  static final FocusSoundService instance = FocusSoundService._();

  final _player = AudioPlayer();
  FocusSound _current = FocusSound.none;
  double _volume = 0.35;

  FocusSound get current => _current;
  double get volume => _volume;

  Future<void> play(FocusSound sound) async {
    if (sound == _current) return;
    _current = sound;
    try {
      if (sound.assetPath == null) {
        await _player.stop();
        return;
      }
      await _player.stop();
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.setVolume(_volume);
      await _player.play(AssetSource(sound.assetPath!));
    } catch (e) {
      if (kDebugMode) debugPrint('FocusSound play error ($sound): $e');
      _current = FocusSound.none;
    }
  }

  Future<void> stop() async {
    _current = FocusSound.none;
    try {
      await _player.stop();
    } catch (_) {}
  }

  Future<void> setVolume(double v) async {
    _volume = v.clamp(0.0, 1.0);
    try {
      await _player.setVolume(_volume);
    } catch (_) {}
  }

  Future<void> dispose() async {
    try {
      await _player.dispose();
    } catch (_) {}
  }
}
