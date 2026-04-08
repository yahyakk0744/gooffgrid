import 'package:flutter/material.dart';

/// Opal-style reusable named blocklist.
class Blocklist {
  const Blocklist({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    required this.appIds,
    this.isDefault = false,
  });

  final String id;
  final String name;
  final String emoji;
  final Color color;
  final List<String> appIds;
  final bool isDefault;

  Blocklist copyWith({
    String? id,
    String? name,
    String? emoji,
    Color? color,
    List<String>? appIds,
    bool? isDefault,
  }) =>
      Blocklist(
        id: id ?? this.id,
        name: name ?? this.name,
        emoji: emoji ?? this.emoji,
        color: color ?? this.color,
        appIds: appIds ?? this.appIds,
        isDefault: isDefault ?? this.isDefault,
      );
}
