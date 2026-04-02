import 'package:share_plus/share_plus.dart';
import 'package:gooffgrid/models/report_card.dart';
import 'package:gooffgrid/services/screen_time_service.dart';

class ShareService {
  ShareService._();
  static final instance = ShareService._();

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
