import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../providers/o2_provider.dart';
import '../../widgets/breathing_circle.dart';
import '../../widgets/growing_tree.dart';
import '../../services/haptic_service.dart';
import '../../providers/subscription_provider.dart';
import '../../l10n/app_localizations.dart';

class FocusModeScreen extends ConsumerStatefulWidget {
  const FocusModeScreen({super.key});

  @override
  ConsumerState<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends ConsumerState<FocusModeScreen>
    with TickerProviderStateMixin {
  bool _isComplete = false;
  int _earnedO2 = 0;
  int _focusMinutes = 0;
  String? _error;
  late ConfettiController _confetti;
  bool _timeoutDialogShown = false;

  // Breathing
  BreathPattern _selectedPattern = BreathPattern.physiologicalSigh;
  int _breathCount = 0;
  BreathPhase _currentPhase = BreathPhase.inhale;
  bool _showPatternPicker = false;

  // Ambient background animation
  late AnimationController _bgAnimController;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    _bgAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _confetti.dispose();
    _bgAnimController.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    final l = AppLocalizations.of(context)!;
    final notifier = ref.read(focusSessionProvider.notifier);
    final success = await notifier.start();
    if (!success) {
      setState(() => _error = l.o2TimeRestriction);
    } else {
      setState(() {
        _isComplete = false;
        _earnedO2 = 0;
        _error = null;
        _breathCount = 0;
        _showPatternPicker = false;
      });
    }
  }

  Future<void> _stop() async {
    final notifier = ref.read(focusSessionProvider.notifier);
    final result = await notifier.stop();
    setState(() {
      _isComplete = true;
      _earnedO2 = result.o2Earned;
      _focusMinutes = result.minutes;
    });
    if (result.success && result.o2Earned > 0) {
      HapticService.success();
      _confetti.play();
    }
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _showTimeoutDialog() {
    if (_timeoutDialogShown) return;
    _timeoutDialogShown = true;
    final l = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l.focusTimeout, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        content: Text(
          l.focusTimeoutDesc,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _timeoutDialogShown = false;
            },
            child: Text(l.ok, style: const TextStyle(color: AppColors.neonGreen)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final session = ref.watch(focusSessionProvider);
    final o2 = ref.watch(o2Provider);

    ref.listen<FocusSessionState>(focusSessionProvider, (prev, next) {
      if (next.isTimeout && !(prev?.isTimeout ?? false)) {
        _showTimeoutDialog();
      }
    });

    final isActive = session.isActive;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgAnimController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isActive
                    ? [
                        Color.lerp(const Color(0xFF0D0D2B), const Color(0xFF0A1628), _bgAnimController.value)!,
                        Color.lerp(const Color(0xFF1A0D3B), const Color(0xFF0D2137), _bgAnimController.value)!,
                      ]
                    : const [Color(0xFF0D0D2B), Color(0xFF1A0D3B)],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ConfettiWidget(
                confettiController: _confetti,
                blastDirectionality: BlastDirectionality.explosive,
                colors: const [AppColors.neonGreen, AppColors.gold, AppColors.neonOrange],
              ),
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.vertical,
                  ),
                  child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Top bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            HapticService.light();
                            context.pop();
                          },
                          child: Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.06),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close_rounded, color: Colors.white54, size: 18),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // O2 pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('O₂', style: TextStyle(fontSize: 13, color: AppColors.neonGreen.withValues(alpha: 0.7))),
                              const SizedBox(width: 4),
                              Text('${o2.balance}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.neonGreen)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const SizedBox(width: 36),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Timer
                  Text(
                    _formatTime(session.elapsedSeconds),
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w100,
                      color: Colors.white.withValues(alpha: isActive ? 0.9 : 0.4),
                      letterSpacing: 8,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),

                  // Timeout warning
                  if (session.isActive && session.isNearTimeout)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        l.minutesRemaining(session.remainingSeconds ~/ 60),
                        style: const TextStyle(fontSize: 12, color: AppColors.ringDanger),
                      ),
                    ),

                  const SizedBox(height: 12),

                  // Growing tree
                  if (isActive || _isComplete)
                    GrowingTree(
                      progress: _isComplete
                          ? 1.0
                          : (session.elapsedSeconds / 7200).clamp(0.0, 1.0),
                      isComplete: _isComplete,
                      height: 200,
                    ),

                  const SizedBox(height: 24),

                  // Breathing circle
                  BreathingCircle(
                    isActive: isActive,
                    pattern: _selectedPattern,
                    onPhaseChange: (phase) {
                      if (!mounted) return;
                      setState(() => _currentPhase = phase);
                      if (phase == BreathPhase.inhale) {
                        HapticService.light();
                      } else if (phase == BreathPhase.exhale) {
                        HapticService.selection();
                      }
                    },
                    onBreathComplete: () {
                      if (!mounted) return;
                      setState(() => _breathCount++);
                    },
                  ),

                  const SizedBox(height: 20),

                  // Phase indicator dots + breath count
                  if (isActive) ...[
                    _PhaseIndicator(currentPhase: _currentPhase, pattern: _selectedPattern),
                    const SizedBox(height: 16),
                    Text(
                      l.breathCount(_breathCount),
                      style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.4), letterSpacing: 1),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '+${(session.elapsedMinutes * 3).clamp(0, 500)} O₂',
                      style: TextStyle(fontSize: 13, color: AppColors.neonGreen.withValues(alpha: 0.6)),
                    ),
                  ],

                  // Completion state
                  if (!isActive && _isComplete) ...[
                    const SizedBox(height: 8),
                    Text(
                      l.focusMinutes(_focusMinutes),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('+$_earnedO2 O₂', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.gold, shadows: [Shadow(color: AppColors.gold.withValues(alpha: 0.4), blurRadius: 8)])),
                        const SizedBox(width: 16),
                        Text(l.breathCount(_breathCount), style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.5))),
                      ],
                    ),
                  ],

                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(_error!, style: const TextStyle(fontSize: 13, color: AppColors.ringDanger)),
                    ),

                  const SizedBox(height: 24),

                  // Pattern selector (only when not active)
                  if (!isActive && !_isComplete)
                    _PatternSelector(
                      selected: _selectedPattern,
                      expanded: _showPatternPicker,
                      maxTechniques: ref.watch(subscriptionProvider).maxBreathTechniques,
                      onToggle: () => setState(() => _showPatternPicker = !_showPatternPicker),
                      onSelect: (p) => setState(() {
                        _selectedPattern = p;
                        _showPatternPicker = false;
                        HapticService.selection();
                      }),
                    ),

                  const SizedBox(height: 16),

                  // Main button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          HapticService.medium();
                          (isActive ? _stop : _start)();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isActive
                              ? Colors.white.withValues(alpha: 0.08)
                              : AppColors.neonGreen,
                          foregroundColor: isActive ? Colors.white : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: isActive
                                ? BorderSide(color: Colors.white.withValues(alpha: 0.1))
                                : BorderSide.none,
                          ),
                          elevation: 0,
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        child: Text(isActive ? l.end : l.start),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// PHASE INDICATOR — shows 4 dots for phases
// ─────────────────────────────────────────

