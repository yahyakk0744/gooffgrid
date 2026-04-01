import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../services/supabase_auth_service.dart';

// ──────────────────────────────────────────────
// AUTH STATE
// ──────────────────────────────────────────────

class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? userId;
  final bool isOnboarded;
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.userId,
    this.isOnboarded = false,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    String? userId,
    bool? isOnboarded,
    String? errorMessage,
  }) =>
      AuthState(
        isLoading: isLoading ?? this.isLoading,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        userId: userId ?? this.userId,
        isOnboarded: isOnboarded ?? this.isOnboarded,
        errorMessage: errorMessage,
      );
}

// ──────────────────────────────────────────────
// AUTH NOTIFIER
// ──────────────────────────────────────────────

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState(isLoading: true)) {
    _init();
  }

  final _auth = SupabaseAuthService.instance;
  StreamSubscription<sb.AuthState>? _sub;

  /// Demo modu — Supabase bağlantısı olmadan UI test etmek için.
  /// Production'da false yapılmalı.
  static const _demoMode = true;

  void _init() {
    if (_demoMode) {
      state = const AuthState(
        isLoading: false,
        isLoggedIn: true,
        userId: 'demo-user',
        isOnboarded: true,
      );
      return;
    }

    // Mevcut oturum varsa direkt giriş
    final user = _auth.currentUser;
    if (user != null) {
      _onSignedIn(user);
    } else {
      state = const AuthState(isLoading: false);
    }

    // Auth state değişikliklerini dinle
    _sub = _auth.onAuthStateChange.listen((event) {
      final supabaseUser = event.session?.user;
      if (event.event == sb.AuthChangeEvent.signedIn && supabaseUser != null) {
        _onSignedIn(supabaseUser);
      } else if (event.event == sb.AuthChangeEvent.signedOut) {
        state = const AuthState();
      }
    });
  }

  void _onSignedIn(sb.User user) {
    state = state.copyWith(
      isLoading: false,
      isLoggedIn: true,
      userId: user.id,
      errorMessage: null,
    );
    _checkOnboarded(user.id);
  }

  Future<void> _checkOnboarded(String userId) async {
    try {
      final row = await sb.Supabase.instance.client
          .from('profiles')
          .select('username')
          .eq('id', userId)
          .maybeSingle();

      // Profil tablosunda username varsa onboard tamamlanmış
      final onboarded = row != null && row['username'] != null;
      state = state.copyWith(isOnboarded: onboarded);
    } catch (_) {
      // Profil henüz yoksa onboard edilmemiş demektir
      state = state.copyWith(isOnboarded: false);
    }
  }

  // ──────────────────────────────────────────
  // PUBLIC METOTLAR
  // ──────────────────────────────────────────

  Future<void> signInWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _auth.signInWithEmail(email: email, password: password);
    } on sb.AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Giriş başarısız: $e');
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _auth.signUpWithEmail(email: email, password: password);
    } on sb.AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Kayıt başarısız: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _auth.signInWithGoogle();
    } on sb.AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Google girişi başarısız: $e');
    }
  }

  Future<void> signInWithApple() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _auth.signInWithApple();
    } on sb.AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Apple girişi başarısız: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _auth.resetPassword(email);
      state = state.copyWith(isLoading: false);
    } on sb.AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Şifre sıfırlama başarısız: $e');
    }
  }

  void completeOnboarding() {
    state = state.copyWith(isOnboarded: true);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    state = const AuthState();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

// ──────────────────────────────────────────────
// PROVIDER
// ──────────────────────────────────────────────

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
