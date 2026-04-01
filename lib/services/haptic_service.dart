import 'package:flutter/services.dart';

/// Merkezi haptic feedback servisi.
/// Tüm UI bileşenleri bu sınıf üzerinden titreşim tetikler.
class HapticService {
  HapticService._();

  /// Buton tıklamaları, tab geçişleri, küçük etkileşimler.
  static void light() => HapticFeedback.lightImpact();

  /// O2 kazanma, rozet açma, düello kazanma gibi başarılar.
  static void heavy() => HapticFeedback.heavyImpact();

  /// Orta düzey geri bildirim — toggle, swipe confirm.
  static void medium() => HapticFeedback.mediumImpact();

  /// Seçim yapıldı — picker, segment control.
  static void selection() => HapticFeedback.selectionClick();

  /// Hedef aşımı, düello kaybı, hata durumları — uyarı titreşimi.
  static void warning() => HapticFeedback.vibrate();

  /// Ödeme/satın alma onayı — çift darbe hissiyatı.
  static Future<void> success() async {
    await HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }
}
