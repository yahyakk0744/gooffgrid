import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../../../config/design_tokens.dart';
import '../../../config/app_shadows.dart';
import '../../../models/duel_type.dart';
import '../../../services/haptic_service.dart';

/// Common apps for the app-ban duel picker.
class AppPickerStep extends StatelessWidget {
  const AppPickerStep({
    super.key,
    required this.selectedApp,
    required this.onSelected,
  });

  final String? selectedApp;
  final ValueChanged<String> onSelected;

  static const _apps = <(String, IconData, Color)>[
    ('Instagram', Icons.camera_alt_rounded, AppColors.instagram),
    ('TikTok', Icons.music_note_rounded, AppColors.tiktok),
    ('YouTube', Icons.play_arrow_rounded, AppColors.youtube),
    ('WhatsApp', Icons.chat_rounded, AppColors.whatsapp),
    ('Twitter', Icons.alternate_email_rounded, AppColors.twitter),
    ('Snapchat', Icons.photo_camera_rounded, AppColors.snapchat),
    ('Telegram', Icons.send_rounded, AppColors.telegram),
    ('Reddit', Icons.reddit, AppColors.reddit),
    ('Facebook', Icons.facebook_rounded, AppColors.twitter),
    ('Netflix', Icons.movie_rounded, Color(0xFFE50914)),
    ('Spotify', Icons.library_music_rounded, Color(0xFF1DB954)),
    ('Diğer', Icons.apps_rounded, AppColors.textSecondary),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Yasaklanacak uygulamayı seç',
              style: AppType.h2),
          const SizedBox(height: 4),
          Text('Rakibin 24 saat bu uygulamayı açamayacak',
              style: AppType.body.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemCount: _apps.length,
              itemBuilder: (_, i) {
                final app = _apps[i];
                final isSelected = selectedApp == app.$1;
                return GestureDetector(
                  onTap: () {
                    HapticService.light();
                    onSelected(app.$1);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.neonGreen
                            : AppColors.cardBorder,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? AppShadow.glow(AppColors.neonGreen)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: app.$3.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(app.$2, color: app.$3, size: 22),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          app.$1,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryPickerStep extends StatelessWidget {
  const CategoryPickerStep({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
  });

  final String? selectedCategory;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hangi kategoride yarışıyorsunuz?',
              style: AppType.h2),
          const SizedBox(height: 4),
          Text('Sadece bu kategorideki süre sayılacak',
              style: AppType.body.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: DuelType.categories.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final cat = DuelType.categories[i];
                final isSelected = selectedCategory == cat.$1;
                return GestureDetector(
                  onTap: () {
                    HapticService.light();
                    onSelected(cat.$1);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.neonGreen
                            : AppColors.cardBorder,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(cat.$3,
                            style: const TextStyle(fontSize: 32)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(cat.$2, style: AppType.h2),
                        ),
                        Icon(
                          isSelected
                              ? Icons.check_circle_rounded
                              : Icons.circle_outlined,
                          color: isSelected
                              ? AppColors.neonGreen
                              : AppColors.textTertiary,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DiceRollerStep extends StatefulWidget {
  const DiceRollerStep({
    super.key,
    required this.result,
    required this.onRolled,
  });

  final int? result;
  final ValueChanged<int> onRolled;

  @override
  State<DiceRollerStep> createState() => _DiceRollerStepState();
}

class _DiceRollerStepState extends State<DiceRollerStep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _rolling = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _roll() async {
    if (widget.result != null || _rolling) return;
    setState(() => _rolling = true);
    HapticService.medium();
    _controller.forward(from: 0);
    await Future.delayed(const Duration(milliseconds: 1200));
    final value = math.Random().nextInt(6) + 1;
    HapticService.medium();
    widget.onRolled(value);
    if (mounted) setState(() => _rolling = false);
  }

  String _dots(int n) {
    const faces = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];
    return faces[n - 1];
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.result;
    final locked = result != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text('Zar at, hedefini belirlesin',
              style: AppType.h2),
          const SizedBox(height: 4),
          Text('Zarın değeri × 30 dakika = hedef süre',
              style: AppType.body.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: _roll,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, _) {
                final t = _controller.value;
                final angle = _rolling ? t * math.pi * 6 : 0.0;
                return Transform.rotate(
                  angle: angle,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.cardGradientStart,
                          AppColors.cardGradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: locked
                            ? AppColors.neonGreen
                            : AppColors.cardBorder,
                        width: 2,
                      ),
                      boxShadow: locked
                          ? AppShadow.glow(AppColors.neonGreen, blur: 30)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        _rolling
                            ? _dots(((t * 12).floor() % 6) + 1)
                            : (result != null ? _dots(result) : '🎲'),
                        style: const TextStyle(fontSize: 96),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          if (locked) ...[
            Text(
              'Sonuç: $result',
              style: AppType.h1.copyWith(color: AppColors.neonGreen),
            ),
            const SizedBox(height: 8),
            Text(
              'Hedef süre: ${result * 30} dk',
              style: AppType.body.copyWith(color: AppColors.textSecondary),
            ),
          ] else
            Text(
              _rolling ? 'Zar dönüyor...' : 'Atmak için dokun',
              style: AppType.body.copyWith(color: AppColors.textSecondary),
            ),
        ],
      ),
    );
  }
}

class NightDuelInfoStep extends StatelessWidget {
  const NightDuelInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.cardGradientStart,
                  AppColors.cardGradientEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🌙', style: TextStyle(fontSize: 56)),
                const SizedBox(height: 16),
                Text('Gece Düellosu', style: AppType.h1),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.neonGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '23:00 — 07:00',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neonGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Telefona bakmadan uyu. Kim daha uzun dokunmazsa kazanır. Süre sabit 8 saat.',
                  style: AppType.body,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.info_outline_rounded,
                        color: AppColors.textTertiary, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Bu düello saat 23:00\'de otomatik başlar.',
                        style: AppType.label,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MysteryRevealStep extends StatefulWidget {
  const MysteryRevealStep({super.key});

  @override
  State<MysteryRevealStep> createState() => _MysteryRevealStepState();
}

class _MysteryRevealStepState extends State<MysteryRevealStep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shake;

  @override
  void initState() {
    super.initState();
    _shake = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text('Gizemli Görev', style: AppType.h1),
          const SizedBox(height: 4),
          Text('Görev düello başlayınca açıklanır',
              style: AppType.body.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 40),
          AnimatedBuilder(
            animation: _shake,
            builder: (_, _) {
              final t = _shake.value;
              final dx =
                  math.sin(t * math.pi * 4) * 4 * (t < 0.2 ? 1 : 0);
              return Transform.translate(
                offset: Offset(dx, 0),
                child: Container(
                  width: 200,
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.neonOrange.withValues(alpha: 0.2),
                        AppColors.cardGradientEnd,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: AppColors.neonOrange, width: 2),
                    boxShadow: AppShadow.glow(AppColors.neonOrange, blur: 24),
                  ),
                  child: const Center(
                    child: Text(
                      '???',
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w900,
                        color: AppColors.neonOrange,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          Text(
            'Düelloyu başlattığında rastgele bir görev seçilir.',
            textAlign: TextAlign.center,
            style: AppType.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
