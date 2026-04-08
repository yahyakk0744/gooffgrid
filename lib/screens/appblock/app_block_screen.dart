import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../providers/app_block_provider.dart';
import '../../providers/installed_apps_provider.dart';
import '../../widgets/app_icon_widget.dart';
import '../../l10n/app_localizations.dart';
import '../../services/platform_screen_time_service.dart';

class AppBlockScreen extends ConsumerWidget {
  const AppBlockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final state = ref.watch(appBlockProvider);
    final notifier = ref.read(appBlockProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _Header(l: l),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                children: [
                  const SizedBox(height: 16),
                  _MainToggleCard(state: state, notifier: notifier, l: l),
                  const SizedBox(height: 12),
                  _StrictModeCard(state: state, notifier: notifier, l: l),
                  const SizedBox(height: 20),
                  _ScheduleCard(l: l),
                  const SizedBox(height: 20),
                  _SectionHeader(title: l.appBlockBlockedApps),
                  const SizedBox(height: 8),
                  if (state.blockedApps.isEmpty)
                    _EmptyAppsHint(l: l)
                  else
                    ...state.blockedApps.map(
                      (id) => _BlockedAppTile(
                        appId: id,
                        onRemove: () => notifier.removeApp(id),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _AddAppFab(l: l, state: state, notifier: notifier),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({required this.l});
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 16, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 12),
          Text(l.appBlockTitle, style: AppType.h1),
          const Spacer(),
          GestureDetector(
            onTap: () => context.push('/app-block/schedule'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.neonGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppColors.neonGreen.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.schedule_rounded,
                      size: 14, color: AppColors.neonGreen),
                  const SizedBox(width: 6),
                  Text(l.appBlockSchedule,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.neonGreen)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Main Toggle Card ───────────────────────────────────────────────────────────

class _MainToggleCard extends StatelessWidget {
  const _MainToggleCard(
      {required this.state, required this.notifier, required this.l});
  final AppBlockState state;
  final AppBlockNotifier notifier;
  final AppLocalizations l;

  Future<void> _handleToggle(BuildContext context) async {
    if (state.isStrictMode) return;

    // Engellemeyi açarken accessibility izni kontrol et
    if (!state.isBlockingEnabled) {
      final service = PlatformScreenTimeService.instance;
      final hasPermission = await service.hasAccessibilityPermission();
      if (!hasPermission) {
        if (!context.mounted) return;
        final shouldOpen = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: AppColors.cardBg,
            title: Text('Erişilebilirlik İzni', style: AppType.h2),
            content: Text(
              'Uygulamaları engelleyebilmek için Erişilebilirlik Servisi iznine ihtiyacımız var. Ayarlarda GoOffGrid servisini açmanız gerekiyor.',
              style: AppType.body.copyWith(color: AppColors.textSecondary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text('İptal', style: AppType.body),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text('Ayarlara Git',
                    style: AppType.body.copyWith(color: AppColors.neonGreen)),
              ),
            ],
          ),
        );
        if (shouldOpen == true) {
          await service.requestAccessibilityPermission();
        }
        return;
      }
    }
    notifier.toggleBlocking();
  }

  @override
  Widget build(BuildContext context) {
    final isOn = state.isBlockingEnabled;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isOn
                  ? [
                      AppColors.neonGreen.withValues(alpha: 0.12),
                      AppColors.neonGreen.withValues(alpha: 0.04),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.08),
                      Colors.white.withValues(alpha: 0.03),
                    ],
            ),
            border: Border.all(
              color: isOn
                  ? AppColors.neonGreen.withValues(alpha: 0.4)
                  : AppColors.cardBorder,
              width: 1,
            ),
            boxShadow: isOn
                ? [
                    BoxShadow(
                      color: AppColors.neonGreen.withValues(alpha: 0.12),
                      blurRadius: 20,
                      spreadRadius: -4,
                    )
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isOn
                      ? AppColors.neonGreen.withValues(alpha: 0.15)
                      : AppColors.cardBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isOn ? Icons.shield_rounded : Icons.shield_outlined,
                  color: isOn ? AppColors.neonGreen : AppColors.textTertiary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.appBlockEnableBlocking,
                        style: AppType.h3),
                    const SizedBox(height: 2),
                    Text(
                      isOn ? l.appBlockActive : l.appBlockInactive,
                      style: AppType.caption.copyWith(
                        color: isOn
                            ? AppColors.neonGreen
                            : AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isOn,
                onChanged: state.isStrictMode ? null : (_) => _handleToggle(context),
                activeColor: AppColors.neonGreen,
                activeTrackColor: AppColors.neonGreen.withValues(alpha: 0.3),
                inactiveThumbColor: AppColors.textTertiary,
                inactiveTrackColor: AppColors.cardBg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Strict Mode Card ───────────────────────────────────────────────────────────

class _StrictModeCard extends StatefulWidget {
  const _StrictModeCard(
      {required this.state, required this.notifier, required this.l});
  final AppBlockState state;
  final AppBlockNotifier notifier;
  final AppLocalizations l;

  @override
  State<_StrictModeCard> createState() => _StrictModeCardState();
}

class _StrictModeCardState extends State<_StrictModeCard> {
  @override
  Widget build(BuildContext context) {
    final isStrict = widget.state.isStrictMode;
    final until = widget.state.blockUntil;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.07),
                Colors.white.withValues(alpha: 0.02),
              ],
            ),
            border: Border.all(
              color: isStrict
                  ? AppColors.ringDanger.withValues(alpha: 0.4)
                  : AppColors.cardBorder,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.ringDanger.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isStrict ? Icons.lock_rounded : Icons.lock_open_rounded,
                      color: isStrict
                          ? AppColors.ringDanger
                          : AppColors.textTertiary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.l.appBlockStrictMode,
                            style: AppType.h3),
                        const SizedBox(height: 2),
                        Text(widget.l.appBlockStrictDesc,
                            style: AppType.caption),
                      ],
                    ),
                  ),
                  Switch(
                    value: isStrict,
                    onChanged: (_) {
                      if (isStrict) {
                        widget.notifier.disableStrictMode();
                      } else {
                        _showDurationPicker(context);
                      }
                    },
                    activeColor: AppColors.ringDanger,
                    activeTrackColor:
                        AppColors.ringDanger.withValues(alpha: 0.3),
                    inactiveThumbColor: AppColors.textTertiary,
                    inactiveTrackColor: AppColors.cardBg,
                  ),
                ],
              ),
              if (isStrict && until != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.ringDanger.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:
                            AppColors.ringDanger.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timer_rounded,
                          size: 14, color: AppColors.ringDanger),
                      const SizedBox(width: 8),
                      Text(
                        _formatCountdown(until),
                        style: AppType.caption.copyWith(
                            color: AppColors.ringDanger),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatCountdown(DateTime until) {
    final diff = until.difference(DateTime.now());
    if (diff.isNegative) return widget.l.appBlockStrictExpired;
    final h = diff.inHours;
    final m = diff.inMinutes.remainder(60);
    if (h > 0) return '${h}s ${m}dk kaldı';
    return '${m}dk kaldı';
  }

  void _showDurationPicker(BuildContext context) {
    final options = [
      (widget.l.appBlockDuration30m, const Duration(minutes: 30)),
      (widget.l.appBlockDuration1h, const Duration(hours: 1)),
      (widget.l.appBlockDuration2h, const Duration(hours: 2)),
      (widget.l.appBlockDuration4h, const Duration(hours: 4)),
      (widget.l.appBlockDurationAllDay, const Duration(hours: 24)),
    ];
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.l.appBlockStrictDurationTitle,
                style: AppType.h2),
            const SizedBox(height: 16),
            ...options.map(
              (opt) => ListTile(
                title: Text(opt.$1, style: AppType.body),
                trailing: const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textTertiary),
                onTap: () {
                  Navigator.pop(context);
                  widget.notifier.enableStrictMode(opt.$2);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Schedule Card ─────────────────────────────────────────────────────────────

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({required this.l});
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/app-block/schedule'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.07),
                  Colors.white.withValues(alpha: 0.02),
                ],
              ),
              border:
                  Border.all(color: AppColors.cardBorder),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.neonOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.calendar_today_rounded,
                      color: AppColors.neonOrange, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.appBlockScheduleTitle, style: AppType.h3),
                      Text(l.appBlockScheduleDesc,
                          style: AppType.caption),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Section Header ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: AppType.caption.copyWith(letterSpacing: 1),
    );
  }
}

