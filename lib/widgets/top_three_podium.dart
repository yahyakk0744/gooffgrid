import 'package:flutter/material.dart';
import '../config/theme.dart';
import 'parallax_glass_card.dart';

class PodiumEntry {
  const PodiumEntry({required this.name, required this.avatarColor, required this.totalMinutes});
  final String name;
  final Color avatarColor;
  final int totalMinutes;
}

class TopThreePodium extends StatelessWidget {
  const TopThreePodium({super.key, required this.entries});

  final List<PodiumEntry> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.length < 3) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd place
          Expanded(child: _buildCard(entries[1], 2, 110)),
          const SizedBox(width: 8),
          // 1st place — parallax efekti
          Expanded(
            child: ParallaxGlassCard(
              intensity: 8,
              glowColor: AppColors.neonGreen,
              borderRadius: 16,
              blurAmount: 12,
              child: _buildCard(entries[0], 1, 140),
            ),
          ),
          const SizedBox(width: 8),
          // 3rd place
          Expanded(child: _buildCard(entries[2], 3, 100)),
        ],
      ),
    );
  }

  Widget _buildCard(PodiumEntry entry, int rank, double height) {
    final glowColor = rank == 1 ? AppColors.neonGreen : rank == 2 ? AppColors.silver : AppColors.bronze;
    final avatarSize = rank == 1 ? 48.0 : 40.0;
    final initial = entry.name.isNotEmpty ? entry.name[0].toUpperCase() : '?';

    final gradientColors = rank == 1
        ? [const Color(0xFF1A2A1A), const Color(0xFF142014)] // yeşil tinted
        : rank == 2
            ? [const Color(0xFF1E1E28), const Color(0xFF18182A)] // gümüş tinted
            : [const Color(0xFF221A14), const Color(0xFF1A1610)]; // bronz tinted

    return Container(
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: glowColor.withValues(alpha: rank == 1 ? 0.6 : 0.3),
          width: rank == 1 ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: glowColor.withValues(alpha: rank == 1 ? 0.25 : 0.1),
            blurRadius: rank == 1 ? 24 : 16,
            spreadRadius: rank == 1 ? -2 : -4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Crown / rank indicator
          if (rank == 1)
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.neonGreen, Color(0xFFADFF2F)],
              ).createShader(bounds),
              child: const Text('👑', style: TextStyle(fontSize: 16)),
            )
          else
            Text(
              '#$rank',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: glowColor,
                shadows: [
                  Shadow(color: glowColor.withValues(alpha: 0.5), blurRadius: 8),
                ],
              ),
            ),
          const SizedBox(height: 4),

          // Avatar with glow ring
          Container(
            width: avatarSize + 6,
            height: avatarSize + 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: glowColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: glowColor.withValues(alpha: 0.6), width: 2),
              ),
              child: Container(
                decoration: BoxDecoration(color: entry.avatarColor, shape: BoxShape.circle),
                child: Center(
                  child: Text(initial, style: TextStyle(fontSize: avatarSize * 0.35, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Name
          Text(
            entry.name,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          // Time with glow
          Text(
            '${entry.totalMinutes}dk',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: glowColor,
              shadows: [
                Shadow(color: glowColor.withValues(alpha: 0.5), blurRadius: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
