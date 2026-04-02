import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../models/duel_type.dart';
import '../../providers/friends_provider.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';

class CreateDuelScreen extends ConsumerStatefulWidget {
  const CreateDuelScreen({super.key});

  @override
  ConsumerState<CreateDuelScreen> createState() => _CreateDuelScreenState();
}

class _CreateDuelScreenState extends ConsumerState<CreateDuelScreen> {
  final _pageController = PageController();
  int _step = 0;
  DuelType? _selectedType;
  Duration? _selectedDuration;
  String? _selectedPenalty;
  final _selectedFriends = <String>{};
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_step < 2) {
      setState(() => _step++);
      _pageController.animateToPage(_step,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    }
  }

  void _prevStep() {
    if (_step > 0) {
      setState(() => _step--);
      _pageController.animateToPage(_step,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    } else {
      context.pop();
    }
  }

  bool get _canProceed {
    if (_step == 0) return _selectedType != null;
    if (_step == 1) return _selectedDuration != null;
    return _selectedFriends.isNotEmpty;
  }

  void _onProceed() {
    if (_step < 2) {
      _nextStep();
    } else {
      HapticService.medium();
      context.go('/duel/d1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _prevStep,
                      child: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _step == 0
                          ? 'Düello Türü Seç'
                          : _step == 1
                              ? 'Süre Seç'
                              : 'Rakip Seç',
                      style: AppTextStyles.h1,
                    ),
                    const Spacer(),
                    ...List.generate(3, (i) => Container(
                      width: i == _step ? 24 : 8,
                      height: 8,
                      margin: const EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                        color: i <= _step
                            ? AppColors.neonGreen
                            : AppColors.cardBorder,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildTypeSelection(),
                    _buildDurationSelection(),
                    _buildFriendSelection(),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _canProceed ? _onProceed : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonGreen,
                      foregroundColor: Colors.black,
                      disabledBackgroundColor: AppColors.cardBg,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    child: Text(_step == 2 ? 'Düelloya Başla! ⚔️' : 'Devam'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelection() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemCount: DuelType.all.length,
      itemBuilder: (_, i) {
        final type = DuelType.all[i];
        final isSelected = _selectedType?.id == type.id;
        return GestureDetector(
          onTap: () {
            HapticService.light();
            setState(() {
              _selectedType = type;
              _selectedDuration = null;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: isSelected
                ? (Matrix4.identity()..scale(1.03, 1.03))
                : Matrix4.identity(),
            transformAlignment: Alignment.center,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.cardGradientStart,
                  AppColors.cardGradientEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color:
                    isSelected ? AppColors.neonGreen : AppColors.cardBorder,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.neonGreen.withValues(alpha: 0.25),
                        blurRadius: 16,
                        spreadRadius: -2,
                      )
                    ]
                  : null,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type.emoji,
                        style: const TextStyle(fontSize: 32)),
                    const SizedBox(height: 8),
                    Text(type.name,
                        style: AppTextStyles.h3,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(type.description,
                        style: AppTextStyles.labelSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                if (type.isPro)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('PRO',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: Colors.black)),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDurationSelection() {
    if (_selectedType == null) return const SizedBox.shrink();
    final type = _selectedType!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(type.emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type.name, style: AppTextStyles.h2),
                    Text(type.description,
                        style: AppTextStyles.bodySecondary),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Süre Seç', style: AppTextStyles.label),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: type.availableDurations.map((d) {
              final isSelected = _selectedDuration == d;
              return GestureDetector(
                onTap: () {
                  HapticService.light();
                  setState(() => _selectedDuration = d);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.neonGreen
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.neonGreen
                          : AppColors.cardBorder,
                    ),
                  ),
                  child: Text(
                    type.formatDuration(d),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.black
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (type.id == 'penalty') ...[
            const SizedBox(height: 24),
            const Text('Ceza Seç (opsiyonel)', style: AppTextStyles.label),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: DuelType.penaltyTemplates.map((p) {
                final sel = _selectedPenalty == p;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPenalty = p),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: sel
                          ? AppColors.neonOrange.withValues(alpha: 0.2)
                          : AppColors.cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: sel
                            ? AppColors.neonOrange
                            : AppColors.cardBorder,
                      ),
                    ),
                    child: Text(p,
                        style: TextStyle(
                          fontSize: 13,
                          color: sel
                              ? AppColors.neonOrange
                              : AppColors.textSecondary,
                        )),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFriendSelection() {
    final friends = ref.watch(friendsProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: TextField(
              controller: _searchController,
              style: AppTextStyles.body,
              decoration: const InputDecoration(
                hintText: 'Arkadaş ara...',
                hintStyle: TextStyle(color: AppColors.textTertiary),
                border: InputBorder.none,
                icon: Icon(Icons.search_rounded,
                    color: AppColors.textTertiary, size: 20),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: const Row(
                children: [
                  Icon(Icons.link_rounded,
                      color: AppColors.neonGreen, size: 22),
                  SizedBox(width: 12),
                  Text('Link ile Davet Et 🔗',
                      style: TextStyle(
                          color: AppColors.neonGreen,
                          fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.share_rounded,
                      color: AppColors.textTertiary, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: friends.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final f = friends[i];
                final selected = _selectedFriends.contains(f.profile.id);
                return GestureDetector(
                  onTap: () {
                    HapticService.light();
                    setState(() {
                      if (_selectedFriends.contains(f.profile.id)) {
                        _selectedFriends.remove(f.profile.id);
                      } else {
                        _selectedFriends.add(f.profile.id);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.neonGreen.withValues(alpha: 0.08)
                          : AppColors.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? AppColors.neonGreen
                            : AppColors.cardBorder,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: f.profile.avatarColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(f.profile.name[0],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(f.profile.name,
                                  style: AppTextStyles.h3),
                              Text('${f.todayMinutes}dk bugün',
                                  style: AppTextStyles.labelSmall),
                            ],
                          ),
                        ),
                        Icon(
                          selected
                              ? Icons.check_circle_rounded
                              : Icons.circle_outlined,
                          color: selected
                              ? AppColors.neonGreen
                              : AppColors.textTertiary,
                          size: 24,
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
