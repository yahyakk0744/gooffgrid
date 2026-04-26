import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/theme.dart';
import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/onboarding/shock_screen.dart';
import '../screens/onboarding/permissions_screen.dart';
import '../screens/onboarding/profile_setup_screen.dart';
import '../screens/onboarding/goal_setup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/duel/duel_list_screen.dart';
import '../screens/duel/duel_active_screen.dart';
import '../screens/duel/duel_invite_screen.dart';
import '../screens/duel/create_duel_screen.dart';
import '../screens/duel/duel_result_screen.dart';
import '../screens/profile/my_profile_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
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
import '../screens/sessions/deep_focus_setup_screen.dart';
import '../screens/sessions/active_session_screen.dart';
import '../screens/sessions/session_complete_screen.dart';
import '../screens/sessions/blocklists_screen.dart';
import '../screens/limits/app_limits_screen.dart';
import '../screens/season/season_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/subscription_screen.dart';
import '../screens/stories/create_story_screen.dart';
import '../screens/social/social_screen.dart';
import '../screens/o2/o2_dashboard_screen.dart';
import '../screens/o2/market_screen.dart';
import '../screens/ganimet/ganimet_screen.dart';
import '../screens/admin/admin_ganimet_screen.dart';
import '../screens/stats/analytics_detailed_screen.dart';
import '../screens/stats/monthly_top10_screen.dart';
import '../screens/profile/user_profile_screen.dart';
import '../screens/settings/legal_screen.dart';
import '../screens/settings/delete_account_screen.dart';
import '../screens/appblock/app_block_screen.dart';
import '../screens/appblock/block_schedule_screen.dart';
import '../screens/appblock/intervention_screen.dart';
import '../screens/appblock/pre_open_intervention_screen.dart';

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
        builder: (_, _) => const LoginScreen(),
      ),

      // Onboarding
      GoRoute(
        path: '/onboarding',
        builder: (_, _) => const WelcomeScreen(),
        routes: [
          GoRoute(path: 'shock', builder: (_, _) => const ShockScreen()),
          GoRoute(path: 'permissions', builder: (_, _) => const PermissionsScreen()),
          GoRoute(path: 'goal', builder: (_, _) => const GoalSetupScreen()),
          GoRoute(path: 'profile', builder: (_, _) => const ProfileSetupScreen()),
        ],
      ),

      // Deep Focus sessions (full-screen, outside tab shell)
      GoRoute(
        path: '/sessions/setup',
        builder: (_, _) => const DeepFocusSetupScreen(),
      ),
      GoRoute(
        path: '/sessions/blocklists',
        builder: (_, _) => const BlocklistsScreen(),
      ),
      GoRoute(
        path: '/limits',
        builder: (_, _) => const AppLimitsScreen(),
      ),
      GoRoute(
        path: '/sessions/active',
        builder: (_, _) => const ActiveSessionScreen(),
      ),
      GoRoute(
        path: '/sessions/complete',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return SessionCompleteScreen(
            durationMin: extra['durationMin'] as int? ?? 0,
            gemsEarned: extra['gemsEarned'] as int? ?? 0,
          );
        },
      ),

      // Pre-open intervention — native bridge (Android AccessibilityService /
      // iOS Shortcuts Automation) pushes this before launching a blocked app.
      // `app` = package name or user-friendly label
      GoRoute(
        path: '/pre-open',
        builder: (_, state) {
          final app = state.uri.queryParameters['app'] ?? 'Bu uygulama';
          final secs = int.tryParse(
                state.uri.queryParameters['secs'] ?? '',
              ) ??
              5;
          return PreOpenInterventionScreen(
            appPackageOrLabel: app,
            countdownSeconds: secs,
          );
        },
      ),

      // Universal user profile (accessible from anywhere)
      GoRoute(
        path: '/user/:id',
        builder: (_, state) =>
            UserProfileScreen(userId: state.pathParameters['id']!),
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
              builder: (_, _) => const HomeScreen(),
              routes: [
                GoRoute(path: 'breathing', builder: (_, _) => const FocusModeScreen()),
                GoRoute(
                  path: 'o2',
                  builder: (_, _) => const O2DashboardScreen(),
                  routes: [
                    GoRoute(path: 'market', builder: (_, _) => const MarketScreen()),
                  ],
                ),
                GoRoute(path: 'friends', builder: (_, _) => const FriendsListScreen()),
                GoRoute(path: 'friend/add', builder: (_, _) => const AddFriendScreen()),
                GoRoute(
                  path: 'friend/:id',
                  builder: (_, state) =>
                      FriendProfileScreen(friendId: state.pathParameters['id']!),
                ),
                GoRoute(path: 'wrapped', builder: (_, _) => const ReportCardScreen()),
                GoRoute(path: 'ganimetler', builder: (_, _) => const GanimetScreen()),
                GoRoute(path: 'admin/ganimet', builder: (_, _) => const AdminGanimetScreen()),
                GoRoute(path: 'app-block', builder: (_, _) => const AppBlockScreen()),
                GoRoute(path: 'app-block/schedule', builder: (_, _) => const BlockScheduleScreen()),
                GoRoute(path: 'app-block/intervention', builder: (_, _) => const InterventionScreen()),
                GoRoute(path: 'groups', builder: (_, _) => const GroupsScreen()),
                GoRoute(path: 'group/create', builder: (_, _) => const CreateGroupScreen()),
                GoRoute(
                  path: 'group/:id',
                  builder: (_, state) =>
                      GroupDetailScreen(groupId: state.pathParameters['id']!),
                ),
              ],
            ),
          ]),

          // Tab 1: Sosyal (Sıralama + Hikayeler)
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/social',
              builder: (_, _) => const SocialScreen(),
              routes: [
                GoRoute(path: 'seasons', builder: (_, _) => const SeasonScreen()),
                GoRoute(path: 'create-story', builder: (_, _) => const CreateStoryScreen()),
              ],
            ),
          ]),

          // Tab 2: Duel
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/duel',
              builder: (_, _) => const DuelListScreen(),
              routes: [
                GoRoute(path: 'create', builder: (_, _) => const CreateDuelScreen()),
                GoRoute(path: 'invite', builder: (_, _) => const DuelInviteScreen()),
                GoRoute(
                  path: 'active',
                  builder: (_, _) => const DuelActiveScreen(),
                ),
                GoRoute(path: 'result', builder: (_, _) => const DuelResultScreen()),
                GoRoute(
                  path: ':id',
                  builder: (_, state) =>
                      DuelActiveScreen(duelId: state.pathParameters['id']!),
                ),
              ],
            ),
          ]),

          // Tab 3: Profile (includes settings)
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/profile',
              builder: (_, _) => const MyProfileScreen(),
              routes: [
                GoRoute(path: 'edit', builder: (_, _) => const EditProfileScreen()),
                GoRoute(path: 'stats', builder: (_, _) => const StatsScreen()),
                GoRoute(path: 'stats/analytics', builder: (_, _) => const AnalyticsScreen()),
                GoRoute(path: 'stats/whatif', builder: (_, _) => const WhatIfScreen()),
                GoRoute(path: 'stats/detailed', builder: (_, _) => const AnalyticsDetailedScreen()),
                GoRoute(path: 'stats/monthly-top10', builder: (_, _) => const MonthlyTop10Screen()),
                GoRoute(path: 'settings', builder: (_, _) => const SettingsScreen()),
                GoRoute(path: 'settings/subscription', builder: (_, _) => const SubscriptionScreen()),
                GoRoute(path: 'settings/privacy', builder: (_, _) => const LegalScreen(type: LegalType.privacy)),
                GoRoute(path: 'settings/terms', builder: (_, _) => const LegalScreen(type: LegalType.terms)),
                GoRoute(path: 'settings/kvkk', builder: (_, _) => const LegalScreen(type: LegalType.kvkk)),
                GoRoute(path: 'settings/delete-account', builder: (_, _) => const DeleteAccountScreen()),
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

  static const _tabIcons = [
    Icons.home_rounded,
    Icons.people_rounded,
    Icons.bolt_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final tabLabels = [l.home, l.social, l.duel, l.profile];

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF101018), Color(0xFF0A0A12)],
          ),
          border: Border(top: BorderSide(color: AppColors.cardBorder.withValues(alpha: 0.3), width: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
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
              children: List.generate(_tabIcons.length, (i) {
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
                          _tabIcons[i],
                          size: 24,
                          color: selected ? AppColors.neonGreen : AppColors.textTertiary,
                          shadows: selected
                              ? [Shadow(color: AppColors.neonGreen.withValues(alpha: 0.5), blurRadius: 12)]
                              : null,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tabLabels[i],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                            color: selected ? AppColors.neonGreen : AppColors.textTertiary,
                            shadows: selected
                                ? [Shadow(color: AppColors.neonGreen.withValues(alpha: 0.3), blurRadius: 8)]
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

