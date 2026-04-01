import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/o2_transaction.dart';
import '../services/o2_service.dart';

// ──────────────────────────────────────────────
// O2 STATE
// ──────────────────────────────────────────────

class O2State {
  final int balance;
  final int todayEarned;
  final int dailyRemaining;
  final int lifetimeO2;
  final bool isLoading;

  const O2State({
    this.balance = 0,
    this.todayEarned = 0,
    this.dailyRemaining = 500,
    this.lifetimeO2 = 0,
    this.isLoading = false,
  });

  O2State copyWith({
    int? balance,
    int? todayEarned,
    int? dailyRemaining,
    int? lifetimeO2,
    bool? isLoading,
  }) =>
      O2State(
        balance: balance ?? this.balance,
        todayEarned: todayEarned ?? this.todayEarned,
        dailyRemaining: dailyRemaining ?? this.dailyRemaining,
        lifetimeO2: lifetimeO2 ?? this.lifetimeO2,
        isLoading: isLoading ?? this.isLoading,
      );
}

class O2Notifier extends StateNotifier<O2State> {
  O2Notifier() : super(const O2State()) {
    refresh();
  }

  final _service = O2Service.instance;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    try {
      final results = await Future.wait([
        _service.getBalance(),
        _service.getTodayEarned(),
        _service.getLifetimeO2(),
      ]);
      state = state.copyWith(
        balance: results[0],
        todayEarned: results[1],
        dailyRemaining: (500 - results[1]).clamp(0, 500),
        lifetimeO2: results[2],
        isLoading: false,
      );
    } catch (e) {
      debugPrint('O2 refresh error: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  /// O2 kazanımını UI'a yansıt.
  void onEarned(O2EarnResult result) {
    if (result.success) {
      state = state.copyWith(
        balance: result.newBalance,
        todayEarned: result.dailyTotal,
        dailyRemaining: result.dailyRemaining,
      );
    }
  }
}

final o2Provider = StateNotifierProvider<O2Notifier, O2State>((ref) {
  return O2Notifier();
});

// ──────────────────────────────────────────────
// FOCUS SESSION PROVIDER
// ──────────────────────────────────────────────

class FocusSessionState {
  final bool isActive;
  final String? sessionId;
  final DateTime? startedAt;
  final int elapsedSeconds;
  final bool isTimeout;

  const FocusSessionState({
    this.isActive = false,
    this.sessionId,
    this.startedAt,
    this.elapsedSeconds = 0,
    this.isTimeout = false,
  });

  int get elapsedMinutes => elapsedSeconds ~/ 60;

  /// Anti-cheat: 120dk'ya kalan saniye
  int get remainingSeconds => (120 * 60) - elapsedSeconds;
  bool get isNearTimeout => remainingSeconds < 600; // Son 10dk

  FocusSessionState copyWith({
    bool? isActive,
    String? sessionId,
    DateTime? startedAt,
    int? elapsedSeconds,
    bool? isTimeout,
  }) =>
      FocusSessionState(
        isActive: isActive ?? this.isActive,
        sessionId: sessionId ?? this.sessionId,
        startedAt: startedAt ?? this.startedAt,
        elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
        isTimeout: isTimeout ?? this.isTimeout,
      );
}

class FocusSessionNotifier extends StateNotifier<FocusSessionState> {
  FocusSessionNotifier(this._o2Notifier) : super(const FocusSessionState());

  final O2Notifier _o2Notifier;
  final _service = O2Service.instance;
  Timer? _timer;

  Future<bool> start() async {
    // Anti-cheat: Saat kontrolü
    final hour = DateTime.now().hour;
    if (hour < 8) return false;

    final sessionId = await _service.startFocusSession();
    if (sessionId == null) return false;

    state = state.copyWith(
      isActive: true,
      sessionId: sessionId,
      startedAt: DateTime.now(),
      elapsedSeconds: 0,
      isTimeout: false,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final newSeconds = state.elapsedSeconds + 1;

      // ANTI-CHEAT KURAL 3: 120dk aşımı
      if (newSeconds >= 120 * 60) {
        _timeout();
        return;
      }

      state = state.copyWith(elapsedSeconds: newSeconds);
    });

    return true;
  }

  Future<FocusResult> stop() async {
    _timer?.cancel();

    if (state.sessionId == null) return FocusResult.error('no_session');

    final result = await _service.completeFocusSession(state.sessionId!);

    if (result.success) {
      // O2 state güncelle
      _o2Notifier.refresh();
    }

    state = const FocusSessionState();
    return result;
  }

  void _timeout() {
    _timer?.cancel();
    final sid = state.sessionId;
    state = state.copyWith(isActive: false, isTimeout: true);
    // Otomatik kapat — sunucuya bildir
    if (sid != null) {
      _service.completeFocusSession(sid).then((_) {
        _o2Notifier.refresh();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final focusSessionProvider =
    StateNotifierProvider<FocusSessionNotifier, FocusSessionState>((ref) {
  final o2 = ref.read(o2Provider.notifier);
  return FocusSessionNotifier(o2);
});

// ──────────────────────────────────────────────
// MARKET PROVIDER
// ──────────────────────────────────────────────

final marketOffersProvider = FutureProvider<List<MarketOffer>>((ref) async {
  return O2Service.instance.getMarketOffers();
});

final myRedemptionsProvider = FutureProvider<List<MarketRedemption>>((ref) async {
  return O2Service.instance.getMyRedemptions();
});

// ──────────────────────────────────────────────
// STORY ELIGIBILITY PROVIDER
// ──────────────────────────────────────────────

final storyEligibilityProvider = FutureProvider<StoryEligibility>((ref) async {
  return O2Service.instance.checkStoryEligibility();
});

// ──────────────────────────────────────────────
// TRANSACTION HISTORY PROVIDER
// ──────────────────────────────────────────────

final o2TransactionsProvider = FutureProvider<List<O2Transaction>>((ref) async {
  return O2Service.instance.getTransactions();
});
