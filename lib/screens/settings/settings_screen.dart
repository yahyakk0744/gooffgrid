import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../config/theme.dart';
import '../../widgets/app_card.dart';
import '../../providers/user_provider.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';

bool _isAdmin() {
  final email = sb.Supabase.instance.client.auth.currentUser?.email;
  return email == 'admin@gooffgrid.com';
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.settings, style: AppTextStyles.h1),
              const SizedBox(height: 24),

              // Profile summary — tappable to edit
              AppCard(
                onTap: () {
                  HapticService.light();
                  context.push('/profile/edit');
                },
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: user.avatarColor, shape: BoxShape.circle),
                      child: Center(child: Text(user.name[0].toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name, style: AppTextStyles.h3),
                          Text('${user.city}, ${user.country}', style: AppTextStyles.bodySecondary),
                        ],
                      ),
                    ),
                    Text(l.edit, style: TextStyle(fontSize: 13, color: AppColors.neonGreen, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.neonGreen),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Subscription
              AppCard(
                onTap: () {
                  HapticService.light();
                  context.push('/profile/settings/subscription');
                },
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: AppColors.gold, size: 24),
                    const SizedBox(width: 12),
                    Expanded(child: Text(l.subscription, style: AppTextStyles.h3)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.cardBorder, borderRadius: BorderRadius.circular(8)),
                      child: Text(l.free, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Admin entry — only for admin@gooffgrid.com
              if (_isAdmin())
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    onTap: () {
                      HapticService.light();
                      context.push('/profile/settings/subscription'); // admin route moved
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.admin_panel_settings, color: AppColors.ringDanger, size: 24),
                        const SizedBox(width: 12),
                        Text(l.adminAddLoot, style: AppTextStyles.h3),
                        const Spacer(),
                        const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
                      ],
                    ),
                  ),
                ),

              // Toggles
              AppCard(
                child: Column(
                  children: [
                    _ToggleRow(label: l.notifications, value: true, onChanged: (_) {}),
                    const Divider(color: AppColors.cardBorder, height: 1),
                    _ToggleRow(label: l.dailyReminder, value: true, onChanged: (_) {}),
                    const Divider(color: AppColors.cardBorder, height: 1),
                    _ToggleRow(label: l.duelNotifications, value: false, onChanged: (_) {}),
                    const Divider(color: AppColors.cardBorder, height: 1),
                    _ToggleRow(label: l.locationSharing, value: true, onChanged: (_) {}),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Legal
              Text(l.legal, style: AppTextStyles.label),
              const SizedBox(height: 8),
              AppCard(
                child: Column(
                  children: [
                    _LinkRow(label: l.privacyPolicy, icon: Icons.privacy_tip_outlined, onTap: () => context.push('/profile/settings/privacy')),
                    const Divider(color: AppColors.cardBorder, height: 1),
                    _LinkRow(label: l.termsOfService, icon: Icons.description_outlined, onTap: () => context.push('/profile/settings/terms')),
                    const Divider(color: AppColors.cardBorder, height: 1),
                    _LinkRow(label: l.kvkkText, icon: Icons.shield_outlined, onTap: () => context.push('/profile/settings/kvkk')),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Danger zone
              Center(
                child: GestureDetector(
                  onTap: () {
                    HapticService.warning();
                    context.go('/onboarding');
                  },
                  child: Text(l.logout, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.ringDanger)),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {
                    HapticService.light();
                    context.push('/profile/settings/delete-account');
                  },
                  child: Text(l.deleteMyAccount, style: const TextStyle(fontSize: 13, color: AppColors.textTertiary)),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text('gooffgrid v1.0.0', style: AppTextStyles.labelSmall),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: AppTextStyles.body)),
            const Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({required this.label, required this.value, required this.onChanged});
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTextStyles.body)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.neonGreen,
            activeTrackColor: AppColors.neonGreen.withValues(alpha: 0.3),
            inactiveThumbColor: AppColors.textTertiary,
            inactiveTrackColor: AppColors.cardBorder,
          ),
        ],
      ),
    );
  }
}
