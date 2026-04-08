import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../widgets/premium_background.dart';
import '../../l10n/app_localizations.dart';
import '../ranking/ranking_screen.dart';
import '../stories/stories_feed_screen.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: PremiumBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              l.social,
              style: AppType.h3,
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: AppColors.neonGreen,
              indicatorWeight: 3,
              labelColor: AppColors.neonGreen,
              unselectedLabelColor: AppColors.textTertiary,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              dividerColor: AppColors.cardBorder.withValues(alpha: 0.3),
              tabs: [
                Tab(text: l.ranking),
                Tab(text: l.stories),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              RankingScreen(embedded: true),
              StoriesFeedScreen(embedded: true),
            ],
          ),
        ),
      ),
    );
  }
}
