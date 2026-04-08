import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/user_provider.dart';
import '../../services/haptic_service.dart';
import '../../services/location_service.dart';
import '../../widgets/premium_background.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _usernameCtrl;

  Timer? _debounce;
  _UsernameStatus _usernameStatus = _UsernameStatus.idle;
  String _city = '';
  bool _locationLoading = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    final parts = user.name.split(' ');
    _firstNameCtrl = TextEditingController(text: parts.first);
    _lastNameCtrl = TextEditingController(
      text: parts.length > 1 ? parts.sublist(1).join(' ') : '',
    );
    _usernameCtrl = TextEditingController();
    _city = user.city;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _usernameCtrl.dispose();
    super.dispose();
  }

  void _onUsernameChanged(String value) {
    _debounce?.cancel();
    final trimmed = value.trim().toLowerCase();

    if (trimmed.length < 3) {
      setState(() => _usernameStatus = _UsernameStatus.formatError);
      return;
    }

    final valid = RegExp(r'^[a-z0-9_]{3,20}$').hasMatch(trimmed);
    if (!valid) {
      setState(() => _usernameStatus = _UsernameStatus.formatError);
      return;
    }

    setState(() => _usernameStatus = _UsernameStatus.checking);
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        // Demo: simulate availability check
        await Future.delayed(const Duration(milliseconds: 300));
        final taken = trimmed == 'admin' || trimmed == 'test';
        if (!mounted) return;
        setState(() => _usernameStatus =
            taken ? _UsernameStatus.taken : _UsernameStatus.available);
      } catch (_) {
        if (!mounted) return;
        setState(() => _usernameStatus = _UsernameStatus.available);
      }
    });
  }

  Future<void> _updateLocation() async {
    setState(() => _locationLoading = true);
    final result = await LocationService.getCurrentCity();
    if (!mounted) return;
    setState(() => _locationLoading = false);

    if (result.isSuccess) {
      setState(() => _city = result.city!);
      HapticService.light();
    } else {
      final l = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.errorMessage ?? l.locationError),
          backgroundColor: AppColors.ringDanger,
        ),
      );
    }
  }

  Future<void> _pickPhoto() async {
    HapticService.light();
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );
    if (image == null) return;
    if (!mounted) return;
    final l = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l.photoSelectedDemo),
        backgroundColor: AppColors.neonGreen,
      ),
    );
  }

  Future<void> _save() async {
    HapticService.medium();
    setState(() => _saving = true);

    try {
      await Future.delayed(const Duration(milliseconds: 400));
      final fullName =
          '${_firstNameCtrl.text.trim()} ${_lastNameCtrl.text.trim()}'.trim();
      ref.read(userProvider.notifier).update(
            ref.read(userProvider).copyWith(
                  name: fullName.isEmpty ? 'Kullanıcı' : fullName,
                  city: _city,
                ),
          );
      if (!mounted) return;
      final l = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.profileUpdated),
          backgroundColor: AppColors.neonGreen,
        ),
      );
      context.pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      final l = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.errorOccurred),
          backgroundColor: AppColors.ringDanger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: 12),
                    Text(l.editProfile, style: AppType.h1),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      // Avatar
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: user.avatarColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  user.name[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: _pickPhoto,
                              child: Text(
                                l.changePhoto,
                                style: AppType.body.copyWith(
                                  color: AppColors.neonGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Ad
                      Text(l.firstName, style: AppType.caption),
                      const SizedBox(height: 8),
                      _buildTextField(_firstNameCtrl, l.firstNameHint),
                      const SizedBox(height: 20),

                      // Soyad
                      Text(l.lastName, style: AppType.caption),
                      const SizedBox(height: 8),
                      _buildTextField(_lastNameCtrl, l.lastNameHint),
                      const SizedBox(height: 20),

                      // Username
                      Text(l.usernameLabel, style: AppType.caption),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _usernameCtrl,
                        onChanged: _onUsernameChanged,
                        style: const TextStyle(color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          prefixText: '@',
                          prefixStyle: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                          hintText: 'kullanici_adi',
                          hintStyle:
                              const TextStyle(color: AppColors.textTertiary),
                          filled: true,
                          fillColor: AppColors.cardBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.cardBorder),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.cardBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.neonGreen),
                          ),
                          suffixIcon: _buildUsernameSuffix(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildUsernameHint(l),
                      const SizedBox(height: 20),

                      // City
                      Text(l.city, style: AppType.caption),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: AppColors.cardBorder),
                        ),
                        child: Row(
                          children: [
                            const Text('📍',
                                style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _city.isEmpty ? l.locationUnknown : _city,
                                style: AppType.body,
                              ),
                            ),
                            GestureDetector(
                              onTap:
                                  _locationLoading ? null : _updateLocation,
                              child: _locationLoading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.neonGreen,
                                      ),
                                    )
                                  : Text(
                                      l.updateLocation,
                                      style: AppType.caption.copyWith(
                                        color: AppColors.neonGreen,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Save
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _saving ? null : _save,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.neonGreen,
                            foregroundColor: Colors.black,
                            disabledBackgroundColor: AppColors.cardBg,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: _saving
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black,
                                  ),
                                )
                              : Text(l.save),
                        ),
                      ),
                      const SizedBox(height: 100),
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

  Widget _buildTextField(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textTertiary),
        filled: true,
        fillColor: AppColors.cardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.neonGreen),
        ),
      ),
    );
  }

  Widget? _buildUsernameSuffix() {
    return switch (_usernameStatus) {
      _UsernameStatus.idle => null,
      _UsernameStatus.checking => const Padding(
          padding: EdgeInsets.all(14),
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      _UsernameStatus.available => const Padding(
          padding: EdgeInsets.all(14),
          child: Icon(Icons.check_circle, color: AppColors.ringGood, size: 20),
        ),
      _UsernameStatus.taken => const Padding(
          padding: EdgeInsets.all(14),
          child: Icon(Icons.cancel, color: AppColors.ringDanger, size: 20),
        ),
      _UsernameStatus.formatError => const Padding(
          padding: EdgeInsets.all(14),
          child:
              Icon(Icons.warning_rounded, color: AppColors.ringWarning, size: 20),
        ),
    };
  }

  Widget _buildUsernameHint(AppLocalizations l) {
    return switch (_usernameStatus) {
      _UsernameStatus.available => Text(
          l.usernameAvailable,
          style: AppType.label.copyWith(color: AppColors.ringGood),
        ),
      _UsernameStatus.taken => Text(
          l.usernameTaken,
          style: AppType.label.copyWith(color: AppColors.ringDanger),
        ),
      _UsernameStatus.formatError => Text(
          l.usernameFormatError,
          style:
              AppType.label.copyWith(color: AppColors.ringWarning),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

enum _UsernameStatus { idle, checking, available, taken, formatError }
