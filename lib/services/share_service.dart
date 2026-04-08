import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gooffgrid/models/report_card.dart';
import 'package:gooffgrid/services/screen_time_service.dart';
import 'package:gooffgrid/widgets/share_card.dart';

class ShareService {
  ShareService._();
  static final instance = ShareService._();

  // ───────────────────────── Image-based sharing ─────────────────────────

  /// Opens a bottom sheet preview of the duel result card with a share
  /// button. Inspired by Strava / Nike Run Club / Spotify Wrapped.
  static Future<void> showDuelSharePreview(
    BuildContext context, {
    required bool won,
    required String playerName,
    required int playerMinutes,
    required String opponentName,
    required int opponentMinutes,
    required String duelTypeLabel,
    String? durationLabel,
    String? detailLine,
  }) async {
    final card = DuelShareCard(
      won: won,
      playerName: playerName,
      playerMinutes: playerMinutes,
      opponentName: opponentName,
      opponentMinutes: opponentMinutes,
      dateLabel: _formatDate(DateTime.now()),
      duelTypeLabel: duelTypeLabel,
      durationLabel: durationLabel,
      detailLine: detailLine,
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SharePreviewSheet(card: card, won: won),
    );
  }

  /// Captures a RepaintBoundary (by GlobalKey) as a PNG file in temp dir.
  static Future<File> captureFromKey(GlobalKey key) async {
    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();
    final dir = await getTemporaryDirectory();
    final file = File(
      '${dir.path}/gooffgrid_${DateTime.now().millisecondsSinceEpoch}.png',
    );
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<void> shareImageFile(File file, {String? text}) async {
    await Share.shareXFiles(
      [XFile(file.path)],
      text: text ??
          'gooffgrid ile dijital detoks düellosu! Sen de meydan oku. '
              'https://gooffgrid.com',
    );
  }

  static String _formatDate(DateTime d) {
    const months = [
      'OCA', 'ŞUB', 'MAR', 'NİS', 'MAY', 'HAZ',
      'TEM', 'AĞU', 'EYL', 'EKİ', 'KAS', 'ARA',
    ];
    return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
  }

  // ───────────────────────── Text-based sharing ──────────────────────────

  /// Share a simple text message (duel invite, streak brag, etc.)
  Future<void> shareText(String text) async {
    await Share.share(text);
  }

  /// Share weekly report card as formatted text.
  Future<void> shareReportCard(ReportCard card) async {
    final text = '''
GoOffGrid Haftalık Karne 📊

Not: ${card.grade}
Toplam: ${formatMinutes(card.totalMinutes)}
Günlük Ort: ${formatMinutes(card.avgDailyMinutes)}
Seri: ${card.streak} gün 🔥
Düello: ${card.duelsWon}W / ${card.duelsLost}L
Sıralama: ${card.rankChange > 0 ? "+${card.rankChange}" : card.rankChange == 0 ? "-" : "${card.rankChange}"} ⬆️

Ekranını bırak, arkadaşlarını yen!
gooffgrid.app
''';
    await shareText(text);
  }

  /// Share duel invite with share code.
  Future<void> shareDuelInvite(String shareCode) async {
    await shareText(
      'Sana GoOffGrid düellosu atıyorum! ⚔️\n'
      'Kod: $shareCode\n'
      'Kim daha az telefon kullanacak?\n'
      'gooffgrid.app/duel/$shareCode',
    );
  }

  /// Share streak brag.
  Future<void> shareStreak(int streak, String userName) async {
    await shareText(
      '$userName GoOffGrid\'da $streak gün seri yapıyor! 🔥\n'
      'Sen de meydan oku: gooffgrid.app',
    );
  }
}

class _SharePreviewSheet extends StatefulWidget {
  const _SharePreviewSheet({required this.card, required this.won});

  final DuelShareCard card;
  final bool won;

  @override
  State<_SharePreviewSheet> createState() => _SharePreviewSheetState();
}

class _SharePreviewSheetState extends State<_SharePreviewSheet> {
  final _captureKey = GlobalKey();
  bool _sharing = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final previewWidth = media.size.width * 0.78;
    final previewHeight = previewWidth * (1920 / 1080);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 24),
        decoration: const BoxDecoration(
          color: Color(0xFF0A0A0A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          border: Border(top: BorderSide(color: Color(0xFF222222))),
        ),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Paylaş',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: previewWidth,
                height: previewHeight,
                child: Transform.scale(
                  scale: previewWidth / 1080,
                  alignment: Alignment.topLeft,
                  child: OverflowBox(
                    minWidth: 1080,
                    maxWidth: 1080,
                    minHeight: 1920,
                    maxHeight: 1920,
                    alignment: Alignment.topLeft,
                    child: RepaintBoundary(
                      key: _captureKey,
                      child: widget.card,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _sharing ? null : _handleShare,
                icon: _sharing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.black,
                        ),
                      )
                    : const Icon(Icons.ios_share_rounded, size: 22),
                label: Text(
                  _sharing ? 'Hazırlanıyor...' : 'Paylaş',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.won
                      ? const Color(0xFF39FF14)
                      : const Color(0xFFFF4444),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Vazgeç',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleShare() async {
    setState(() => _sharing = true);
    try {
      final file = await ShareService.captureFromKey(_captureKey);
      await ShareService.shareImageFile(file);
    } catch (_) {
      // Silently ignore — user can retry.
    }
    if (mounted) {
      setState(() => _sharing = false);
      Navigator.of(context).pop();
    }
  }
}
