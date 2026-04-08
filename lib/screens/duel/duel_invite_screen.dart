import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';
import '../../providers/friends_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../models/duel_type.dart';
import 'widgets/duel_config_steps.dart';

class DuelInviteScreen extends ConsumerStatefulWidget {
  const DuelInviteScreen({
    super.key,
    this.incomingConfigType,
    this.incomingAppOrCategory,
  });

  /// When the screen is opened for an incoming invite, this describes what
  /// the opponent proposed so the user can accept or counter-propose.
  final DuelConfigType? incomingConfigType;
  final String? incomingAppOrCategory;

  @override
  ConsumerState<DuelInviteScreen> createState() => _DuelInviteScreenState();
}

class _DuelInviteScreenState extends ConsumerState<DuelInviteScreen> {
  int _selectedDuration = 3;
  String? _selectedFriend;

  static const _durationLabels = ['1s', '3s', '12s', '24s', '1 hafta'];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final friends = ref.watch(friendsProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
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
                  Text(l.newDuel, style: AppType.h2),
                ],
              ),
              const SizedBox(height: 24),
              if (widget.incomingConfigType == DuelConfigType.app &&
                  widget.incomingAppOrCategory != null) ...[
                _buildCounterProposal(isApp: true),
                const SizedBox(height: 24),
              ] else if (widget.incomingConfigType ==
                      DuelConfigType.category &&
                  widget.incomingAppOrCategory != null) ...[
                _buildCounterProposal(isApp: false),
                const SizedBox(height: 24),
              ],

              Text(l.duration, style: AppType.caption),
              const SizedBox(height: 12),
              Row(
                children: List.generate(5, (i) {
                  final selected = _selectedDuration == i;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDuration = i),
                      child: Container(
                        margin: EdgeInsets.only(right: i < 4 ? 8 : 0),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.neonGreen : AppColors.cardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: selected ? AppColors.neonGreen : AppColors.cardBorder),
                        ),
                        child: Center(
                          child: Text(
                            _durationLabels[i],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: selected ? Colors.black : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              Text(l.selectFriend, style: AppType.caption),
              const SizedBox(height: 12),
              ...friends.map((f) {
                final selected = _selectedFriend == f.profile.id;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppCard(
                    borderColor: selected ? AppColors.neonGreen : null,
                    onTap: () => setState(() => _selectedFriend = f.profile.id),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: f.profile.avatarColor, shape: BoxShape.circle),
                          child: Center(
                            child: Text(f.profile.name[0], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(f.profile.name, style: AppType.body)),
                        Text('${f.todayMinutes}dk', style: AppType.body.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),

              AppCard(
                child: Column(
                  children: [
                    const Icon(Icons.link_rounded, color: AppColors.textSecondary, size: 32),
                    const SizedBox(height: 8),
                    Text(l.orSendLink, style: AppType.body.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedFriend != null ? () => context.pop() : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor: AppColors.cardBg,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  child: Text(l.startDuel),
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

  Widget _buildCounterProposal({required bool isApp}) {
    final name = widget.incomingAppOrCategory!;
    final label = isApp
        ? 'Rakibin $name uygulamasını yasaklamanı istiyor'
        : 'Rakibin $name kategorisinde yarışmanı istiyor';
    final counterLabel = isApp
        ? 'O uygulamam yok, başka öner'
        : 'O kategoriyi kullanmıyorum, başka öner';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neonOrange),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.campaign_rounded,
                  color: AppColors.neonOrange, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label, style: AppType.body),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Davet kabul edildi'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Kabul Et',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _openCounterPicker(isApp: isApp),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.neonOrange,
                    side: const BorderSide(color: AppColors.neonOrange),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(counterLabel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openCounterPicker({required bool isApp}) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.bg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: isApp
                ? AppPickerStep(
                    selectedApp: null,
                    onSelected: (a) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Öneri gönderildi: $a'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  )
                : CategoryPickerStep(
                    selectedCategory: null,
                    onSelected: (c) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Öneri gönderildi: $c'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
