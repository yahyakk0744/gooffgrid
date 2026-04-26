import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gooffgrid/models/duel.dart';

void main() {
  group('DuelPlayer', () {
    DuelPlayer sample() => const DuelPlayer(
          userId: 'u1',
          name: 'Hizir',
          avatarColor: Color(0xFF00FF88),
          totalMinutes: 45,
        );

    test('toJson/fromJson round-trip preserves fields', () {
      final original = sample();
      final decoded = DuelPlayer.fromJson(original.toJson());

      expect(decoded.userId, original.userId);
      expect(decoded.name, original.name);
      expect(decoded.avatarColor.toARGB32(), original.avatarColor.toARGB32());
      expect(decoded.totalMinutes, original.totalMinutes);
    });

    test('copyWith only changes specified fields', () {
      final updated = sample().copyWith(totalMinutes: 100);
      expect(updated.totalMinutes, 100);
      expect(updated.userId, 'u1');
    });
  });

  group('Duel', () {
    final start = DateTime.utc(2026, 4, 26, 10, 0, 0);

    Duel sample({DuelStatus status = DuelStatus.active, String? winnerId}) => Duel(
          id: 'd1',
          player1: const DuelPlayer(
            userId: 'u1',
            name: 'A',
            avatarColor: Color(0xFFFF0000),
            totalMinutes: 30,
          ),
          player2: const DuelPlayer(
            userId: 'u2',
            name: 'B',
            avatarColor: Color(0xFF00FF00),
            totalMinutes: 45,
          ),
          durationMinutes: 60,
          startTime: start,
          endTime: status == DuelStatus.completed ? start.add(const Duration(hours: 1)) : null,
          status: status,
          winnerId: winnerId,
          shareCode: 'ABC123',
        );

    test('toJson/fromJson round-trip preserves all fields (active duel)', () {
      final original = sample();
      final decoded = Duel.fromJson(original.toJson());

      expect(decoded.id, original.id);
      expect(decoded.player1.userId, original.player1.userId);
      expect(decoded.player2.userId, original.player2.userId);
      expect(decoded.durationMinutes, original.durationMinutes);
      expect(decoded.startTime, original.startTime);
      expect(decoded.endTime, null);
      expect(decoded.status, DuelStatus.active);
      expect(decoded.winnerId, null);
      expect(decoded.shareCode, original.shareCode);
    });

    test('toJson/fromJson preserves completed duel with winner', () {
      final original = sample(status: DuelStatus.completed, winnerId: 'u1');
      final decoded = Duel.fromJson(original.toJson());

      expect(decoded.status, DuelStatus.completed);
      expect(decoded.winnerId, 'u1');
      expect(decoded.endTime, isNotNull);
    });

    test('DuelStatus.byName decodes all enum values', () {
      for (final s in DuelStatus.values) {
        final json = sample().toJson()..['status'] = s.name;
        expect(Duel.fromJson(json).status, s);
      }
    });
  });
}
