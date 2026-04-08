import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';

class AddFriendScreen extends StatelessWidget {
  const AddFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary)),
                  const SizedBox(width: 12),
                  Text(l.addFriend, style: AppTextStyles.h1),
                ],
              ),
              const SizedBox(height: 32),

              // QR
              AppCard(
                child: Column(
                  children: [
                    const Icon(Icons.qr_code_2_rounded, size: 120, color: AppColors.textPrimary),
                    const SizedBox(height: 12),
                    Text(l.showQrCode, style: AppTextStyles.bodySecondary),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Code input
              Text(l.enterCode, style: AppTextStyles.label),
              const SizedBox(height: 8),
              TextField(
                style: const TextStyle(color: AppColors.textPrimary, letterSpacing: 4, fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'ABCDEF',
                  hintStyle: const TextStyle(color: AppColors.textTertiary, letterSpacing: 4),
                  filled: true,
                  fillColor: AppColors.cardBg,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neonGreen)),
                ),
              ),
              const SizedBox(height: 24),

              // Link share
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share_rounded),
                  label: Text(l.inviteLinkShare),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.neonGreen,
                    side: const BorderSide(color: AppColors.neonGreen),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
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
