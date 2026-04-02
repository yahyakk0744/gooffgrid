import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class FriendTileApp {
  const FriendTileApp({required this.name, required this.color, required this.minutes});
  final String name;
  final Color color;
  final int minutes;
}

class FriendTile extends StatefulWidget {
  const FriendTile({
    super.key,
    required this.name,
    required this.avatarColor,
    required this.todayMinutes,
    this.isOnline = false,
    this.topApps = const [],
  });

  final String name;
  final Color avatarColor;
  final int todayMinutes;
  final bool isOnline;
  final List<FriendTileApp> topApps;

  @override
  State<FriendTile> createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color get _borderColor {
    if (widget.todayMinutes <= AppConstants.goodMinutes) return AppColors.ringGood;
    if (widget.todayMinutes <= AppConstants.warningMinutes) return AppColors.ringWarning;
    return AppColors.ringDanger;
  }

  Color get _timeColor => _borderColor;

  @override
  Widget build(BuildContext context) {
    final initial = widget.name.isNotEmpty ? widget.name[0].toUpperCase() : '?';

    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor.withValues(alpha: 0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: _borderColor.withValues(alpha: 0.08),
            blurRadius: 16,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with status dot
          SizedBox(
            width: 52,
            height: 52,
            child: Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: widget.avatarColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: _borderColor, width: 2.5),
                  ),
                  child: Center(
                    child: Text(initial, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: widget.isOnline ? _pulseAnimation.value : 1.0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: widget.isOnline ? AppColors.friendOnline : AppColors.friendActive,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.cardBg, width: 1.5),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Name
          Text(
            widget.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),

          // Today's time
          Text(
            '${widget.todayMinutes}dk',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: _timeColor),
          ),
          const SizedBox(height: 8),

          // Mini app distribution bar
          if (widget.topApps.isNotEmpty) _buildAppBar(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    final total = widget.topApps.fold<int>(0, (sum, a) => sum + a.minutes);
    if (total == 0) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: SizedBox(
        height: 4,
        child: Row(
          children: widget.topApps.map((app) {
            final flex = ((app.minutes / total) * 100).round().clamp(1, 100);
            return Expanded(
              flex: flex,
              child: Container(color: app.color),
            );
          }).toList(),
        ),
      ),
    );
  }
}

