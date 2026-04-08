import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import '../../providers/blocklist_provider.dart';
import '../../widgets/bento/bento_card.dart';

/// Opal-style blocklist hub — shows all user blocklists.
class BlocklistsScreen extends ConsumerWidget {
  const BlocklistsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(blocklistProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Engel Listeleri', style: AppType.title),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.s5),
          itemCount: lists.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s3),
          itemBuilder: (_, i) {
            final b = lists[i];
            return BentoCard(
              accent: b.color,
              child: Row(
                children: [
                  Text(b.emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: AppSpacing.s4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.name, style: AppType.title),
                        const SizedBox(height: 2),
                        Text('${b.appIds.length} uygulama',
                            style: AppType.caption),
                      ],
                    ),
                  ),
                  if (b.isDefault)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: AppRadius.rPill,
                      ),
                      child: const Text('Varsayılan',
                          style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600)),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
