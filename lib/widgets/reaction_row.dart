import 'package:flutter/material.dart';
import '../config/theme.dart';

class ReactionRow extends StatelessWidget {
  const ReactionRow({
    super.key,
    this.emojis = const ['🫣', '👏', '🔥', '💀'],
    this.counts = const {},
    this.onReact,
  });

  final List<String> emojis;
  final Map<String, int> counts;
  final ValueChanged<String>? onReact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: emojis.map((emoji) {
        final count = counts[emoji] ?? 0;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: _ReactionPill(emoji: emoji, count: count, onTap: () => onReact?.call(emoji)),
        );
      }).toList(),
    );
  }
}

class _ReactionPill extends StatefulWidget {
  const _ReactionPill({required this.emoji, required this.count, required this.onTap});
  final String emoji;
  final int count;
  final VoidCallback onTap;

  @override
  State<_ReactionPill> createState() => _ReactionPillState();
}

class _ReactionPillState extends State<_ReactionPill> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.05), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 20),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(from: 0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.cardBorder, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.emoji, style: const TextStyle(fontSize: 16)),
              if (widget.count > 0) ...[
                const SizedBox(width: 4),
                Text('${widget.count}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
