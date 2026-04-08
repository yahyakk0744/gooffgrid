import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_theme_data.dart';
import 'subscription_provider.dart';

final activeThemeProvider = Provider<GoOffGridTheme>((ref) {
  final themeId =
      ref.watch(subscriptionProvider.select((s) => s.selectedTheme));
  return GoOffGridTheme.fromId(themeId);
});