class _PhaseIndicator extends StatelessWidget {
  const _PhaseIndicator({required this.currentPhase, required this.pattern});
  final BreathPhase currentPhase;
  final BreathPattern pattern;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final timing = pattern.timing;
    final phases = <(BreathPhase, String, double)>[
      (BreathPhase.inhale, l.inhale, timing.$1),
      if (timing.$2 > 0) (BreathPhase.holdIn, l.holdBreath, timing.$2),
      (BreathPhase.exhale, l.exhale, timing.$3),
      if (timing.$4 > 0) (BreathPhase.holdOut, l.waitBreath, timing.$4),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: phases.map((p) {
        final isActive = p.$1 == currentPhase;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isActive ? 10 : 6,
                height: isActive ? 10 : 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.2),
                  boxShadow: isActive
                      ? [BoxShadow(color: Colors.white.withValues(alpha: 0.4), blurRadius: 8)]
                      : null,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${p.$2} ${p.$3.round()}s',
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? Colors.white.withValues(alpha: 0.7) : Colors.white.withValues(alpha: 0.25),
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────
// PATTERN SELECTOR — expandable chip
// ─────────────────────────────────────────

class _PatternSelector extends StatelessWidget {
  const _PatternSelector({
    required this.selected,
    required this.expanded,
    required this.maxTechniques,
    required this.onToggle,
    required this.onSelect,
  });
  final BreathPattern selected;
  final bool expanded;
  final int maxTechniques;
  final VoidCallback onToggle;
  final ValueChanged<BreathPattern> onSelect;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      children: [
        // Selected pattern chip
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(selected.emoji, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(selected.label, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.8), fontWeight: FontWeight.w500)),
                const SizedBox(width: 6),
                Icon(expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded, color: Colors.white38, size: 18),
              ],
            ),
          ),
        ),

        // Expanded picker
        if (expanded) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 250),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SingleChildScrollView(
                child: Column(
                  children: BreathPattern.values.asMap().entries.map((entry) {
                final index = entry.key;
                final p = entry.value;
                final isLocked = index >= maxTechniques;
                final isSelected = p == selected;
                return GestureDetector(
                  onTap: isLocked
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l.breathTechniqueProMsg),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      : () => onSelect(p),
                  child: Opacity(
                    opacity: isLocked ? 0.5 : 1.0,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.neonGreen.withValues(alpha: 0.1)
                            : Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.neonGreen.withValues(alpha: 0.3)
                              : Colors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(p.emoji, style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.label, style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? AppColors.neonGreen : Colors.white.withValues(alpha: 0.8),
                                )),
                                Text(p.description, style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.4))),
                              ],
                            ),
                          ),
                          if (isLocked) ...[
                            const Icon(Icons.lock_rounded, size: 14, color: Colors.white54),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.gold.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
                              ),
                              child: Text(
                                l.pro,
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.gold.withValues(alpha: 0.9)),
                              ),
                            ),
                          ] else
                            // Timing badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _timingLabel(p),
                                style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.4), fontFeatures: const [FontFeature.tabularFigures()]),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  String _timingLabel(BreathPattern p) {
    final t = p.timing;
    final parts = <String>[];
    if (t.$1 > 0) parts.add('${t.$1.round()}');
    if (t.$2 > 0) parts.add('${t.$2.round()}');
    if (t.$3 > 0) parts.add('${t.$3.round()}');
    if (t.$4 > 0) parts.add('${t.$4.round()}');
    return parts.join('-');
  }
}
