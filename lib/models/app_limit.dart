/// Opal-style daily cap on a category/app.
class AppLimit {
  const AppLimit({
    required this.id,
    required this.label,
    required this.emoji,
    required this.dailyMinutes,
    this.usedMinutes = 0,
    this.enabled = true,
  });

  final String id;
  final String label;
  final String emoji;
  final int dailyMinutes;
  final int usedMinutes;
  final bool enabled;

  int get remainingMinutes =>
      (dailyMinutes - usedMinutes).clamp(0, dailyMinutes);
  double get progress =>
      dailyMinutes == 0 ? 0 : (usedMinutes / dailyMinutes).clamp(0.0, 1.0);
  bool get exceeded => usedMinutes >= dailyMinutes;

  AppLimit copyWith({
    String? id,
    String? label,
    String? emoji,
    int? dailyMinutes,
    int? usedMinutes,
    bool? enabled,
  }) =>
      AppLimit(
        id: id ?? this.id,
        label: label ?? this.label,
        emoji: emoji ?? this.emoji,
        dailyMinutes: dailyMinutes ?? this.dailyMinutes,
        usedMinutes: usedMinutes ?? this.usedMinutes,
        enabled: enabled ?? this.enabled,
      );
}
