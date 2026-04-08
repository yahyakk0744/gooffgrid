import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../config/theme.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';

class DeleteAccountScreen extends ConsumerStatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  ConsumerState<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends ConsumerState<DeleteAccountScreen> {
  bool _confirmed = false;
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 12),
                  Text(l.deleteAccount, style: AppTextStyles.h1),
                ],
              ),
              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.ringDanger.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.ringDanger.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: AppColors.ringDanger, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          l.cannotUndo,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ringDanger),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l.deleteWarningDesc,
                      style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
                    ),
                    const SizedBox(height: 12),
                    _bulletPoint(l.deleteItem1),
                    _bulletPoint(l.deleteItem2),
                    _bulletPoint(l.deleteItem3),
                    _bulletPoint(l.deleteItem4),
                    _bulletPoint(l.deleteItem5),
                    _bulletPoint(l.deleteItem6),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                l.deleteSubscriptionNote,
                style: const TextStyle(fontSize: 12, color: AppColors.textTertiary, height: 1.5),
              ),
              const SizedBox(height: 24),

              GestureDetector(
                onTap: () => setState(() => _confirmed = !_confirmed),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _confirmed ? AppColors.ringDanger : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _confirmed ? AppColors.ringDanger : AppColors.cardBorder,
                          width: 1.5,
                        ),
                      ),
                      child: _confirmed
                          ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l.deleteConfirmCheck,
                        style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _confirmed && !_isDeleting ? _deleteAccount : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ringDanger,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.cardBorder,
                    disabledForegroundColor: AppColors.textTertiary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: _isDeleting
                      ? const SizedBox(
                          width: 22, height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(l.deleteAccountBtn, style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('  •  ', style: TextStyle(color: AppColors.textSecondary)),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount() async {
    setState(() => _isDeleting = true);
    HapticService.warning();

    try {
      // Sign out (actual account deletion should be handled server-side via Supabase Edge Function)
      await sb.Supabase.instance.client.auth.signOut();
      if (mounted) {
        context.go('/onboarding');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.deleteErrorMsg)),
        );
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }
}
