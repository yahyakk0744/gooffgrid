
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/platform_screen_time_service.dart';

/// Cihazda yüklü bir uygulama.
class InstalledApp {
  const InstalledApp({
    required this.packageName,
    required this.name,
    required this.category,
    this.iconBytes,
  });

  final String packageName;
  final String name;
  final String category;
  final Uint8List? iconBytes;

  factory InstalledApp.fromMap(Map<String, dynamic> map) {
    Uint8List? bytes;
    if (map['iconBytes'] != null) {
      bytes = Uint8List.fromList(List<int>.from(map['iconBytes'] as List));
    }
    return InstalledApp(
      packageName: map['packageName'] as String,
      name: map['name'] as String,
      category: (map['category'] as String?) ?? 'other',
      iconBytes: bytes,
    );
  }
}

/// Yüklü uygulama listesi provider'ı.
/// İlk erişimde platform channel'dan çeker ve cache'ler.
class InstalledAppsNotifier extends StateNotifier<AsyncValue<List<InstalledApp>>> {
  InstalledAppsNotifier() : super(const AsyncValue.loading()) {
    _load();
  }

  final _service = PlatformScreenTimeService.instance;

  Future<void> _load() async {
    try {
      final rawApps = await _service.getInstalledApps();
      final apps = rawApps.map(InstalledApp.fromMap).toList();
      state = AsyncValue.data(apps);
    } catch (e, st) {
      debugPrint('InstalledApps load error: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async => _load();
}

final installedAppsProvider =
    StateNotifierProvider<InstalledAppsNotifier, AsyncValue<List<InstalledApp>>>(
  (ref) => InstalledAppsNotifier(),
);

/// Arama filtreli yüklü uygulama listesi.
final installedAppsSearchProvider = Provider.family<List<InstalledApp>, String>((ref, query) {
  final apps = ref.watch(installedAppsProvider);
  return apps.when(
    data: (list) {
      if (query.isEmpty) return list;
      final q = query.toLowerCase();
      return list.where((a) => a.name.toLowerCase().contains(q)).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
});
