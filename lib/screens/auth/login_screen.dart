import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/interactive_gooffgrid_logo.dart';
import '../../l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) return;

    final notifier = ref.read(authProvider.notifier);
    if (_isSignUp) {
      notifier.signUpWithEmail(email, password);
    } else {
      notifier.signInWithEmail(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    // Giriş başarılı — router redirect halleder
    ref.listen(authProvider, (prev, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: AppColors.neonOrange,
          ),
        );
      }
    });

    final l = AppLocalizations.of(context)!;
    return GoOffGridEyeTracker(
      child: Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 80),

              // Logo
              const InteractiveGoOffGridLogo(
                fontSize: 32,
                letterSpacing: 3,
              ),
              const SizedBox(height: 8),
              Text(
                l.welcomeSubtitle,
                style: AppType.body.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // ─── SOCIAL BUTTONS ───
              _SocialButton(
                onPressed: auth.isLoading ? null : () => ref.read(authProvider.notifier).signInWithGoogle(),
                icon: Icons.g_mobiledata_rounded,
                label: l.continueWithGoogleShort,
                bgColor: Colors.white,
                textColor: Colors.black87,
              ),
              const SizedBox(height: 12),
              _SocialButton(
                onPressed: auth.isLoading ? null : () => ref.read(authProvider.notifier).signInWithApple(),
                icon: Icons.apple_rounded,
                label: l.continueWithAppleShort,
                bgColor: Colors.white,
                textColor: Colors.black87,
              ),

              const SizedBox(height: 24),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.cardBorder)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(l.orDivider, style: AppType.body.copyWith(color: AppColors.textSecondary)),
                  ),
                  const Expanded(child: Divider(color: AppColors.cardBorder)),
                ],
              ),

              const SizedBox(height: 24),

              // ─── EMAIL / PASSWORD ───
              _InputField(
                controller: _emailController,
                hint: l.emailHint,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: _passwordController,
                hint: l.passwordHint,
                obscure: _obscurePassword,
                icon: Icons.lock_outline_rounded,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    color: AppColors.textTertiary,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),

              if (!_isSignUp) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      final email = _emailController.text.trim();
                      if (email.isNotEmpty) {
                        ref.read(authProvider.notifier).resetPassword(email);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l.passwordResetSent)),
                        );
                      }
                    },
                    child: Text(
                      l.forgotPassword,
                      style: AppType.caption.copyWith(color: AppColors.neonGreen),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: auth.isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor: AppColors.neonGreen.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  child: auth.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                        )
                      : Text(_isSignUp ? l.signUp : l.signIn),
                ),
              ),

              const SizedBox(height: 16),

              // Toggle sign up / sign in
              GestureDetector(
                onTap: () => setState(() => _isSignUp = !_isSignUp),
                child: RichText(
                  text: TextSpan(
                    style: AppType.body.copyWith(color: AppColors.textSecondary),
                    children: [
                      TextSpan(text: _isSignUp ? l.alreadyHaveAccount : l.noAccountYet),
                      TextSpan(
                        text: _isSignUp ? l.signIn : l.signUp,
                        style: const TextStyle(color: AppColors.neonGreen, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

// ──────────────────────────────────────────────
// YARDIMCI WİDGET'LAR
// ──────────────────────────────────────────────

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24, color: textColor),
        label: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.keyboardType,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textTertiary),
        prefixIcon: Icon(icon, color: AppColors.textTertiary, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.cardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.neonGreen, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
