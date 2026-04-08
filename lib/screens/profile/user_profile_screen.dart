import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../l10n/app_localizations.dart';
import '../../models/user_profile.dart';
import '../../providers/user_provider.dart';
import '../../providers/friends_provider.dart';
import '../../services/haptic_service.dart';
import '../../widgets/glassmorphic_card.dart';
import '../../widgets/level_badge.dart';
import '../../widgets/premium_background.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key, required this.userId});
  final String userId;

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _xpController;
  late Animation<double> _xpAnimation;
  String _friendshipStatus = 'none'; // none, sent, received, friends

  @override
  void initState() {
    super.initState();
    _xpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _xpAnimation = CurvedAnimation(
      parent: _xpController,
      curve: Curves.easeOutCubic,
    );
    _xpController.forward();
    _loadFriendshipStatus();
  }

  @override
  void dispose() {
    _xpController.dispose();
    super.dispose();
  }

  void _loadFriendshipStatus() {
    // Mock: check if this user is a friend
    final friends = ref.read(friendsProvider);
    final isFriend = friends.any((f) => f.profile.id == widget.userId);
    if (isFriend) {
      setState(() => _friendshipStatus = 'friends');
    }
  }

  UserProfile _resolveProfile() {
    final currentUser = ref.read(userProvider);
    if (widget.userId == currentUser.id) return currentUser;

    final friends = ref.read(friendsProvider);
    final match = friends.where((f) => f.profile.id == widget.userId);
    if (match.isNotEmpty) return match.first.profile;

    // Mock fallback
    return UserProfile(
      id: widget.userId,
      name: 'Kullanıcı',
      avatarColor: const Color(0xFF667EEA),
      city: 'İstanbul',
      country: 'Türkiye',
      ageGroup: '18-24',
      level: 4,
      title: 'Farkında Gezgin',
      streak: 5,
      bestStreak: 10,
      totalPoints: 850,
      createdAt: DateTime(2025, 3, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final profile = _resolveProfile();
    final isMe = profile.id == ref.read(userProvider).id;

    // XP calculation
    final xpCurrent = profile.totalPoints;
    final xpNeeded = _xpForLevel(profile.level + 1);
    final xpBase = _xpForLevel(profile.level);
    final xpProgress =
        xpNeeded > xpBase ? (xpCurrent - xpBase) / (xpNeeded - xpBase) : 1.0;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Back button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticService.light();
                        context.pop();
                      },
                      child: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Avatar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: profile.avatarColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _tierColor(profile.level).withValues(alpha: 0.6),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: profile.avatarColor.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      profile.name[0].toUpperCase(),
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Username + name
                Text(profile.name, style: AppTextStyles.h1),
                const SizedBox(height: 4),
                Text(profile.title, style: AppTextStyles.bodySecondary),
                const SizedBox(height: 16),

                // XP Progress Bar
                GlassmorphicCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _TierBadge(level: profile.level),
                          const Spacer(),
                          Text(
                            '$xpCurrent / $xpNeeded XP',
                            style: AppTextStyles.label,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AnimatedBuilder(
                        animation: _xpAnimation,
                        builder: (_, __) {
                          return Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor:
                                  (xpProgress * _xpAnimation.value)
                                      .clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.neonGreen.withValues(alpha: 0.6),
                                      AppColors.neonGreen,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.neonGreen
                                          .withValues(alpha: 0.4),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Stats row
                GlassmorphicCard(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(
                          value: '${profile.streak}',
                          label: l.streak,
                          icon: Icons.local_fire_department_rounded,
                          color: AppColors.neonOrange),
                      _StatItem(
                          value: '${profile.totalPoints}',
                          label: 'O2',
                          icon: Icons.eco_rounded,
                          color: AppColors.neonGreen),
                      _StatItem(
                          value: '8',
                          label: l.seriFriends,
                          icon: Icons.people_rounded,
                          color: const Color(0xFF4FACFE)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Friendship button
                if (!isMe) _buildFriendshipButton(l),
                if (!isMe) const SizedBox(height: 16),

                // Recent badges
                _buildRecentBadges(l),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFriendshipButton(AppLocalizations l) {
    switch (_friendshipStatus) {
      case 'friends':
        return SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: () => _confirmRemoveFriend(l),
            icon: const Icon(Icons.person_remove_rounded, size: 18),
            label: Text(l.removeFriend),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.ringDanger,
              side: const BorderSide(color: AppColors.ringDanger),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
        );
      case 'sent':
        return SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.hourglass_top_rounded, size: 18),
            label: Text(l.requestSent),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cardBg,
              foregroundColor: AppColors.textTertiary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
        );
      case 'received':
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    HapticService.success();
                    setState(() => _friendshipStatus = 'friends');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(l.accept,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    HapticService.light();
                    setState(() => _friendshipStatus = 'none');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.ringDanger,
                    side: const BorderSide(color: AppColors.ringDanger),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(l.decline,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        );
      default: // none
        return SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () {
              HapticService.medium();
              setState(() => _friendshipStatus = 'sent');
            },
            icon: const Icon(Icons.person_add_rounded, size: 18),
            label: Text(l.addFriend),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.neonGreen,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        );
    }
  }

  void _confirmRemoveFriend(AppLocalizations l) {
    HapticService.warning();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l.removeFriend,
            style: const TextStyle(color: AppColors.textPrimary)),
        content: Text(l.removeFriendConfirm,
            style: const TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.cancel,
                style: const TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _friendshipStatus = 'none');
            },
            child: Text(l.remove,
                style: const TextStyle(color: AppColors.ringDanger)),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBadges(AppLocalizations l) {
    final badges = [
      ('🔥', 'Ateş Serisi'),
      ('📵', '24 Saat'),
      ('🏆', 'İlk Düello'),
      ('⭐', 'Yeni Yıldız'),
      ('🎯', 'Hedef Vurucu'),
      ('💎', 'Elmas'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(l.recentBadges, style: AppTextStyles.h3),
            const Spacer(),
            GestureDetector(
              onTap: () => HapticService.light(),
              child: Text(
                l.allBadgesLabel,
                style: TextStyle(
                    fontSize: 13,
                    color: AppColors.neonGreen.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GlassmorphicCard(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: badges
                .map((b) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1)),
                          ),
                          child: Center(
                            child:
                                Text(b.$1, style: const TextStyle(fontSize: 22)),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(b.$2,
                            style: AppTextStyles.labelSmall,
                            textAlign: TextAlign.center),
                      ],
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  int _xpForLevel(int level) {
    const table = [0, 100, 300, 600, 1000, 1500, 2200, 3000, 4000, 5500, 7500];
    if (level >= table.length) return table.last;
    return table[level];
  }

  Color _tierColor(int level) {
    if (level >= 9) return const Color(0xFFFFD700); // legendary gold
    if (level >= 7) return const Color(0xFF00F2FE); // diamond
    if (level >= 5) return const Color(0xFFFFD700); // gold
    if (level >= 3) return const Color(0xFFC0C0C0); // silver
    return const Color(0xFFCD7F32); // bronze
  }
}

class _TierBadge extends StatelessWidget {
  final int level;
  const _TierBadge({required this.level});

  String get _tierName {
    if (level >= 9) return 'Efsanevi';
    if (level >= 7) return 'Elmas';
    if (level >= 5) return 'Altın';
    if (level >= 3) return 'Gümüş';
    return 'Bronz';
  }

  Color get _color {
    if (level >= 9) return const Color(0xFFFFD700);
    if (level >= 7) return const Color(0xFF00F2FE);
    if (level >= 5) return const Color(0xFFFFD700);
    if (level >= 3) return const Color(0xFFC0C0C0);
    return const Color(0xFFCD7F32);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LevelBadge(level: level),
          const SizedBox(width: 6),
          Text(
            'Seviye $level • $_tierName',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: _color),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary)),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}
