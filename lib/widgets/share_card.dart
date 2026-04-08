import 'package:flutter/material.dart';
import '../config/theme.dart';

/// Instagram Story / WhatsApp status share card (1080x1920).
///
/// Inspired by Strava Year in Sport, Spotify Wrapped, Duolingo and Nike Run
/// Club share cards: bold hero typography, layered glows, glassmorphism stat
/// cards, single accent color drives emotion (green = win, red = loss).
class DuelShareCard extends StatelessWidget {
  const DuelShareCard({
    super.key,
    required this.won,
    required this.playerName,
    required this.playerMinutes,
    required this.opponentName,
    required this.opponentMinutes,
    required this.dateLabel,
    required this.duelTypeLabel,
    this.durationLabel,
    this.detailLine,
  });

  final bool won;
  final String playerName;
  final int playerMinutes;
  final String opponentName;
  final int opponentMinutes;
  final String dateLabel;
  final String duelTypeLabel;

  /// e.g. "24 SAAT", "8 SAAT (GECE)", "1 HAFTA"
  final String? durationLabel;

  /// Rich reason line — e.g. "Instagram'ı 42 dakika daha fazla açtın"
  /// or "Sosyal medyada 1 saat geride kaldın".
  final String? detailLine;

  static const double _w = 1080;
  static const double _h = 1920;

  @override
  Widget build(BuildContext context) {
    final accent = won ? AppColors.neonGreen : AppColors.ringDanger;
    final headline = won ? 'KAZANDIM' : 'YENİLDİM';
    final subline = won
        ? 'Rakibime fark attım. Sıra sende.'
        : 'İntikam vakti. Bana meydan oku.'
        '';
    final diff = (opponentMinutes - playerMinutes).abs();

    return SizedBox(
      width: _w,
      height: _h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Layer 1: Dark gradient base ─────────────────────────────────
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.8, -1),
                end: Alignment(0.9, 1),
                colors: [
                  Colors.black,
                  AppColors.bg,
                  AppColors.surface,
                ],
                stops: [0, 0.5, 1],
              ),
            ),
          ),

          // ── Layer 2: Radial accent glow ─────────────────────────────────
          Align(
            alignment: const Alignment(0, -0.25),
            child: Container(
              width: 1400,
              height: 1400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    accent.withValues(alpha: 0.28),
                    accent.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  stops: const [0, 0.4, 1],
                ),
              ),
            ),
          ),

          // ── Layer 3: Subtle grid texture (diagonal bars) ───────────────
          Opacity(
            opacity: 0.04,
            child: CustomPaint(painter: _GridPainter(accent)),
          ),

          // ── Layer 4: Content ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(72, 100, 72, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top row: brand mark + date
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: accent.withValues(alpha: 0.6),
                            blurRadius: 30,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'g',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Text(
                      'gooffgrid',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      dateLabel,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.55),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 120),

                // Duel type + duration badges
                Wrap(
                  spacing: 14,
                  runSpacing: 10,
                  children: [
                    _TagBadge(text: duelTypeLabel.toUpperCase(), accent: accent),
                    if (durationLabel != null)
                      _TagBadge(
                        text: durationLabel!.toUpperCase(),
                        accent: accent,
                        outlined: true,
                      ),
                  ],
                ),

                const SizedBox(height: 22),

                // Hero headline — enormous
                Text(
                  headline,
                  style: TextStyle(
                    fontSize: 180,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 0.95,
                    letterSpacing: -4,
                    shadows: [
                      Shadow(
                        color: accent.withValues(alpha: 0.5),
                        blurRadius: 50,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Accent underline
                Container(
                  width: 200,
                  height: 8,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.8),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Subline
                Text(
                  subline,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.75),
                    height: 1.3,
                  ),
                ),

                if (detailLine != null) ...[
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border(
                        left: BorderSide(color: accent, width: 4),
                      ),
                    ),
                    child: Text(
                      detailLine!,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.85),
                        height: 1.3,
                      ),
                    ),
                  ),
                ],

                const Spacer(),

                // Stat card — glassmorphism, head-to-head
                Container(
                  padding: const EdgeInsets.all(44),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _StatSide(
                          name: playerName,
                          minutes: playerMinutes,
                          isWinner: won,
                          accent: accent,
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 180,
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                      Expanded(
                        child: _StatSide(
                          name: opponentName,
                          minutes: opponentMinutes,
                          isWinner: !won,
                          accent: accent,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Key stat ribbon
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accent.withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        won
                            ? Icons.trending_down_rounded
                            : Icons.trending_up_rounded,
                        color: accent,
                        size: 40,
                      ),
                      const SizedBox(width: 14),
                      Text(
                        won
                            ? '$diff dakika daha az ekran'
                            : '$diff dakika fazla ekran',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Footer CTA
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Fişi çek. Oyuna başla.',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'gooffgrid.com',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.4),
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatSide extends StatelessWidget {
  const _StatSide({
    required this.name,
    required this.minutes,
    required this.isWinner,
    required this.accent,
  });

  final String name;
  final int minutes;
  final bool isWinner;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return Column(
      children: [
        SizedBox(
          height: 44,
          child: isWinner
              ? const Text('👑', style: TextStyle(fontSize: 40))
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.75),
            letterSpacing: 0.5,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 14),
        Text(
          '${hours}s ${mins}dk',
          style: TextStyle(
            fontSize: 54,
            fontWeight: FontWeight.w900,
            color: isWinner ? accent : Colors.white.withValues(alpha: 0.55),
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _TagBadge extends StatelessWidget {
  const _TagBadge({
    required this.text,
    required this.accent,
    this.outlined = false,
  });

  final String text;
  final Color accent;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : accent.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: accent.withValues(alpha: outlined ? 0.6 : 0.35),
          width: 2,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: accent,
          letterSpacing: 3,
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;
    const step = 60.0;
    for (double x = -size.height; x < size.width; x += step) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => false;
}
