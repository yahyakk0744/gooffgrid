import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';
import '../../widgets/level_badge.dart';
import '../../providers/friends_provider.dart';

class FriendsListScreen extends ConsumerStatefulWidget {
  const FriendsListScreen({super.key});

  @override
  ConsumerState<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends ConsumerState<FriendsListScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final friends = ref.watch(friendsProvider);
    final filtered = _search.isEmpty
        ? friends
        : friends.where((f) => f.profile.name.toLowerCase().contains(_search.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: AppColors.bg,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/friend/add'),
        backgroundColor: AppColors.neonGreen,
        child: const Icon(Icons.person_add_rounded, color: Colors.black),
      ),
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
                  const Text('Arkadaşlar', style: AppTextStyles.h1),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (v) => setState(() => _search = v),
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Ara...',
                  hintStyle: const TextStyle(color: AppColors.textTertiary),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textTertiary),
                  filled: true,
                  fillColor: AppColors.cardBg,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final f = filtered[i];
                    return AppCard(
                      onTap: () => context.push('/friend/${f.profile.id}'),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(color: f.profile.avatarColor, shape: BoxShape.circle),
                            child: Center(child: Text(f.profile.name[0], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                Text(f.profile.name, style: AppTextStyles.h3),
                                const SizedBox(width: 6),
                                LevelBadge(level: f.profile.level),
                              ],
                            ),
                          ),
                          Text('${f.todayMinutes}dk', style: AppTextStyles.bodySecondary),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
