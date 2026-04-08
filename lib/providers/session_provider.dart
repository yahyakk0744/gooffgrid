import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/focus_session.dart';

/// Active focus session state — one at a time.
/// Timer ticks every second while running.
class SessionNotifier extends StateNotifier<FocusSession?> {
  SessionNotifier() : super(null);

  Timer? _ticker;

  /// Last completed session — used by UI to show Wins recap.
  FocusSession? lastCompleted;

  void start({
    required int durationMin,
    String? tagId,
    String? blocklistId,
    bool isHardLock = false,
  }) {
    final s = FocusSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      tagId: tagId,
      blocklistId: blocklistId,
      durationMin: durationMin,
      startedAt: DateTime.now(),
      isHardLock: isHardLock,
      state: SessionState.running,
    );
    state = s;
    _startTicker();
  }

  void pause() {
    final s = state;
    if (s == null || s.state != SessionState.running) return;
    if (s.isHardLock) return; // hard-lock can't pause
    state = s.copyWith(state: SessionState.paused);
    _ticker?.cancel();
  }

  void resume() {
    final s = state;
    if (s == null || s.state != SessionState.paused) return;
    state = s.copyWith(state: SessionState.running);
    _startTicker();
  }

  FocusSession? complete() {
    final s = state;
    if (s == null) return null;
    final ended = s.copyWith(
      state: SessionState.completed,
      endedAt: DateTime.now(),
      gemsEarned: _calculateGems(s),
    );
    _ticker?.cancel();
    lastCompleted = ended;
    state = null;
    return ended;
  }

  FocusSession? abort() {
    final s = state;
    if (s == null) return null;
    if (s.isHardLock && s.remainingSeconds > 0) return null; // can't abort
    final ended = s.copyWith(
      state: SessionState.aborted,
      endedAt: DateTime.now(),
    );
    _ticker?.cancel();
    state = null;
    return ended;
  }

  int _calculateGems(FocusSession s) {
    // 10 gems per minute completed, capped at session duration.
    return (s.elapsed.inMinutes * 10).clamp(0, s.durationMin * 10);
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final s = state;
      if (s == null) return;
      if (s.remainingSeconds <= 0) {
        complete();
        return;
      }
      // Trigger rebuild by emitting a new identity (shallow copy).
      state = s.copyWith();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}

final sessionProvider =
    StateNotifierProvider<SessionNotifier, FocusSession?>((ref) {
  return SessionNotifier();
});
