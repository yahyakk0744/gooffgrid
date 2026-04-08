import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';
import '../../providers/groups_provider.dart';
import '../../widgets/empty_state.dart';
import '../../l10n/app_localizations.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final groups = ref.watch(groupProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.groups, style: AppTextStyles.h1),
              const SizedBox(height: 24),
              if (groups.isEmpty)
                EmptyState(
                  emoji: '👥',
                  title: l.noGroupsYet,
                  subtitle: l.noGroupsSubtitle,
                  buttonText: l.createGroup,
                  onButtonTap: () => context.push('/group/create'),
                ),

              ...groups.map((g) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(g.name, style: AppTextStyles.h3),
                      const SizedBox(height: 4),
                      Text('${g.memberCount} uye  |  ${g.weekTotalMinutes ~/ 60}s haftalik', style: AppTextStyles.bodySecondary),
                    ],
                  ),
                ),
              )),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/group/create'),
                  icon: const Icon(Icons.group_add_rounded),
                  label: Text(l.newGroup),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
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
