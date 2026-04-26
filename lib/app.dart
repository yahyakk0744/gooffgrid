import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'config/theme.dart';
import 'config/routes.dart';
import 'providers/theme_provider.dart';
import 'services/app_block_bridge.dart';

/// Router provider — auth state değişince redirect tetiklenir.
final routerProvider = Provider<GoRouter>((ref) {
  final router = buildAppRouter(ref);
  // Native AppBlock → Flutter köprüsünü başlat (pending intent dahil).
  AppBlockBridge.instance.init(router);
  return router;
});

class GoOffGridApp extends ConsumerWidget {
  const GoOffGridApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final activeTheme = ref.watch(activeThemeProvider);

    return MaterialApp.router(
      title: 'gooffgrid',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(activeTheme),
      routerConfig: router,
      // Localization
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => Container(
        color: AppColors.bg,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: child,
          ),
        ),
      ),
    );
  }
}
