import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// RevenueCat abonelik yönetimi.
/// Ürünler: gooffgrid_pro (149 TL/ay), gooffgrid_pro_plus (299 TL/ay)
class RevenueCatService {
  RevenueCatService._();
  static final instance = RevenueCatService._();

  static const _androidApiKey = 'YOUR_REVENUECAT_ANDROID_KEY';
  static const _iosApiKey = 'YOUR_REVENUECAT_IOS_KEY';

  bool _initialized = false;

  /// Henüz gerçek API key'ler eklenmedi mi?
  static bool get _hasRealKeys =>
      _androidApiKey != 'YOUR_REVENUECAT_ANDROID_KEY' &&
      _iosApiKey != 'YOUR_REVENUECAT_IOS_KEY';

  /// Uygulama başlangıcında çağır.
  Future<void> init() async {
    if (_initialized) return;
    // Placeholder key varsa RevenueCat'i başlatma (crash olur)
    if (!_hasRealKeys) {
      debugPrint('RevenueCat: API key henüz eklenmedi, atlanıyor.');
      return;
    }
    try {
      final config = PurchasesConfiguration(
        defaultTargetPlatform == TargetPlatform.iOS ? _iosApiKey : _androidApiKey,
      );
      await Purchases.configure(config);
      _initialized = true;
    } catch (e) {
      debugPrint('RevenueCat init error: $e');
    }
  }

  /// Supabase auth ID ile RevenueCat'i eşle.
  Future<void> login(String userId) async {
    if (!_initialized) return;
    try {
      await Purchases.logIn(userId);
    } catch (e) {
      debugPrint('RevenueCat login error: $e');
    }
  }

  /// Çıkış.
  Future<void> logout() async {
    if (!_initialized) return;
    try {
      await Purchases.logOut();
    } catch (e) {
      debugPrint('RevenueCat logout error: $e');
    }
  }

  /// Premium mi?
  Future<bool> isPremium() async {
    if (!_initialized) return false;
    try {
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.active.containsKey('premium');
    } catch (e) {
      return false;
    }
  }

  /// Mevcut abonelik planı.
  Future<String?> currentPlan() async {
    if (!_initialized) return null;
    try {
      final info = await Purchases.getCustomerInfo();
      final active = info.entitlements.active;
      if (active.containsKey('pro_plus')) return 'pro_plus';
      if (active.containsKey('premium')) return 'pro';
      return 'free';
    } catch (e) {
      return null;
    }
  }

  /// Satın alınabilir paketleri getir.
  Future<List<Package>> getPackages() async {
    if (!_initialized) return [];
    try {
      final offerings = await Purchases.getOfferings();
      return offerings.current?.availablePackages ?? [];
    } catch (e) {
      debugPrint('getPackages error: $e');
      return [];
    }
  }

  /// Satın al.
  Future<bool> purchase(Package package) async {
    try {
      final result = await Purchases.purchasePackage(package);
      return result.entitlements.active.isNotEmpty;
    } on PurchasesErrorCode {
      return false;
    } catch (e) {
      debugPrint('purchase error: $e');
      return false;
    }
  }

  /// Restore purchases.
  Future<bool> restorePurchases() async {
    try {
      final info = await Purchases.restorePurchases();
      return info.entitlements.active.isNotEmpty;
    } catch (e) {
      debugPrint('restore error: $e');
      return false;
    }
  }
}
