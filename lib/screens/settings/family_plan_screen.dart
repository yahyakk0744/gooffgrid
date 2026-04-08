import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../providers/subscription_provider.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';

class FamilyPlanScreen extends ConsumerStatefulWidget {
  const FamilyPlanScreen({super.key});

  @override
  ConsumerState<FamilyPlanScreen> createState() => _FamilyPlanScreenState();
}

class _FamilyPlanScreenState extends ConsumerState<FamilyPlanScreen> {
  final _nameController = TextEditingController();

  // Mock family data for demo
  static const _mockFamily = [
    _FamilyMember('Annesi', 'Anne', Color(0xFFF093FB), 145, 8),
    _FamilyMember('Babası', 'Baba', Color(0xFF4FACFE), 98, 5),
    _FamilyMember('Kardeşi', 'Elif', Color(0xFFA8EB12), 210, 3),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final sub = ref.watch(subscriptionProvider);

    if (!sub.isProPlus) {
      return _buildLockedView(context);
    }

    final allMembers = [..._mockFamily, ...sub.familyMembers.map((n) => _FamilyMember(n, n, const Color(0xFF667EEA), 0, 0))];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary)),
                  const SizedBox(width: 12),
                  Text(l.familyPlanTitle, style: AppType.h2),
                  const Spacer(),
                  Text('${allMembers.length}/5', style: TextStyle(fontSize: 13, color: AppColors.textTertiary)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Weekly family summary
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.gold.withValues(alpha: 0.08), Colors.transparent],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.family_restroom_rounded, color: AppColors.gold, size: 20),
                              const SizedBox(width: 8),
                              Text(l.weeklyFamilyReport, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.gold)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _summaryChip(l.totalOffline, '12s 30dk', AppColors.neonGreen),
                              const SizedBox(width: 8),
                              _summaryChip(l.average, '3s 7dk', const Color(0xFF4FACFE)),
                              const SizedBox(width: 8),
                              _summaryChip(l.best, 'Anne', AppColors.gold),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Family ranking
                    Text(l.familyRanking, style: AppType.caption),
                    const SizedBox(height: 12),
                    ...List.generate(allMembers.length, (i) {
                      final m = allMembers[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: i == 0 ? AppColors.gold.withValues(alpha: 0.08) : AppColors.cardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: i == 0 ? AppColors.gold.withValues(alpha: 0.3) : AppColors.cardBorder),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '#${i + 1}',
                              style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800,
                                color: i == 0 ? AppColors.gold : AppColors.textTertiary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            CircleAvatar(radius: 18, backgroundColor: m.color, child: Text(m.name[0], style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600))),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(m.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                  if (m.offlineMinutes > 0)
                                    Text(l.offlineTime(m.offlineMinutes ~/ 60, m.offlineMinutes % 60), style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                                ],
                              ),
                            ),
                            if (m.streak > 0)
                              Row(
                                children: [
                                  const Icon(Icons.local_fire_department_rounded, size: 14, color: AppColors.neonOrange),
                                  const SizedBox(width: 2),
                                  Text('${m.streak}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.neonOrange)),
                                ],
                              ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 20),

                    // Add member
                    if (allMembers.length < 5) ...[
                      Text(l.addMember, style: AppType.caption),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _nameController,
                              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: l.enterName,
                                hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 14),
                                filled: true,
                                fillColor: AppColors.surface,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.gold)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              final name = _nameController.text.trim();
                              if (name.isEmpty) return;
                              HapticService.medium();
                              ref.read(subscriptionProvider.notifier).addFamilyMember(name);
                              _nameController.clear();
                            },
                            child: Container(
                              width: 48, height: 48,
                              decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.add_rounded, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
            Text(label, style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedView(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary)),
                  const SizedBox(width: 12),
                  Text(l.familyPlanTitle, style: AppType.h2),
                ],
              ),
              const Spacer(),
              Icon(Icons.family_restroom_rounded, size: 64, color: AppColors.gold.withValues(alpha: 0.4)),
              const SizedBox(height: 16),
              Text(l.familyPlanLocked, style: AppType.title),
              const SizedBox(height: 8),
              Text(
                l.familyPlanLockedDesc,
                style: TextStyle(fontSize: 13, color: AppColors.textTertiary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => context.push('/settings/subscription'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(l.upgradeToProPlus, style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FamilyMember {
  const _FamilyMember(this.label, this.name, this.color, this.offlineMinutes, this.streak);
  final String label;
  final String name;
  final Color color;
  final int offlineMinutes;
  final int streak;
}
