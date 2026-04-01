import 'dart:math';
import 'package:flutter/material.dart';
import '../config/theme.dart';

/// Interactive "gooffgrid" logo where the "oo" letters act as eyes
/// that track the user's touch/pointer position with spring physics.
///
/// For full-screen tracking, wrap the parent with [GoOffGridEyeTracker]:
/// ```dart
/// GoOffGridEyeTracker(
///   child: Scaffold(
///     body: Column(children: [
///       InteractiveGoOffGridLogo(fontSize: 32),
///       // ... rest of UI
///     ]),
///   ),
/// )
/// ```
class InteractiveGoOffGridLogo extends StatefulWidget {
  final double fontSize;
  final double letterSpacing;

  const InteractiveGoOffGridLogo({
    super.key,
    this.fontSize = 32,
    this.letterSpacing = 2,
  });

  @override
  State<InteractiveGoOffGridLogo> createState() =>
      _InteractiveGoOffGridLogoState();
}

class _InteractiveGoOffGridLogoState extends State<InteractiveGoOffGridLogo>
    with TickerProviderStateMixin {
  final ValueNotifier<Offset> _leftPupil = ValueNotifier(Offset.zero);
  final ValueNotifier<Offset> _rightPupil = ValueNotifier(Offset.zero);

  Offset _leftTarget = Offset.zero;
  Offset _rightTarget = Offset.zero;

  late AnimationController _springController;

  final GlobalKey _leftEyeKey = GlobalKey();
  final GlobalKey _rightEyeKey = GlobalKey();

  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  late AnimationController _idleController;
  Offset _idleTarget = Offset.zero;
  final _random = Random();

  _GoOffGridEyeTrackerState? _tracker;

  @override
  void initState() {
    super.initState();

    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    )..addListener(_updatePupils);

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _blinkAnimation = Tween<double>(begin: 1.0, end: 0.1).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );
    _blinkController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _blinkController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _scheduleNextBlink();
      }
    });
    _scheduleNextBlink();

    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        final t = _idleController.value;
        _leftTarget = Offset.lerp(Offset.zero, _idleTarget, t) ?? Offset.zero;
        _rightTarget = _leftTarget;
        _springController.forward(from: 0);
      });
    _scheduleIdleWander();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Register with ancestor GoOffGridEyeTracker if exists
    final tracker = context.findAncestorStateOfType<_GoOffGridEyeTrackerState>();
    if (tracker != _tracker) {
      _tracker?._unregisterEye(this);
      _tracker = tracker;
      _tracker?._registerEye(this);
    }
  }

  void _scheduleNextBlink() {
    final delay = Duration(milliseconds: 2000 + _random.nextInt(4000));
    Future.delayed(delay, () {
      if (!mounted) return;
      _blinkController.forward(from: 0);
    });
  }

  void _scheduleIdleWander() {
    final delay = Duration(milliseconds: 3000 + _random.nextInt(3000));
    Future.delayed(delay, () {
      if (!mounted) return;
      _idleTarget = Offset(
        (_random.nextDouble() - 0.5) * 0.4,
        (_random.nextDouble() - 0.5) * 0.3,
      );
      _idleController.forward(from: 0).then((_) {
        if (!mounted) return;
        Future.delayed(const Duration(milliseconds: 800), () {
          if (!mounted) return;
          _idleTarget = Offset.zero;
          _idleController.forward(from: 0).then((_) {
            if (mounted) _scheduleIdleWander();
          });
        });
      });
    });
  }

  void _updatePupils() {
    const damping = 0.25;
    final leftCurrent = _leftPupil.value;
    final rightCurrent = _rightPupil.value;

    _leftPupil.value = Offset(
      leftCurrent.dx + (_leftTarget.dx - leftCurrent.dx) * damping,
      leftCurrent.dy + (_leftTarget.dy - leftCurrent.dy) * damping,
    );
    _rightPupil.value = Offset(
      rightCurrent.dx + (_rightTarget.dx - rightCurrent.dx) * damping,
      rightCurrent.dy + (_rightTarget.dy - rightCurrent.dy) * damping,
    );
  }

  Offset _calculatePupilOffset(GlobalKey eyeKey, Offset pointerGlobal) {
    final renderBox =
        eyeKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return Offset.zero;

    final eyeCenter = renderBox.localToGlobal(
      Offset(renderBox.size.width / 2, renderBox.size.height / 2),
    );

    final dx = pointerGlobal.dx - eyeCenter.dx;
    final dy = pointerGlobal.dy - eyeCenter.dy;
    final distance = sqrt(dx * dx + dy * dy);

    if (distance < 1) return Offset.zero;

    const maxDistance = 300.0;
    final normalizedDistance = (distance / maxDistance).clamp(0.0, 1.0);
    final angle = atan2(dy, dx);

    return Offset(
      cos(angle) * normalizedDistance,
      sin(angle) * normalizedDistance,
    );
  }

  void onPointerEvent(Offset globalPosition) {
    _leftTarget = _calculatePupilOffset(_leftEyeKey, globalPosition);
    _rightTarget = _calculatePupilOffset(_rightEyeKey, globalPosition);
    _springController.forward(from: 0);
  }

  void onPointerReset() {
    _leftTarget = Offset.zero;
    _rightTarget = Offset.zero;
    _springController.forward(from: 0);
  }

  @override
  void dispose() {
    _tracker?._unregisterEye(this);
    _springController.dispose();
    _blinkController.dispose();
    _idleController.dispose();
    _leftPupil.dispose();
    _rightPupil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eyeDiameter = widget.fontSize * 0.72;
    final pupilDiameter = eyeDiameter * 0.45;
    final maxPupilTravel = (eyeDiameter - pupilDiameter) / 2 * 0.75;

    final logo = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('g', style: _letterStyle),
        SizedBox(width: widget.letterSpacing),
        _buildEye(
          key: _leftEyeKey,
          diameter: eyeDiameter,
          pupilDiameter: pupilDiameter,
          maxTravel: maxPupilTravel,
          notifier: _leftPupil,
        ),
        SizedBox(width: widget.letterSpacing * 0.5),
        _buildEye(
          key: _rightEyeKey,
          diameter: eyeDiameter,
          pupilDiameter: pupilDiameter,
          maxTravel: maxPupilTravel,
          notifier: _rightPupil,
        ),
        SizedBox(width: widget.letterSpacing),
        Text('ffgrid', style: _letterStyle),
      ],
    );

    // If no ancestor tracker, use self-contained Listener
    if (_tracker == null) {
      return Listener(
        onPointerDown: (e) => onPointerEvent(e.position),
        onPointerMove: (e) => onPointerEvent(e.position),
        onPointerUp: (_) => onPointerReset(),
        behavior: HitTestBehavior.translucent,
        child: logo,
      );
    }

    return logo;
  }

  TextStyle get _letterStyle => TextStyle(
        fontSize: widget.fontSize,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: widget.letterSpacing,
        height: 1.0,
      );

  Widget _buildEye({
    required GlobalKey key,
    required double diameter,
    required double pupilDiameter,
    required double maxTravel,
    required ValueNotifier<Offset> notifier,
  }) {
    return AnimatedBuilder(
      animation: _blinkAnimation,
      builder: (context, child) {
        return Transform.scale(
          scaleY: _blinkAnimation.value,
          child: child,
        );
      },
      child: Container(
        key: key,
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.textPrimary,
            width: diameter * 0.08,
          ),
        ),
        child: ValueListenableBuilder<Offset>(
          valueListenable: notifier,
          builder: (context, offset, _) {
            final px = offset.dx * maxTravel;
            final py = offset.dy * maxTravel;

            return Stack(
              alignment: Alignment.center,
              children: [
                Transform.translate(
                  offset: Offset(px, py),
                  child: Container(
                    width: pupilDiameter * 1.6,
                    height: pupilDiameter * 1.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonGreen.withValues(alpha: 0.4),
                          blurRadius: pupilDiameter * 0.8,
                          spreadRadius: pupilDiameter * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(px, py),
                  child: Container(
                    width: pupilDiameter,
                    height: pupilDiameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.neonGreen,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonGreen.withValues(alpha: 0.6),
                          blurRadius: pupilDiameter * 0.5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: const Alignment(-0.35, -0.35),
                      child: Container(
                        width: pupilDiameter * 0.25,
                        height: pupilDiameter * 0.25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Wrap any screen with this to enable full-screen pointer tracking
/// for all [InteractiveGoOffGridLogo] widgets inside it.
///
/// ```dart
/// GoOffGridEyeTracker(
///   child: Scaffold(body: ...),
/// )
/// ```
class GoOffGridEyeTracker extends StatefulWidget {
  final Widget child;

  const GoOffGridEyeTracker({super.key, required this.child});

  @override
  State<GoOffGridEyeTracker> createState() => _GoOffGridEyeTrackerState();
}

class _GoOffGridEyeTrackerState extends State<GoOffGridEyeTracker> {
  final Set<_InteractiveGoOffGridLogoState> _eyes = {};

  void _registerEye(_InteractiveGoOffGridLogoState eye) {
    _eyes.add(eye);
  }

  void _unregisterEye(_InteractiveGoOffGridLogoState eye) {
    _eyes.remove(eye);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) {
        for (final eye in _eyes) {
          eye.onPointerEvent(e.position);
        }
      },
      onPointerMove: (e) {
        for (final eye in _eyes) {
          eye.onPointerEvent(e.position);
        }
      },
      onPointerUp: (_) {
        for (final eye in _eyes) {
          eye.onPointerReset();
        }
      },
      onPointerHover: (e) {
        for (final eye in _eyes) {
          eye.onPointerEvent(e.position);
        }
      },
      behavior: HitTestBehavior.translucent,
      child: widget.child,
    );
  }
}
