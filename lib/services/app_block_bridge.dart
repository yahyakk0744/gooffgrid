import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Native Android AccessibilityService → Flutter route push köprüsü.
///
/// Accessibility Service bir engelli uygulamayı algıladığında MainActivity'yi
/// açar ve intent'e `route` extra koyar. MainActivity bu route'u
/// `com.gooffgrid/app_block_bridge` kanalı üzerinden buraya gönderir.
///
/// Flutter motor hazır olmadan gelen intent'ler native tarafta bekletilir;
/// [init] çağrıldığında `consumePendingRoute` ile çekilir.
class AppBlockBridge {
  AppBlockBridge._();
  static final instance = AppBlockBridge._();

  static const _channel = MethodChannel('com.gooffgrid/app_block_bridge');

  bool _initialized = false;
  GoRouter? _router;

  /// App boot sonrası (router hazır olunca) çağrılır.
  Future<void> init(GoRouter router) async {
    if (_initialized) return;
    _initialized = true;
    _router = router;

    _channel.setMethodCallHandler(_onMethodCall);

    // Uygulama kapalıyken gelen engelleme intent'i varsa şimdi tüket.
    try {
      final pending = await _channel.invokeMethod<String>('consumePendingRoute');
      if (pending != null && pending.isNotEmpty) {
        _pushRoute(pending);
      }
    } on PlatformException catch (e) {
      debugPrint('AppBlockBridge pending check failed: $e');
    } on MissingPluginException {
      // iOS veya desteklenmeyen platformlar — sessizce geç.
    }
  }

  Future<dynamic> _onMethodCall(MethodCall call) async {
    if (call.method == 'onBlockedAppIntent') {
      final args = call.arguments;
      String? route;
      if (args is Map) {
        route = args['route'] as String?;
      } else if (args is String) {
        route = args;
      }
      if (route != null && route.isNotEmpty) {
        _pushRoute(route);
      }
    }
    return null;
  }

  void _pushRoute(String route) {
    final router = _router;
    if (router == null) return;
    try {
      router.push(route);
    } catch (e) {
      debugPrint('AppBlockBridge route push failed: $e');
    }
  }
}
