import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../providers/stories_provider.dart';
import '../../services/haptic_service.dart';

class CreateStoryScreen extends ConsumerStatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  ConsumerState<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends ConsumerState<CreateStoryScreen> {
  final _captionController = TextEditingController();
  String _selectedActivity = 'Yuruyus';
  String _privacy = 'friends'; // 'friends' | 'everyone'
  Duration _duration = const Duration(hours: 6);
  bool _isPosting = false;

  static const _activities = [
    'Yuruyus', 'Kosu', 'Kitap', 'Meditasyon', 'Dogada',
    'Spor', 'Muzik', 'Yemek', 'Arkadas', 'Aile',
  ];

  static const _presets = [
    ('30sn', Duration(seconds: 30)),
    ('15dk', Duration(minutes: 15)),
    ('1s', Duration(hours: 1)),
    ('6s', Duration(hours: 6)),
    ('12s', Duration(hours: 12)),
    ('24s', Duration(hours: 24)),
  ];

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () => context.pop(),
                  ),
                  const Spacer(),
                  const Text('Hikaye Paylaş', style: AppTextStyles.h2),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Activity chips
                    const Text('Aktivite', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _activities.map((a) {
                        final selected = a == _selectedActivity;
                        return GestureDetector(
                          onTap: () {
                            HapticService.selection();
                            setState(() => _selectedActivity = a);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.neonGreen.withValues(alpha: 0.15)
                                  : AppColors.cardBorder
                                      .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selected
                                    ? AppColors.neonGreen
                                    : AppColors.cardBorder,
                              ),
                            ),
                            child: Text(
                              a,
                              style: TextStyle(
                                fontSize: 13,
                                color: selected
                                    ? AppColors.neonGreen
                                    : AppColors.textSecondary,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Text input
                    const Text('Ne yapiyorsun?', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _captionController,
                      style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500),
                      maxLength: 140,
                      maxLines: 4,
                      minLines: 2,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Telefondan uzakta ne yapiyorsun?',
                        hintStyle: TextStyle(color: AppColors.textTertiary),
                        filled: true,
                        fillColor: AppColors.cardBorder.withValues(alpha: 0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        counterStyle:
                            TextStyle(color: AppColors.textTertiary),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Duration
                    const Text('Ne kadar sure gorunsun?',
                        style: AppTextStyles.label),
                    const SizedBox(height: 12),
                    _buildDurationPicker(),
                    const SizedBox(height: 12),
                    _buildPresetChips(),

                    const SizedBox(height: 24),

                    // Privacy
                    const Text('Kimler gorsun?', style: AppTextStyles.label),
                    const SizedBox(height: 12),
                    _buildPrivacyCards(),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Post button
            Padding(
              padding: EdgeInsets.fromLTRB(
                  16, 8, 16, MediaQuery.of(context).padding.bottom + 12),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isPosting ? null : _post,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  child: _isPosting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.black),
                        )
                      : const Text('Paylaş'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationPicker() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.cardBorder.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder.withValues(alpha: 0.4)),
      ),
      child: CupertinoTimerPicker(
        mode: CupertinoTimerPickerMode.hm,
        initialTimerDuration: _duration,
        minuteInterval: 1,
        onTimerDurationChanged: (d) {
          // Clamp: min 30s, max 24h
          final clamped = d < const Duration(seconds: 30)
              ? const Duration(seconds: 30)
              : d > const Duration(hours: 24)
                  ? const Duration(hours: 24)
                  : d;
          setState(() => _duration = clamped);
        },
      ),
    );
  }

  Widget _buildPresetChips() {
    return Row(
      children: _presets.map((p) {
        final isSelected = p.$2 == _duration;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {
              HapticService.selection();
              setState(() => _duration = p.$2);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.neonGreen
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? AppColors.neonGreen
                      : AppColors.cardBorder,
                ),
              ),
              child: Text(
                p.$1,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.black : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPrivacyCards() {
    return Row(
      children: [
        Expanded(
          child: _PrivacyCard(
            icon: Icons.lock_outline_rounded,
            label: 'Sadece Arkadaslarim',
            isSelected: _privacy == 'friends',
            onTap: () {
              HapticService.selection();
              setState(() => _privacy = 'friends');
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _PrivacyCard(
            icon: Icons.public_rounded,
            label: 'Sehrimdekiler',
            isSelected: _privacy == 'everyone',
            onTap: () {
              HapticService.selection();
              setState(() => _privacy = 'everyone');
            },
          ),
        ),
      ],
    );
  }

  Future<void> _post() async {
    final caption = _captionController.text.trim();
    if (caption.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bir seyler yaz!')),
      );
      return;
    }

    setState(() => _isPosting = true);
    HapticService.medium();

    try {
      final durationHours = (_duration.inMinutes / 60).ceil().clamp(1, 24);
      await ref.read(storiesProvider.notifier).createStory(
            caption: caption,
            activityType: _selectedActivity,
            visibility: _privacy,
            durationHours: durationHours,
          );

      await HapticService.success();
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Uygunsuz icerik tespit edildi'),
            backgroundColor: AppColors.ringDanger,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isPosting = false);
    }
  }
}

class _PrivacyCard extends StatelessWidget {
  const _PrivacyCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withValues(alpha: 0.06),
              border: Border.all(
                color: isSelected
                    ? AppColors.neonGreen
                    : Colors.white.withValues(alpha: 0.1),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Column(
              children: [
                Icon(icon,
                    size: 28,
                    color: isSelected
                        ? AppColors.neonGreen
                        : AppColors.textSecondary),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.neonGreen
                        : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
