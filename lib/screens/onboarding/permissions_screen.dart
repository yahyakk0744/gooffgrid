import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../providers/screen_time_provider.dart';
import '../../services/platform_screen_time_service.dart';

class PermissionsScreen extends ConsumerStatefulWidget {
  const PermissionsScreen({super.key});

  @override
  ConsumerState<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends ConsumerState<PermissionsScreen>
    with WidgetsBindingObserver {
  bool _screenTimeGranted = false;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Kullanici ayarlardan donunce izni tekrar kontrol et.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    final granted = await PlatformScreenTimeService.instance.hasPermission();
    if (mounted) {
      setState(() => _screenTimeGranted = granted);
      ref.read(screenTimePermissionProvider.notifier).refresh();
    }
  }

  Future<void> _requestScreenTime() async {
    setState(() => _checking = true);
    await PlatformScreenTimeService.instance.requestPermission();
    // Kullanici ayarlara gidecek, donunce didChangeAppLifecycleState tetiklenecek
    setState(() => _checking = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_android_rounded, size: 48, color: AppColors.textPrimary),
                  SizedBox(width: 16),
                  Icon(Icons.access_time_rounded, size: 48, color: AppColors.textPrimary),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Ekran süreni takip etmemiz gerekiyor',
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Hangi uygulamalarda ne kadar vakit geçirdiğini görmek için '
                'ekran süresi erişimi gerekiyor.',
                style: AppTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Durum gostergesi
              if (_screenTimeGranted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.neonGreen.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.neonGreen.withAlpha(80)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_rounded, color: AppColors.neonGreen, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Ekran süresi izni verildi!',
                        style: TextStyle(
                          color: AppColors.neonGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

              const Spacer(),

              // Ana buton
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _screenTimeGranted
                      ? () => context.go('/onboarding/goal')
                      : (_checking ? null : _requestScreenTime),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  child: Text(
                    _screenTimeGranted ? 'Devam Et' : 'Izin Ver',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => context.go('/onboarding/goal'),
                child: Text(
                  'Atla',
                  style: AppTextStyles.bodySecondary.copyWith(color: AppColors.textTertiary),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
