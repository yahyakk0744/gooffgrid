import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/duel.dart' show DuelStatus;
import 'app_card.dart';

class DuelCard extends StatefulWidget {
  const DuelCard({
    super.key,
    required this.player1Name,
    required this.player1Minutes,
    required this.player2Name,
    required this.player2Minutes,
    required this.status,
    this.winnerId,
  });

  final String player1Name;
  final int player1Minutes;
  final String player2Name;
  final int player2Minutes;
  final DuelStatus status;
  final String? winnerId;

  @override
  State<DuelCard> createState() => _DuelCardState();
}

class _DuelCardState extends State<DuelCard> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (widget.status == DuelStatus.active) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(DuelCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status == DuelStatus.active && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (widget.status != DuelStatus.active) {
      _pulseController.stop();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.status == DuelStatus.active;
    final isCompleted = widget.status == DuelStatus.completed;
    final p1Won = isCompleted && widget.player1Minutes <= widget.player2Minutes;
    final p2Won = isCompleted && widget.player2Minutes < widget.player1Minutes;

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return AppCard(
          borderColor: isActive
              ? AppColors.neonGreen.withOpacity(0.4 + _pulseController.value * 0.6)
              : null,
          child: Row(
            children: [
              // Player 1
              Expanded(child: _buildPlayer(widget.player1Name, widget.player1Minutes, p1Won, p2Won)),

              // VS
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2A1A0A), Color(0xFF1A1410)],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.neonOrange.withOpacity(0.4)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonOrange.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neonOrange,
                      shadows: [Shadow(color: AppColors.neonOrange.withOpacity(0.5), blurRadius: 6)],
                    ),
                  ),
                ),
              ),

              // Player 2
              Expanded(child: _buildPlayer(widget.player2Name, widget.player2Minutes, p2Won, p1Won)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlayer(String name, int minutes, bool isWinner, bool isLoser) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final timeColor = isWinner ? AppColors.ringGood : isLoser ? AppColors.ringDanger : AppColors.textPrimary;

    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: isWinner ? AppColors.ringGood : isLoser ? AppColors.ringDanger : AppColors.cardBorder, width: 2),
          ),
          child: Center(
            child: Text(initial, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
        Text('${minutes}dk', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: timeColor)),
      ],
    );
  }
}

