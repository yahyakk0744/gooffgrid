import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gooffgrid/models/app_usage_entry.dart';

void main() {
  group('AppUsageEntry', () {
    AppUsageEntry sample({int minutes = 90}) => AppUsageEntry(
          name: 'Instagram',
          packageName: 'com.instagram.android',
          minutes: minutes,
          iconColor: const Color(0xFFE1306C),
          category: 'social',
          pickups: 12,
        );

    test('formattedDuration shows hours+minutes when >= 60', () {
      expect(sample(minutes: 90).formattedDuration, '1s 30dk');
    });

    test('formattedDuration shows only hours when minutes are 0', () {
      expect(sample(minutes: 120).formattedDuration, '2s');
    });

    test('formattedDuration shows only minutes when < 60', () {
      expect(sample(minutes: 45).formattedDuration, '45dk');
    });

    test('formattedDuration handles 1 minute edge case', () {
      expect(sample(minutes: 1).formattedDuration, '1dk');
    });

    test('formattedDuration handles 59 minutes (just under hour)', () {
      expect(sample(minutes: 59).formattedDuration, '59dk');
    });

    test('formattedDuration handles 60 minutes (exact hour)', () {
      expect(sample(minutes: 60).formattedDuration, '1s');
    });

    test('hasNativeIcon false when iconBytes null', () {
      expect(sample().hasNativeIcon, false);
    });

    test('toJson/fromJson round-trip preserves fields (no iconBytes)', () {
      final original = sample();
      final decoded = AppUsageEntry.fromJson(original.toJson());

      expect(decoded.name, original.name);
      expect(decoded.packageName, original.packageName);
      expect(decoded.minutes, original.minutes);
      expect(decoded.iconColor.toARGB32(), original.iconColor.toARGB32());
      expect(decoded.category, original.category);
      expect(decoded.pickups, original.pickups);
    });

    test('pickups defaults to 0 when missing in JSON', () {
      final json = sample().toJson()..remove('pickups');
      expect(AppUsageEntry.fromJson(json).pickups, 0);
    });

    test('copyWith updates only provided fields', () {
      final original = sample();
      final updated = original.copyWith(minutes: 200);

      expect(updated.minutes, 200);
      expect(updated.name, original.name);
      expect(updated.packageName, original.packageName);
    });
  });
}
