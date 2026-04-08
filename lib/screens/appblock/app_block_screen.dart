import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../providers/app_block_provider.dart';
import '../../l10n/app_localizations.dart';

// Mock app data for the picker bottom sheet
class _MockApp {
  const _MockApp({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
  final String id;
  final String name;
  final Color color;
  final IconData icon;
}

const _mockApps = [
  _MockApp(id: 'com.instagram.android', name: 'Instagram', color: AppColors.instagram, icon: Icons.camera_alt_rounded),
  _MockApp(id: 'com.zhiliaoapp.musically', name: 'TikTok', color: AppColors.tiktok, icon: Icons.music_note_rounded),
  _MockApp(id: 'com.google.android.youtube', name: 'YouTube', color: AppColors.youtube, icon: Icons.play_circle_filled_rounded),
  _MockApp(id: 'com.twitter.android', name: 'X (Twitter)', color: AppColors.twitter, icon: Icons.tag_rounded),
  _MockApp(id: 'com.snapchat.android', name: 'Snapchat', color: AppColors.snapchat, icon: Icons.face_rounded),
  _MockApp(id: 'com.facebook.katana', name: 'Facebook', color: Color(0xFF1877F2), icon: Icons.facebook),
  _MockApp(id: 'com.reddit.frontpage', name: 'Reddit', color: AppColors.reddit, icon: Icons.reddit),
  _MockApp(id: 'com.whatsapp', name: 'WhatsApp', color: AppColors.whatsapp, icon: Icons.chat_bubble_rounded),
  _MockApp(id: 'org.telegram.messenger', name: 'Telegram', color: AppColors.telegram, icon: Icons.send_rounded),
  _MockApp(id: 'com.netflix.mediaclient', name: 'Netflix', color: Color(0xFFE50914), icon: Icons.movie_rounded),
  _MockApp(id: 'com.spotify.music', name: 'Spotify', color: Color(0xFF1DB954), icon: Icons.headphones_rounded),
  _MockApp(id: 'com.discord', name: 'Discord', color: Color(0xFF5865F2), icon: Icons.forum_rounded),
];

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
          Text(l.appBlockTitle, style: AppTextStyles.h1),
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
                        style: AppTextStyles.h3),
                    const SizedBox(height: 2),
                    Text(
                      isOn ? l.appBlockActive : l.appBlockInactive,
                      style: AppTextStyles.label.copyWith(
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
                onChanged: state.isStrictMode ? null : (_) => notifier.toggleBlocking(),
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
                            style: AppTextStyles.h3),
                        const SizedBox(height: 2),
                        Text(widget.l.appBlockStrictDesc,
                            style: AppTextStyles.label),
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
                        style: AppTextStyles.label.copyWith(
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
                style: AppTextStyles.h2),
            const SizedBox(height: 16),
            ...options.map(
              (opt) => ListTile(
                title: Text(opt.$1, style: AppTextStyles.body),
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
                      Text(l.appBlockScheduleTitle, style: AppTextStyles.h3),
                      Text(l.appBlockScheduleDesc,
                          style: AppTextStyles.label),
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
      style: AppTextStyles.label.copyWith(letterSpacing: 1),
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
          Text(l.appBlockNoApps, style: AppTextStyles.bodySecondary),
        ],
      ),
    );
  }
}

// ── Blocked App Tile ───────────────────────────────────────────────────────────

class _BlockedAppTile extends StatelessWidget {
  const _BlockedAppTile({required this.appId, required this.onRemove});
  final String appId;
  final VoidCallback onRemove;

  _MockApp? get _app => _mockApps.where((a) => a.id == appId).firstOrNull;

  @override
  Widget build(BuildContext context) {
    final app = _app;
    final name = app?.name ?? appId;
    final color = app?.color ?? AppColors.textTertiary;
    final icon = app?.icon ?? Icons.android_rounded;
    final letter = name.isNotEmpty ? name[0].toUpperCase() : '?';

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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: app != null
                ? Icon(icon, color: color, size: 20)
                : Center(
                    child: Text(
                      letter,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(name, style: AppTextStyles.h3),
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

class _AddAppFab extends StatelessWidget {
  const _AddAppFab(
      {required this.l, required this.state, required this.notifier});
  final AppLocalizations l;
  final AppBlockState state;
  final AppBlockNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAppPicker(context),
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

  void _showAppPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.65,
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
                  Text(l.appBlockPickerTitle, style: AppTextStyles.h2),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                itemCount: _mockApps.length,
                itemBuilder: (_, i) {
                  final app = _mockApps[i];
                  final isAdded = state.blockedApps.contains(app.id);
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: app.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(app.icon, color: app.color, size: 20),
                    ),
                    title: Text(app.name, style: AppTextStyles.body),
                    trailing: isAdded
                        ? const Icon(Icons.check_circle_rounded,
                            color: AppColors.neonGreen)
                        : Icon(Icons.add_circle_outline_rounded,
                            color: AppColors.textTertiary),
                    onTap: isAdded
                        ? null
                        : () {
                            notifier.addApp(app.id);
                            Navigator.pop(context);
                          },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
