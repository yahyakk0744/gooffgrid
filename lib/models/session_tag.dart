import 'package:flutter/material.dart';

/// Opal-style session tag — labels sessions by purpose (Work, Study, Sleep…).
class SessionTag {
  const SessionTag({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
  });

  final String id;
  final String name;
  final String emoji;
  final Color color;
}

/// Default seeded tags.
const defaultSessionTags = <SessionTag>[
  SessionTag(id: 'work', name: 'İş', emoji: '💼', color: Color(0xFF4FACFE)),
  SessionTag(id: 'study', name: 'Ders', emoji: '📚', color: Color(0xFFFFD700)),
  SessionTag(id: 'sleep', name: 'Uyku', emoji: '😴', color: Color(0xFF667EEA)),
  SessionTag(id: 'family', name: 'Aile', emoji: '👨‍👩‍👧', color: Color(0xFFA8EB12)),
  SessionTag(id: 'sport', name: 'Spor', emoji: '🏃', color: Color(0xFFFF6B00)),
  SessionTag(id: 'meditation', name: 'Meditasyon', emoji: '🧘', color: Color(0xFF39FF14)),
];
