import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/wrapped_card.dart';
import '../../providers/screen_time_provider.dart';
import '../../providers/user_provider.dart';

class ReportCardScreen extends ConsumerWidget {
  const ReportCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final st = ref.watch(todayScreenTimeProvider);
    final weekTotal = ref.watch(weekTotalProvider);
    final user = ref.watch(userProvider);
    final controller = PageController();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
          children: [
            const SizedBox(height: 16),
            const Text('Haftalik Karne', style: AppTextStyles.h1),
            const SizedBox(height: 24),
            Expanded(
              child: PageView(
                controller: controller,
                children: [
                  // Page 1: Week summary
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: WrappedCard(
                      gradient: AppColors.wrappedGradient1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Bu Hafta', style: AppTextStyles.wrappedSub),
                          const SizedBox(height: 8),
                          Text(weekTotal, style: AppTextStyles.wrappedHero),
                          const SizedBox(height: 8),
                          const Text('Gecen haftadan %12 daha iyi', style: AppTextStyles.wrappedSub),
                        ],
                      ),
                    ),
                  ),

                  // Page 2: Top app
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: WrappedCard(
                      gradient: AppColors.wrappedGradient2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('En cok kullandigin', style: AppTextStyles.wrappedSub),
                          const SizedBox(height: 12),
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(color: st.appUsage.first.iconColor, shape: BoxShape.circle),
                            child: const Center(child: Icon(Icons.apps_rounded, color: Colors.white, size: 32)),
                          ),
                          const SizedBox(height: 12),
                          Text(st.appUsage.first.name, style: AppTextStyles.wrappedHero.copyWith(fontSize: 36)),
                          Text(st.appUsage.first.formattedDuration, style: AppTextStyles.wrappedSub),
                        ],
                      ),
                    ),
                  ),

                  // Page 3: Rankings
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: WrappedCard(
                      gradient: AppColors.wrappedGradient3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Siralamalarin', style: AppTextStyles.wrappedSub),
                          const SizedBox(height: 24),
                          _RankLine(label: 'Arkadaslar', value: '#3/8', arrow: ''),
                          const SizedBox(height: 16),
                          _RankLine(label: user.city, value: '#247', arrow: ''),
                          const SizedBox(height: 16),
                          _RankLine(label: 'Turkiye', value: '#12.847', arrow: ''),
                        ],
                      ),
                    ),
                  ),

                  // Page 4: Streak & badges
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: WrappedCard(
                      gradient: AppColors.wrappedGradient4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Streak & Basarilar', style: AppTextStyles.wrappedSub),
                          const SizedBox(height: 12),
                          Text('${user.streak}', style: AppTextStyles.wrappedHero.copyWith(fontSize: 64)),
                          const Text('gun ust uste', style: AppTextStyles.wrappedSub),
                          const SizedBox(height: 16),
                          const Text('6 rozet kazandin', style: AppTextStyles.wrappedSub),
                        ],
                      ),
                    ),
                  ),

                  // Page 5: Share
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: WrappedCard(
                      gradient: AppColors.wrappedGradient5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('gooffgrid', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 3)),
                          const SizedBox(height: 24),
                          const Icon(Icons.qr_code_2_rounded, size: 100, color: Colors.white),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.share_rounded),
                            label: const Text('Paylas'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SmoothPageIndicator(
              controller: controller,
              count: 5,
              effect: const WormEffect(
                dotWidth: 8,
                dotHeight: 8,
                spacing: 8,
                activeDotColor: AppColors.neonGreen,
                dotColor: AppColors.cardBorder,
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      ),
    );
  }
}

class _RankLine extends StatelessWidget {
  const _RankLine({required this.label, required this.value, required this.arrow});
  final String label;
  final String value;
  final String arrow;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: AppTextStyles.wrappedSub),
        const SizedBox(width: 12),
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
        if (arrow.isNotEmpty) ...[
          const SizedBox(width: 8),
          Text(arrow, style: const TextStyle(fontSize: 16, color: Colors.white70)),
        ],
      ],
    );
  }
}
