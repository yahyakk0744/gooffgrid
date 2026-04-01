import 'package:gooffgrid/models/app_usage_entry.dart';

class ReportCard {
  final DateTime weekStart;
  final int totalMinutes;
  final int avgDailyMinutes;
  final int streak;
  final int rankChange;
  final int duelsWon;
  final int duelsLost;
  final String grade;
  final List<AppUsageEntry> topApps;

  const ReportCard({
    required this.weekStart,
    required this.totalMinutes,
    required this.avgDailyMinutes,
    required this.streak,
    required this.rankChange,
    required this.duelsWon,
    required this.duelsLost,
    required this.grade,
    required this.topApps,
  });

  static String calculateGrade(int totalMinutes, int streak, int rankChange) {
    var score = 0;

    // Lower screen time = better
    if (totalMinutes < 600) {
      score += 40;
    } else if (totalMinutes < 900) {
      score += 30;
    } else if (totalMinutes < 1200) {
      score += 20;
    } else if (totalMinutes < 1680) {
      score += 10;
    }

    // Streak bonus
    if (streak >= 14) {
      score += 30;
    } else if (streak >= 7) {
      score += 20;
    } else if (streak >= 3) {
      score += 10;
    }

    // Rank improvement
    if (rankChange > 5) {
      score += 30;
    } else if (rankChange > 0) {
      score += 20;
    } else if (rankChange == 0) {
      score += 10;
    }

    if (score >= 80) return 'A+';
    if (score >= 70) return 'A';
    if (score >= 60) return 'B+';
    if (score >= 50) return 'B';
    if (score >= 40) return 'C+';
    if (score >= 30) return 'C';
    if (score >= 20) return 'D';
    return 'F';
  }

  factory ReportCard.fromJson(Map<String, dynamic> json) => ReportCard(
        weekStart: DateTime.parse(json['weekStart'] as String),
        totalMinutes: json['totalMinutes'] as int,
        avgDailyMinutes: json['avgDailyMinutes'] as int,
        streak: json['streak'] as int,
        rankChange: json['rankChange'] as int,
        duelsWon: json['duelsWon'] as int,
        duelsLost: json['duelsLost'] as int,
        grade: json['grade'] as String,
        topApps: (json['topApps'] as List).map((e) => AppUsageEntry.fromJson(e as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'weekStart': weekStart.toIso8601String(),
        'totalMinutes': totalMinutes,
        'avgDailyMinutes': avgDailyMinutes,
        'streak': streak,
        'rankChange': rankChange,
        'duelsWon': duelsWon,
        'duelsLost': duelsLost,
        'grade': grade,
        'topApps': topApps.map((e) => e.toJson()).toList(),
      };

  ReportCard copyWith({
    DateTime? weekStart,
    int? totalMinutes,
    int? avgDailyMinutes,
    int? streak,
    int? rankChange,
    int? duelsWon,
    int? duelsLost,
    String? grade,
    List<AppUsageEntry>? topApps,
  }) =>
      ReportCard(
        weekStart: weekStart ?? this.weekStart,
        totalMinutes: totalMinutes ?? this.totalMinutes,
        avgDailyMinutes: avgDailyMinutes ?? this.avgDailyMinutes,
        streak: streak ?? this.streak,
        rankChange: rankChange ?? this.rankChange,
        duelsWon: duelsWon ?? this.duelsWon,
        duelsLost: duelsLost ?? this.duelsLost,
        grade: grade ?? this.grade,
        topApps: topApps ?? this.topApps,
      );
}
