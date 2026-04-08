/// Opal-style focus session model.
enum SessionState { idle, running, paused, completed, aborted }

class FocusSession {
  const FocusSession({
    required this.id,
    required this.tagId,
    required this.blocklistId,
    required this.durationMin,
    required this.startedAt,
    this.endedAt,
    this.isHardLock = false,
    this.state = SessionState.idle,
    this.gemsEarned = 0,
    this.pausedSeconds = 0,
  });

  final String id;
  final String? tagId;
  final String? blocklistId;
  final int durationMin;
  final DateTime startedAt;
  final DateTime? endedAt;
  final bool isHardLock;
  final SessionState state;
  final int gemsEarned;
  final int pausedSeconds;

  Duration get elapsed =>
      (endedAt ?? DateTime.now()).difference(startedAt) -
      Duration(seconds: pausedSeconds);

  double get progress {
    final total = durationMin * 60;
    if (total <= 0) return 0;
    return (elapsed.inSeconds / total).clamp(0.0, 1.0);
  }

  int get remainingSeconds {
    final total = durationMin * 60;
    return (total - elapsed.inSeconds).clamp(0, total);
  }

  FocusSession copyWith({
    String? id,
    String? tagId,
    String? blocklistId,
    int? durationMin,
    DateTime? startedAt,
    DateTime? endedAt,
    bool? isHardLock,
    SessionState? state,
    int? gemsEarned,
    int? pausedSeconds,
  }) =>
      FocusSession(
        id: id ?? this.id,
        tagId: tagId ?? this.tagId,
        blocklistId: blocklistId ?? this.blocklistId,
        durationMin: durationMin ?? this.durationMin,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt ?? this.endedAt,
        isHardLock: isHardLock ?? this.isHardLock,
        state: state ?? this.state,
        gemsEarned: gemsEarned ?? this.gemsEarned,
        pausedSeconds: pausedSeconds ?? this.pausedSeconds,
      );
}
