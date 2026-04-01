import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/platform_screen_time_service.dart';

/// Uygulama ikonlarını bellekte cache'ler.
/// Android: PackageManager'dan çekilen PNG byte[].
/// iOS: Platform View kullandığı için bu cache kullanılmaz.
final appIconCacheProvider =
    StateNotifierProvider<AppIconCacheNotifier, Map<String, Uint8List>>(
  (ref) => AppIconCacheNotifier(),
);

class AppIconCacheNotifier extends StateNotifier<Map<String, Uint8List>> {
  AppIconCacheNotifier() : super({});

  final _service = PlatformScreenTimeService.instance;

  /// Tek bir uygulamanın ikonunu çek ve cache'le.
  Future<Uint8List?> getIcon(String packageName) async {
    // Zaten cache'te var mı?
    if (state.containsKey(packageName)) {
      return state[packageName];
    }

    final bytes = await _service.getAppIcon(packageName);
    if (bytes != null && bytes.isNotEmpty) {
      state = {...state, packageName: bytes};
    }
    return bytes;
  }

  /// Birden fazla uygulamanın ikonunu toplu çek.
  Future<void> prefetchIcons(List<String> packageNames) async {
    for (final pkg in packageNames) {
      if (!state.containsKey(pkg)) {
        final bytes = await _service.getAppIcon(pkg);
        if (bytes != null && bytes.isNotEmpty) {
          state = {...state, pkg: bytes};
        }
      }
    }
  }

  void clear() {
    state = {};
  }
}