// ── Empty Apps Hint ────────────────────────────────────────────────────────────

class _EmptyAppsHint extends StatelessWidget {
  const _EmptyAppsHint({required this.l});
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: AppColors.cardBorder,
            style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          Icon(Icons.apps_rounded,
              size: 40, color: AppColors.textTertiary),
          const SizedBox(height: 8),
          Text(l.appBlockNoApps, style: AppType.body.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

// ── Blocked App Tile ───────────────────────────────────────────────────────────

class _BlockedAppTile extends ConsumerWidget {
  const _BlockedAppTile({required this.appId, required this.onRemove});
  final String appId;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final installedApps = ref.watch(installedAppsProvider);
    final app = installedApps.whenOrNull(
      data: (list) => list.where((a) => a.packageName == appId).firstOrNull,
    );
    final name = app?.name ?? appId.split('.').last;
    final color = PlatformScreenTimeService.appColorFor(appId);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          AppIconWidget(
            iconBytes: app?.iconBytes,
            packageName: appId,
            color: color,
            size: 40,
            borderRadius: 10,
            glowIntensity: 0.2,
            showGlass: false,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(name, style: AppType.h3),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.ringDanger.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.close_rounded,
                  size: 16, color: AppColors.ringDanger),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Add App FAB ────────────────────────────────────────────────────────────────

class _AddAppFab extends ConsumerWidget {
  const _AddAppFab(
      {required this.l, required this.state, required this.notifier});
  final AppLocalizations l;
  final AppBlockState state;
  final AppBlockNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showAppPicker(context, ref),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        height: 52,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.neonGreen,
              AppColors.neonGreen.withValues(alpha: 0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonGreen.withValues(alpha: 0.35),
              blurRadius: 20,
              spreadRadius: -4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_rounded, color: Colors.black, size: 20),
            const SizedBox(width: 8),
            Text(
              l.appBlockAddApp,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAppPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _AppPickerSheet(
        blockedApps: state.blockedApps,
        notifier: notifier,
        l: l,
      ),
    );
  }
}

/// Gerçek yüklü uygulama listesiyle arama destekli picker.
class _AppPickerSheet extends ConsumerStatefulWidget {
  const _AppPickerSheet({
    required this.blockedApps,
    required this.notifier,
    required this.l,
  });
  final List<String> blockedApps;
  final AppBlockNotifier notifier;
  final AppLocalizations l;

  @override
  ConsumerState<_AppPickerSheet> createState() => _AppPickerSheetState();
}

class _AppPickerSheetState extends ConsumerState<_AppPickerSheet> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final apps = ref.watch(installedAppsSearchProvider(_search));

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (_, scrollCtrl) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.cardBorder,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(widget.l.appBlockPickerTitle, style: AppType.h2),
                const SizedBox(height: 12),
                // Arama alanı
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded,
                          size: 18, color: AppColors.textTertiary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          onChanged: (v) => setState(() => _search = v),
                          style: AppType.body,
                          decoration: InputDecoration(
                            hintText: 'Uygulama ara...',
                            hintStyle: AppType.body.copyWith(
                                color: AppColors.textTertiary),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: apps.isEmpty
                ? Center(
                    child: ref.watch(installedAppsProvider).when(
                      loading: () => const CircularProgressIndicator(
                          color: AppColors.neonGreen),
                      error: (_, __) => Text('Uygulamalar yüklenemedi',
                          style: AppType.caption),
                      data: (_) => Text('Uygulama bulunamadı',
                          style: AppType.caption),
                    ),
                  )
                : ListView.builder(
                    controller: scrollCtrl,
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: apps.length,
                    itemBuilder: (_, i) {
                      final app = apps[i];
                      final isAdded = widget.blockedApps.contains(
                          app.packageName);
                      final color = PlatformScreenTimeService.appColorFor(
                          app.packageName);
                      return ListTile(
                        leading: AppIconWidget(
                          iconBytes: app.iconBytes,
                          packageName: app.packageName,
                          color: color,
                          size: 40,
                          borderRadius: 10,
                          glowIntensity: 0.2,
                          showGlass: false,
                        ),
                        title: Text(app.name, style: AppType.body),
                        subtitle: Text(
                          app.category,
                          style: AppType.caption.copyWith(fontSize: 10),
                        ),
                        trailing: isAdded
                            ? const Icon(Icons.check_circle_rounded,
                                color: AppColors.neonGreen)
                            : Icon(Icons.add_circle_outline_rounded,
                                color: AppColors.textTertiary),
                        onTap: isAdded
                            ? null
                            : () {
                                widget.notifier.addApp(app.packageName);
                                Navigator.pop(context);
                              },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
