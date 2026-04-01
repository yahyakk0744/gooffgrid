import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Gerçek Supabase Auth servisi.
/// Desteklenen yöntemler: Email/Şifre, Google, Apple.
/// OTP/SMS YOK.
class SupabaseAuthService {
  SupabaseAuthService._();
  static final instance = SupabaseAuthService._();

  SupabaseClient get _client => Supabase.instance.client;

  /// Mevcut oturum
  Session? get currentSession => _client.auth.currentSession;
  User? get currentUser => _client.auth.currentUser;
  bool get isLoggedIn => currentUser != null;

  /// Auth state değişikliklerini dinle
  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  // ──────────────────────────────────────────────
  // 1. EMAIL / ŞİFRE
  // ──────────────────────────────────────────────

  /// Yeni hesap oluştur
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return _client.auth.signUp(
      email: email,
      password: password,
    );
  }

  /// Mevcut hesapla giriş
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Şifre sıfırlama maili gönder
  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  // ──────────────────────────────────────────────
  // 2. GOOGLE SIGN-IN
  // ──────────────────────────────────────────────

  Future<AuthResponse> signInWithGoogle() async {
    final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];

    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(
      serverClientId: webClientId,
    );

    final googleUser = await googleSignIn.authenticate();
    final idToken = googleUser.authentication.idToken;

    if (idToken == null) {
      throw AuthException('Google ID token alınamadı.');
    }

    return _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
  }

  // ──────────────────────────────────────────────
  // 3. APPLE SIGN-IN
  // ──────────────────────────────────────────────

  Future<AuthResponse> signInWithApple() async {
    final rawNonce = _generateNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw AuthException('Apple ID token alınamadı.');
    }

    return _client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
  }

  // ──────────────────────────────────────────────
  // ÇIKIŞ
  // ──────────────────────────────────────────────

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // ──────────────────────────────────────────────
  // YARDIMCI
  // ──────────────────────────────────────────────

  /// Apple Sign-In için kriptografik nonce üretir.
  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }
}
