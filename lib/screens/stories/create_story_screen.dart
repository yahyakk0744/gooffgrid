import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../config/app_shadows.dart';
import '../../providers/stories_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';

class CreateStoryScreen extends ConsumerStatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  ConsumerState<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends ConsumerState<CreateStoryScreen> {
  final _captionController = TextEditingController();
  final _imagePicker = ImagePicker();
  XFile? _selectedImage;
  XFile? _selectedVideo;
  String _privacy = 'friends'; // 'friends' | 'everyone'
  Duration _duration = const Duration(hours: 6);
  bool _isPosting = false;

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
    final l = AppLocalizations.of(context)!;
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
                  Text(l.createStoryTitle, style: AppType.h2),
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
                    // Photo
                    Builder(builder: (context) {
                      final canUsePhoto = ref
                          .watch(subscriptionProvider)
                          .canUsePhotoStories;
                      final hasMedia = _selectedImage != null || _selectedVideo != null;
                      return GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            Container(
                        height: hasMedia ? 200 : 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.cardBorder.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.cardBorder.withValues(alpha: 0.4),
                            style: hasMedia ? BorderStyle.none : BorderStyle.solid,
                          ),
                          image: _selectedImage != null && !kIsWeb
                              ? DecorationImage(
                                  image: FileImage(File(_selectedImage!.path)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: !hasMedia
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate_outlined,
                                      size: 36, color: AppColors.textTertiary),
                                  const SizedBox(height: 6),
                                  Text('${l.addPhoto}  •  Video',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textTertiary)),
                                ],
                              )
                            : _selectedVideo != null
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.play_circle_fill_rounded,
                                        size: 56, color: AppColors.neonGreen),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Video seçildi',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              )
                            : Stack(
                                children: [
                                  if (kIsWeb)
                                    Center(
                                      child: Icon(Icons.image_rounded,
                                          size: 48, color: AppColors.neonGreen),
                                    ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () => setState(() {
                                        _selectedImage = null;
                                        _selectedVideo = null;
                                      }),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.6),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.close_rounded,
                                            size: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!canUsePhoto)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.neonGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    l.pro,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 16),

                    // Text input
                    Text(l.whatAreYouDoing, style: AppType.caption),
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
                        hintText: l.captionHint,
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
                    Text(l.howLongVisible, style: AppType.caption),
                    const SizedBox(height: 12),
                    _buildDurationPicker(),
                    const SizedBox(height: 12),
                    _buildPresetChips(),

                    const SizedBox(height: 24),

                    // Privacy
                    Text(l.whoCanSee, style: AppType.caption),
                    const SizedBox(height: 12),
                    _buildPrivacyCards(l),

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
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: !_isPosting ? AppShadow.glow(AppColors.neonGreen) : AppShadow.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                      : Text(l.postStory),
                ),
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

  Widget _buildPrivacyCards(AppLocalizations l) {
    return Row(
      children: [
        Expanded(
          child: _PrivacyCard(
            icon: Icons.lock_outline_rounded,
            label: l.onlyFriends,
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
            label: l.cityPeople,
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

  Future<void> _pickImage() async {
    final l = AppLocalizations.of(context)!;
    final canUsePhoto = ref.read(subscriptionProvider).canUsePhotoStories;
    if (!canUsePhoto) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.photoStoriesPro),
        ),
      );
      return;
    }
    HapticService.selection();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: AppColors.neonGreen),
                title: Text(l.camera, style: const TextStyle(color: AppColors.textPrimary)),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: AppColors.neonGreen),
                title: Text(l.gallery, style: const TextStyle(color: AppColors.textPrimary)),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              const Divider(color: AppColors.cardBorder),
              ListTile(
                leading: const Icon(Icons.videocam_rounded, color: AppColors.neonGreen),
                title: const Text('Video çek',
                    style: TextStyle(color: AppColors.textPrimary)),
                onTap: () async {
                  Navigator.pop(context);
                  final picked = await _imagePicker.pickVideo(
                    source: ImageSource.camera,
                    maxDuration: const Duration(seconds: 30),
                  );
                  if (picked != null && mounted) {
                    setState(() {
                      _selectedVideo = picked;
                      _selectedImage = null;
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_library_rounded, color: AppColors.neonGreen),
                title: const Text('Galeriden video',
                    style: TextStyle(color: AppColors.textPrimary)),
                onTap: () async {
                  Navigator.pop(context);
                  final picked = await _imagePicker.pickVideo(
                    source: ImageSource.gallery,
                    maxDuration: const Duration(seconds: 30),
                  );
                  if (picked != null && mounted) {
                    setState(() {
                      _selectedVideo = picked;
                      _selectedImage = null;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
    if (source == null) return;
    final picked = await _imagePicker.pickImage(source: source, maxWidth: 1080, imageQuality: 85);
    if (picked != null) {
      setState(() => _selectedImage = picked);
    }
  }

  Future<void> _post() async {
    final l = AppLocalizations.of(context)!;
    final caption = _captionController.text.trim();
    final hasMedia = _selectedImage != null || _selectedVideo != null;
    if (caption.isEmpty && !hasMedia) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.writeFirst)),
      );
      return;
    }

    setState(() => _isPosting = true);
    HapticService.medium();

    try {
      final durationHours = (_duration.inMinutes / 60).ceil().clamp(1, 24);

      List<int>? mediaBytes;
      String? mediaExt;
      String storyType = 'photo';
      if (_selectedVideo != null) {
        mediaBytes = await _selectedVideo!.readAsBytes();
        mediaExt = _selectedVideo!.name.split('.').last.toLowerCase();
        if (!['mp4', 'mov', 'm4v', 'webm'].contains(mediaExt)) mediaExt = 'mp4';
        storyType = 'video';
      } else if (_selectedImage != null) {
        mediaBytes = await _selectedImage!.readAsBytes();
        mediaExt = _selectedImage!.name.split('.').last.toLowerCase();
        if (!['jpg', 'jpeg', 'png', 'webp'].contains(mediaExt)) mediaExt = 'jpg';
      }

      await ref.read(storiesProvider.notifier).createStory(
            caption: caption,
            activityType: null,
            visibility: _privacy,
            storyType: storyType,
            durationHours: durationHours,
            imageBytes: mediaBytes,
            imageExtension: mediaExt,
          );

      await HapticService.success();
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l.inappropriateContent),
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
