import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../config/app_shadows.dart';
import '../../models/duel_type.dart';
import '../../providers/friends_provider.dart';
import '../../providers/duel_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/duel_config_steps.dart';

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
  int _customHours = 1;
  int _customMinutes = 0;
  String? _selectedPenalty;
  String? _selectedApp;
  String? _selectedCategory;
  int? _diceResult;
  final _selectedFriends = <String>{};
  final _searchController = TextEditingController();
  final _teamNameController = TextEditingController();
  final _opponentTeamNameController = TextEditingController();
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: 1);
    _minuteController = FixedExtentScrollController(initialItem: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    _teamNameController.dispose();
    _opponentTeamNameController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  // Step kinds per duel type, after the initial type-select step (index 0).
  // Always terminates with friend selection.
  List<_StepKind> get _stepKinds {
    final kinds = <_StepKind>[_StepKind.type];
    final type = _selectedType;
    if (type == null) return kinds;
    switch (type.configType) {
      case DuelConfigType.app:
        kinds.add(_StepKind.appPicker);
        kinds.add(_StepKind.friends);
        break;
      case DuelConfigType.category:
        kinds.add(_StepKind.categoryPicker);
        kinds.add(_StepKind.duration);
        kinds.add(_StepKind.friends);
        break;
      case DuelConfigType.dice:
        kinds.add(_StepKind.dice);
        kinds.add(_StepKind.friends);
        break;
      case DuelConfigType.nightMode:
        kinds.add(_StepKind.nightInfo);
        kinds.add(_StepKind.friends);
        break;
      case DuelConfigType.mystery:
        kinds.add(_StepKind.duration);
        kinds.add(_StepKind.mystery);
        kinds.add(_StepKind.friends);
        break;
      case DuelConfigType.team:
        kinds.add(_StepKind.duration);
        kinds.add(_StepKind.teamPicker);
        break;
      case DuelConfigType.penalty:
        kinds.add(_StepKind.duration);
        kinds.add(_StepKind.friends);
        break;
      case DuelConfigType.none:
        // instant has a single fixed duration → skip duration step
        if (type.id == 'instant') {
          kinds.add(_StepKind.friends);
        } else {
          kinds.add(_StepKind.duration);
          kinds.add(_StepKind.friends);
        }
        break;
    }
    return kinds;
  }

  int get _totalSteps => _stepKinds.length;
  _StepKind get _currentKind => _stepKinds[_step];

  void _nextStep() {
    if (_step < _totalSteps - 1) {
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
    switch (_currentKind) {
      case _StepKind.type:
        return _selectedType != null;
      case _StepKind.duration:
        if (_selectedDuration == null) return false;
        return _selectedDuration!.inMinutes >= 10;
      case _StepKind.appPicker:
        return _selectedApp != null;
      case _StepKind.categoryPicker:
        return _selectedCategory != null;
      case _StepKind.dice:
        return _diceResult != null;
      case _StepKind.nightInfo:
      case _StepKind.mystery:
        return true;
      case _StepKind.teamPicker:
        return _selectedFriends.length == 2 || _selectedFriends.length == 3;
      case _StepKind.friends:
        return _selectedFriends.isNotEmpty;
    }
  }

  void _onProceed() {
    final isLast = _step == _totalSteps - 1;
    if (!isLast) {
      _nextStep();
    } else {
      final l = AppLocalizations.of(context)!;
      final subscription = ref.read(subscriptionProvider);
      final activeDuels = ref.read(duelProvider.notifier).activeDuels;
      if (!subscription.isPro &&
          activeDuels.length >= subscription.maxActiveduels) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l.freePlanDuelLimit),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      HapticService.medium();
      context.go('/duel/d1');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
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
                      _titleForKind(_currentKind, l),
                      style: AppType.h2,
                    ),
                    const Spacer(),
                    ...List.generate(_totalSteps, (i) => Container(
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
                  children:
                      _stepKinds.map((k) => _buildStep(k)).toList(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: _canProceed ? AppShadow.glow(AppColors.neonGreen) : AppShadow.none,
                      borderRadius: BorderRadius.circular(14),
                    ),
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
                    child: Text(_step == _totalSteps - 1
                        ? l.duelStartButton
                        : l.continueButton),
                  ),
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
              _selectedApp = null;
              _selectedCategory = null;
              _diceResult = null;
              _selectedFriends.clear();
              // Fixed-duration types auto-set
              if (type.id == 'instant') {
                _selectedDuration = const Duration(hours: 1);
              } else if (type.id == 'app_ban') {
                _selectedDuration = const Duration(hours: 24);
              } else if (type.id == 'night') {
                _selectedDuration = const Duration(hours: 8);
              }
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
                  ? AppShadow.glow(AppColors.neonGreen)
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
                        style: AppType.body,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(type.description,
                        style: AppType.label,
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

  void _setCustomDuration(int hours, int minutes) {
    final totalMin = hours * 60 + minutes;
    final clamped = totalMin.clamp(10, 1440);
    final h = clamped ~/ 60;
    final m = ((clamped % 60) ~/ 5) * 5;
    setState(() {
      _customHours = h;
      _customMinutes = m;
      _selectedDuration = Duration(hours: h, minutes: m);
    });
  }

  void _applyPreset(Duration d) {
    HapticService.light();
    final h = d.inHours;
    final m = d.inMinutes % 60;
    _hourController.animateToItem(h,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    _minuteController.animateToItem(m ~/ 5,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    setState(() {
      _customHours = h;
      _customMinutes = m;
      _selectedDuration = d;
    });
  }

  Widget _buildDurationSelection() {
    final l = AppLocalizations.of(context)!;
    if (_selectedType == null) return const SizedBox.shrink();
    final type = _selectedType!;

    // Preset chips
    final presets = <MapEntry<String, Duration>>[
      const MapEntry('30dk', Duration(minutes: 30)),
      const MapEntry('1s', Duration(hours: 1)),
      const MapEntry('3s', Duration(hours: 3)),
      const MapEntry('6s', Duration(hours: 6)),
      const MapEntry('12s', Duration(hours: 12)),
      const MapEntry('24s', Duration(hours: 24)),
    ];

    final totalMin = _customHours * 60 + _customMinutes;
    final displayText = _customHours > 0 && _customMinutes > 0
        ? '${_customHours}s ${_customMinutes}dk'
        : _customHours > 0
            ? '${_customHours}s'
            : '${_customMinutes}dk';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
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
                      Text(type.name, style: AppType.h2),
                      Text(type.description,
                          style: AppType.body.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(l.quickSelect, style: AppType.caption),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: presets.map((p) {
                final isSelected = _selectedDuration == p.value;
                return GestureDetector(
                  onTap: () => _applyPreset(p.value),
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
                      p.key,
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
            const SizedBox(height: 24),
            Text(l.customDuration, style: AppType.caption),
            const SizedBox(height: 12),
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                children: [
                  // Saat
                  Expanded(
                    child: _WheelPicker(
                      controller: _hourController,
                      itemCount: 25,
                      labelBuilder: (i) => '$i saat',
                      onChanged: (i) => _setCustomDuration(i, _customMinutes),
                    ),
                  ),
                  Container(width: 1, height: 120, color: AppColors.cardBorder),
                  // Dakika
                  Expanded(
                    child: _WheelPicker(
                      controller: _minuteController,
                      itemCount: 12,
                      labelBuilder: (i) => '${i * 5} dk',
                      onChanged: (i) =>
                          _setCustomDuration(_customHours, i * 5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (_selectedDuration != null && totalMin >= 10)
              Center(
                child: Text(
                  l.selectedDuration(displayText),
                  style: AppType.body.copyWith(color: AppColors.neonGreen),
                ),
              ),
            if (_selectedDuration != null && totalMin < 10)
              Center(
                child: Text(
                  l.minDurationWarning,
                  style: AppType.caption
                      .copyWith(color: AppColors.ringWarning),
                ),
              ),
            if (type.id == 'penalty') ...[
              const SizedBox(height: 24),
              Text(l.selectPenalty, style: AppType.caption),
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
      ),
    );
  }

  Widget _teamNameField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: 13,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendSelection({bool teamMode = false}) {
    final l = AppLocalizations.of(context)!;
    final friends = ref.watch(friendsProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (teamMode) ...[
            // Team name inputs
            Row(
              children: [
                Expanded(
                  child: _teamNameField(
                    controller: _teamNameController,
                    hint: 'Senin takımın',
                    icon: Icons.shield_rounded,
                    color: AppColors.neonGreen,
                  ),
                ),
                const SizedBox(width: 10),
                const Text('VS',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    )),
                const SizedBox(width: 10),
                Expanded(
                  child: _teamNameField(
                    controller: _opponentTeamNameController,
                    hint: 'Rakip takım',
                    icon: Icons.shield_outlined,
                    color: AppColors.neonOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.neonGreen.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.neonGreen.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.group_rounded,
                      color: AppColors.neonGreen, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${_selectedFriends.length}/3 seçildi  ·  2 veya 3 takım arkadaşı seç',
                      style: const TextStyle(
                        color: AppColors.neonGreen,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: TextField(
              controller: _searchController,
              style: AppType.body,
              decoration: InputDecoration(
                hintText: l.searchFriend,
                hintStyle: const TextStyle(color: AppColors.textTertiary),
                border: InputBorder.none,
                icon: const Icon(Icons.search_rounded,
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
              child: Row(
                children: [
                  const Icon(Icons.link_rounded,
                      color: AppColors.neonGreen, size: 22),
                  const SizedBox(width: 12),
                  Text(l.inviteWithLink,
                      style: const TextStyle(
                          color: AppColors.neonGreen,
                          fontWeight: FontWeight.w500)),
                  const Spacer(),
                  const Icon(Icons.share_rounded,
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
                        if (teamMode && _selectedFriends.length >= 3) {
                          return;
                        }
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
                                  style: AppType.body),
                              Text(l.todayMinutesLabel(f.todayMinutes),
                                  style: AppType.label),
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

  String _titleForKind(_StepKind kind, AppLocalizations l) {
    switch (kind) {
      case _StepKind.type:
        return l.selectDuelType;
      case _StepKind.duration:
        return l.selectDurationStep;
      case _StepKind.appPicker:
        return 'Uygulama seç';
      case _StepKind.categoryPicker:
        return 'Kategori seç';
      case _StepKind.dice:
        return 'Zar at';
      case _StepKind.nightInfo:
        return 'Gece düellosu';
      case _StepKind.mystery:
        return 'Gizemli görev';
      case _StepKind.teamPicker:
        return 'Takım arkadaşı seç';
      case _StepKind.friends:
        return l.selectOpponent;
    }
  }

  Widget _buildStep(_StepKind kind) {
    switch (kind) {
      case _StepKind.type:
        return _buildTypeSelection();
      case _StepKind.duration:
        return _buildDurationSelection();
      case _StepKind.appPicker:
        return AppPickerStep(
          selectedApp: _selectedApp,
          onSelected: (a) => setState(() => _selectedApp = a),
        );
      case _StepKind.categoryPicker:
        return CategoryPickerStep(
          selectedCategory: _selectedCategory,
          onSelected: (c) => setState(() => _selectedCategory = c),
        );
      case _StepKind.dice:
        return DiceRollerStep(
          result: _diceResult,
          onRolled: (v) => setState(() {
            _diceResult = v;
            _selectedDuration = Duration(minutes: v * 30);
          }),
        );
      case _StepKind.nightInfo:
        return const NightDuelInfoStep();
      case _StepKind.mystery:
        return const MysteryRevealStep();
      case _StepKind.teamPicker:
        return _buildFriendSelection(teamMode: true);
      case _StepKind.friends:
        return _buildFriendSelection();
    }
  }
}

enum _StepKind {
  type,
  duration,
  appPicker,
  categoryPicker,
  dice,
  nightInfo,
  mystery,
  teamPicker,
  friends,
}

class _WheelPicker extends StatelessWidget {
  const _WheelPicker({
    required this.controller,
    required this.itemCount,
    required this.labelBuilder,
    required this.onChanged,
  });

  final FixedExtentScrollController controller;
  final int itemCount;
  final String Function(int) labelBuilder;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 40,
      physics: const FixedExtentScrollPhysics(),
      diameterRatio: 1.5,
      magnification: 1.2,
      useMagnifier: true,
      onSelectedItemChanged: (i) {
        HapticService.selection();
        onChanged(i);
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: itemCount,
        builder: (_, i) {
          return Center(
            child: Text(
              labelBuilder(i),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          );
        },
      ),
    );
  }
}
