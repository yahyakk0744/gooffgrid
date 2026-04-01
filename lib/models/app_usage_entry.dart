import 'dart:typed_data';
import 'package:flutter/material.dart';

class AppUsageEntry {
  final String name;
  final String packageName;
  final int minutes;
  final Color iconColor;
  final String? category;
  final Uint8List? iconBytes;
  final int pickups;

  const AppUsageEntry({
    required this.name,
    required this.packageName,
    required this.minutes,
    required this.iconColor,
    this.category,
    this.iconBytes,
    this.pickups = 0,
  });

  bool get hasNativeIcon => iconBytes != null && iconBytes!.isNotEmpty;

  String get formattedDuration {
    if (minutes >= 60) {
      final h = minutes ~/ 60;
      final m = minutes % 60;
      return m > 0 ? '${h}s ${m}dk' : '${h}s';
    }
    return '${minutes}dk';
  }

  factory AppUsageEntry.fromJson(Map<String, dynamic> json) => AppUsageEntry(
        name: json['name'] as String,
        packageName: json['packageName'] as String,
        minutes: json['minutes'] as int,
        iconColor: Color(json['iconColor'] as int),
        category: json['category'] as String?,
        iconBytes: json['iconBytes'] != null
            ? Uint8List.fromList(List<int>.from(json['iconBytes'] as List))
            : null,
        pickups: (json['pickups'] as int?) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'packageName': packageName,
        'minutes': minutes,
        'iconColor': iconColor.value,
        'category': category,
        'pickups': pickups,
      };

  AppUsageEntry copyWith({
    String? name,
    String? packageName,
    int? minutes,
    Color? iconColor,
    String? category,
    Uint8List? iconBytes,
    int? pickups,
  }) =>
      AppUsageEntry(
        name: name ?? this.name,
        packageName: packageName ?? this.packageName,
        minutes: minutes ?? this.minutes,
        iconColor: iconColor ?? this.iconColor,
        category: category ?? this.category,
        iconBytes: iconBytes ?? this.iconBytes,
        pickups: pickups ?? this.pickups,
      );
}
