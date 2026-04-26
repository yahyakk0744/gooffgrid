import 'package:flutter_test/flutter_test.dart';
import 'package:gooffgrid/providers/o2_provider.dart';

void main() {
  group('O2State', () {
    test('default state has zero balance and full daily remaining', () {
      const s = O2State();
      expect(s.balance, 0);
      expect(s.todayEarned, 0);
      expect(s.dailyRemaining, 500);
      expect(s.lifetimeO2, 0);
      expect(s.isLoading, false);
    });

    test('copyWith updates only provided fields', () {
      const original = O2State(balance: 100, todayEarned: 50);
      final updated = original.copyWith(balance: 200);

      expect(updated.balance, 200);
      expect(updated.todayEarned, 50); // unchanged
      expect(updated.dailyRemaining, 500); // unchanged default
    });

    test('copyWith preserves isLoading when not specified', () {
      const original = O2State(isLoading: true);
      final updated = original.copyWith(balance: 50);
      expect(updated.isLoading, true);
    });

    test('copyWith can clear isLoading', () {
      const original = O2State(isLoading: true);
      final updated = original.copyWith(isLoading: false);
      expect(updated.isLoading, false);
    });
  });
}
