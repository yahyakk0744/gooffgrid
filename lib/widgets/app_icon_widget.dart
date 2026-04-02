import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/theme.dart';
import '../models/app_usage_entry.dart';

/// Platformu ayırt eden akıllı uygulama ikonu widget'ı.
///
/// **Android:** Native PackageManager'dan çekilen byte[] ikonunu
/// Image.memory() ile render eder. ClipRRect + Glow + Glassmorphism.
///
/// **iOS:** Apple sandboxing'i nedeniyle ham ikon çekilemez.
/// UiKitView ile DeviceActivityReport'un native view'ını gömer.
///
/// **Web/diğer:** Fallback olarak renk dot gösterir.
class AppIconWidget extends StatelessWidget {
  const AppIconWidget({
    super.key,
    this.iconBytes,
    required this.packageName,
    required this.color,
    this.size = 40,
    this.borderRadius = 12,
    this.glowIntensity = 0.35,
    this.showGlass = true,
  });

  /// Android'den gelen PNG byte[]. Null ise fallback gösterilir.
  final Uint8List? iconBytes;

  /// Uygulama paket adı (fallback ve renk eşlemesi için).
  final String packageName;

  /// İkon etrafındaki glow rengi (tema veya uygulama rengi).
  final Color color;

  /// Widget boyutu (kare).
  final double size;

  /// İkon köşe yuvarlama.
  final double borderRadius;

  /// Glow efekti şiddeti (0.0 - 1.0).
  final double glowIntensity;

  /// Glassmorphism arka plan gösterilsin mi?
  final bool showGlass;

  @override
  Widget build(BuildContext context) {
    final hasIcon = iconBytes != null && iconBytes!.isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          // Neon glow
          BoxShadow(
            color: color.withValues(alpha: glowIntensity),
            blurRadius: size * 0.4,
            spreadRadius: -2,
          ),
          // Subtle depth shadow
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: showGlass
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.04),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: _buildIcon(hasIcon),
                ),
              )
            : _buildIcon(hasIcon),
      ),
    );
  }

  Widget _buildIcon(bool hasIcon) {
    if (hasIcon) {
      return Image.memory(
        iconBytes!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallbackDot(),
      );
    }
    return _fallbackDot();
  }

  Widget _fallbackDot() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Text(
          packageName.split('.').last.substring(0, 1).toUpperCase(),
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ),
    );
  }
}

/// iOS'te DeviceActivityReport'u Flutter widget ağacına gömen Platform View.
/// Apple'ın sandboxing kuralları gereği bu view, orijinal app ikonlarını
/// native olarak render eder. Sadece iOS 16+ cihazlarda çalışır.
class IOSScreenTimeReportView extends StatelessWidget {
  const IOSScreenTimeReportView({
    super.key,
    this.daysAgo = 0,
    this.height = 400,
  });

  final int daysAgo;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || !Platform.isIOS) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: height,
      child: UiKitView(
        viewType: 'com.gooffgrid/screen_time_report',
        creationParams: {'daysAgo': daysAgo},
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}

/// Platform-aware uygulama kullanım listesi.
/// Android: Native ikonlarla glassmorphic kartlar.
/// iOS: DeviceActivityReport Platform View.
class PlatformAppUsageList extends StatelessWidget {
  const PlatformAppUsageList({
    super.key,
    required this.apps,
    this.maxMinutes = 0,
    this.daysAgo = 0,
  });

  /// Uygulama kullanım verileri (Android'de iconBytes içerir).
  final List<AppUsageEntry> apps;

  /// Bar genişlik hesabı için max dakika.
  final int maxMinutes;

  /// iOS Platform View için gün offseti.
  final int daysAgo;

  @override
  Widget build(BuildContext context) {
    // iOS: Apple'ın native DeviceActivityReport view'ını göster
    if (!kIsWeb && Platform.isIOS) {
      return IOSScreenTimeReportView(daysAgo: daysAgo);
    }

    // Android & diğer: Native ikonlarla glassmorphic liste
    final effectiveMax = maxMinutes > 0
        ? maxMinutes
        : (apps.isNotEmpty ? apps.first.minutes : 1);

    return Column(
      children: apps.map((app) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: AppUsageBarWithIcon(
          app: app,
          maxMinutes: effectiveMax,
        ),
      )).toList(),
    );
  }
}

/// Glassmorphism kartlı, native ikonlu kullanım barı.
class AppUsageBarWithIcon extends StatelessWidget {
  const AppUsageBarWithIcon({
    super.key,
    required this.app,
    required this.maxMinutes,
  });

  final AppUsageEntry app;
  final int maxMinutes;

  @override
  Widget build(BuildContext context) {
    final ratio = maxMinutes > 0 ? (app.minutes / maxMinutes).clamp(0.0, 1.0) : 0.0;

    return SizedBox(
      height: 44,
      child: Row(
        children: [
          // Native app icon with glow + glass
          AppIconWidget(
            iconBytes: app.iconBytes,
            packageName: app.packageName,
            color: app.iconColor,
            size: 36,
            borderRadius: 10,
            glowIntensity: 0.3,
          ),
          const SizedBox(width: 10),

          // App name
          SizedBox(
            width: 80,
            child: Text(
              app.name,
              style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),

          // Progress bar with gradient
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.cardBorder,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: ratio,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [app.iconColor.withValues(alpha: 0.7), app.iconColor],
                    ),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: app.iconColor.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Duration text
          SizedBox(
            width: 44,
            child: Text(
              app.formattedDuration,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

