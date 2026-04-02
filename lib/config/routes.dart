import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/theme.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/onboarding/permissions_screen.dart';
import '../screens/onboarding/profile_setup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/ranking/ranking_screen.dart';
import '../screens/duel/duel_list_screen.dart';
import '../screens/duel/duel_active_screen.dart';
import '../screens/duel/duel_invite_screen.dart';
import '../screens/duel/create_duel_screen.dart';
import '../screens/duel/duel_result_screen.dart';
import '../screens/profile/my_profile_screen.dart';
import '../screens/profile/friend_profile_screen.dart';
import '../screens/profile/friends_list_screen.dart';
import '../screens/profile/add_friend_screen.dart';
import '../screens/groups/groups_screen.dart';
import '../screens/groups/group_detail_screen.dart';
import '../screens/groups/create_group_screen.dart';
import '../screens/stats/stats_screen.dart';
import '../screens/stats/analytics_screen.dart';
import '../screens/stats/whatif_screen.dart';
import '../screens/report/report_card_screen.dart';
import '../screens/focus/focus_mode_screen.dart';
import '../screens/season/season_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/subscription_screen.dart';
import '../screens/stories/stories_feed_screen.dart';
import '../screens/o2/o2_dashboard_screen.dart';
import '../screens/o2/market_screen.dart';
import '../screens/ganimet/ganimet_screen.dart';
import '../screens/admin/admin_ganimet_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildAppRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: _AuthRefreshNotifier(ref),
    redirect: (context, state) {
      final auth = ref.read(authProvider);
      final path = state.matchedLocation;

      // Henüz yükleniyor — bekle
      if (auth.isLoading) return null;

      final isOnLoginPage = path == '/login';
      final isOnOnboarding = path.startsWith('/onboarding');

      // Giriş yapılmamış → login'e yönlendir
      if (!auth.isLoggedIn) {
        return isOnLoginPage ? null : '/login';
      }

      // Giriş yapılmış ama onboard edilmemiş → onboarding'e
      if (!auth.isOnboarded) {
        return isOnOnboarding ? null : '/onboarding';
      }

      // Giriş yapılmış + onboard tamamlanmış ama login/onboarding'de → ana sayfaya
      if (isOnLoginPage || isOnOnboarding) {
        return '/';
      }

      return null;
    },
    routes: [
      // Login
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),

      // Onboarding
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const WelcomeScreen(),
        routes: [
          GoRoute(path: 'permissions', builder: (_, __) => const PermissionsScreen()),
          GoRoute(path: 'profile', builder: (_, __) => const ProfileSetupScreen()),
        ],
      ),

      // Tabbed shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            _ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          // Tab 0: Home
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/',
              builder: (_, __) => const HomeScreen(),
              routes: [
                GoRoute(path: 'breathing', builder: (_, __) => const FocusModeScreen()),
                GoRoute(path: 'stories', builder: (_, __) => const StoriesFeedScreen()),
                GoRoute(
                  path: 'o2',
                  builder: (_, __) => const O2DashboardScreen(),
                  routes: [
                    GoRoute(path: 'market', builder: (_, __) => const MarketScreen()),
                  ],
                ),
                GoRoute(path: 'friends', builder: (_, __) => const FriendsListScreen()),
                GoRoute(path: 'friend/add', builder: (_, __) => const AddFriendScreen()),
                GoRoute(
                  path: 'friend/:id',
                  builder: (_, state) =>
                      FriendProfileScreen(friendId: state.pathParameters['id']!),
                ),
                GoRoute(path: 'wrapped', builder: (_, __) => const ReportCardScreen()),
                GoRoute(path: 'ganimetler', builder: (_, __) => const GanimetScreen()),
                GoRoute(path: 'admin/ganimet', builder: (_, __) => const AdminGanimetScreen()),
                GoRoute(path: 'groups', builder: (_, __) => const GroupsScreen()),
                GoRoute(
                  path: 'group/:id',
                  builder: (_, state) =>
                      GroupDetailScreen(groupId: state.pathParameters['id']!),
                ),
                GoRoute(path: 'group/create', builder: (_, __) => const CreateGroupScreen()),
              ],
            ),
          ]),

          // Tab 1: Ranking
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/ranking',
              builder: (_, __) => const RankingScreen(),
              routes: [
                GoRoute(path: 'seasons', builder: (_, __) => const SeasonScreen()),
              ],
            ),
          ]),

          // Tab 2: Duel
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/duel',
              builder: (_, __) => const DuelListScreen(),
              routes: [
                GoRoute(path: 'create', builder: (_, __) => const CreateDuelScreen()),
                GoRoute(path: 'invite', builder: (_, __) => const DuelInviteScreen()),
                GoRoute(
                  path: 'active',
                  builder: (_, __) => const DuelActiveScreen(),
                ),
                GoRoute(path: 'result', builder: (_, __) => const DuelResultScreen()),
                GoRoute(
                  path: ':id',
                  builder: (_, state) =>
                      DuelActiveScreen(duelId: state.pathParameters['id']!),
                ),
              ],
            ),
          ]),

          // Tab 3: Profile
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/profile',
              builder: (_, __) => const MyProfileScreen(),
              routes: [
                GoRoute(path: 'stats', builder: (_, __) => const StatsScreen()),
                GoRoute(path: 'stats/analytics', builder: (_, __) => const AnalyticsScreen()),
                GoRoute(path: 'stats/whatif', builder: (_, __) => const WhatIfScreen()),
              ],
            ),
          ]),

          // Tab 4: Settings
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/settings',
              builder: (_, __) => const SettingsScreen(),
              routes: [
                GoRoute(path: 'subscription', builder: (_, __) => const SubscriptionScreen()),
              ],
            ),
          ]),
        ],
      ),
    ],
  );
}

// ──────────────────────────────────────────────
// AUTH REFRESH — GoRouter redirect'i yeniden tetikler
// ──────────────────────────────────────────────

class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(this._ref) {
    _ref.listen(authProvider, (prev, next) {
      notifyListeners();
    });
  }

  final Ref _ref;
}

// ──────────────────────────────────────────────
// NAV BAR
// ──────────────────────────────────────────────

class _ScaffoldWithNavBar extends StatelessWidget {
  const _ScaffoldWithNavBar({required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  static const _tabs = [
    _TabItem(icon: Icons.home_rounded, label: 'Ana Sayfa'),
    _TabItem(icon: Icons.leaderboard_rounded, label: 'Sıralama'),
    _TabItem(icon: Icons.bolt_rounded, label: 'Düello'),
    _TabItem(icon: Icons.person_rounded, label: 'Profil'),
    _TabItem(icon: Icons.settings_rounded, label: 'Ayarlar'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF101018), Color(0xFF0A0A12)],
          ),
          border: Border(top: BorderSide(color: AppColors.cardBorder.withOpacity(0.3), width: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_tabs.length, (i) {
                final selected = navigationShell.currentIndex == i;
                return GestureDetector(
                  onTap: () => navigationShell.goBranch(i,
                      initialLocation: i == navigationShell.currentIndex),
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: 64,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _tabs[i].icon,
                          size: 24,
                          color: selected ? AppColors.neonGreen : AppColors.textTertiary,
                          shadows: selected
                              ? [Shadow(color: AppColors.neonGreen.withOpacity(0.5), blurRadius: 12)]
                              : null,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _tabs[i].label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                            color: selected ? AppColors.neonGreen : AppColors.textTertiary,
                            shadows: selected
                                ? [Shadow(color: AppColors.neonGreen.withOpacity(0.3), blurRadius: 8)]
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem {
  const _TabItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}
