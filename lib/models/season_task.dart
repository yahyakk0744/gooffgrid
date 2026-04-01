class SeasonTask {
  final String id;
  final String description;
  final int target;
  final int current;
  final bool isCompleted;
  final bool isPremium;

  const SeasonTask({
    required this.id,
    required this.description,
    required this.target,
    required this.current,
    required this.isCompleted,
    required this.isPremium,
  });

  double get progress => target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;

  factory SeasonTask.fromJson(Map<String, dynamic> json) => SeasonTask(
        id: json['id'] as String,
        description: json['description'] as String,
        target: json['target'] as int,
        current: json['current'] as int,
        isCompleted: json['isCompleted'] as bool,
        isPremium: json['isPremium'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'target': target,
        'current': current,
        'isCompleted': isCompleted,
        'isPremium': isPremium,
      };

  SeasonTask copyWith({
    String? id,
    String? description,
    int? target,
    int? current,
    bool? isCompleted,
    bool? isPremium,
  }) =>
      SeasonTask(
        id: id ?? this.id,
        description: description ?? this.description,
        target: target ?? this.target,
        current: current ?? this.current,
        isCompleted: isCompleted ?? this.isCompleted,
        isPremium: isPremium ?? this.isPremium,
      );
}
