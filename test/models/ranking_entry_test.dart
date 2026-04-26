import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gooffgrid/models/ranking_entry.dart';

void main() {
  group('RankingEntry', () {
    RankingEntry sample({int change = 0}) => RankingEntry(
          rank: 3,
          userId: 'u3',
          name: 'Hizir',
          avatarColor: const Color(0xFF00FF88),
          level: 5,
          totalMinutes: 540,
          change: change,
        );

    test('isUp/isDown/isStable reflect change sign', () {
      expect(sample(change: 2).isUp, true);
      expect(sample(change: 2).isDown, false);
      expect(sample(change: 2).isStable, false);

      expect(sample(change: -3).isDown, true);
      expect(sample(change: -3).isUp, false);

      expect(sample(change: 0).isStable, true);
    });

    test('formattedChange shows + prefix for positive', () {
      expect(sample(change: 5).formattedChange, '+5');
    });

    test('formattedChange shows - prefix for negative', () {
      expect(sample(change: -2).formattedChange, '-2');
    });

    test('formattedChange shows dash for stable', () {
      expect(sample(change: 0).formattedChange, '-');
    });

    test('toJson/fromJson round-trip preserves all fields', () {
      final original = sample(change: 7);
      final decoded = RankingEntry.fromJson(original.toJson());

      expect(decoded.rank, original.rank);
      expect(decoded.userId, original.userId);
      expect(decoded.name, original.name);
      expect(decoded.avatarColor.toARGB32(), original.avatarColor.toARGB32());
      expect(decoded.level, original.level);
      expect(decoded.totalMinutes, original.totalMinutes);
      expect(decoded.change, original.change);
    });

    test('copyWith updates only provided fields', () {
      final updated = sample().copyWith(rank: 1);
      expect(updated.rank, 1);
      expect(updated.userId, 'u3');
      expect(updated.totalMinutes, 540);
    });
  });
}
