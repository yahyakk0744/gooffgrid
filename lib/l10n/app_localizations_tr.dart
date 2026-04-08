// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan => 'Fişi çek. Oyuna başla. Dijitalde kaybolma.';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get ranking => 'Sıralama';

  @override
  String get duel => 'Düello';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Ayarlar';

  @override
  String get stories => 'Hikayeler';

  @override
  String get today => 'Bugün';

  @override
  String get thisWeek => 'Bu Hafta';

  @override
  String get friends => 'Arkadaşlar';

  @override
  String get friendsOf => 'Arkadaşların';

  @override
  String get allFriends => 'Tümü';

  @override
  String get city => 'Şehir';

  @override
  String get country => 'Ülke';

  @override
  String get global => 'Global';

  @override
  String minutes(int count) {
    return '$count dk';
  }

  @override
  String hours(int count) {
    return '$count s';
  }

  @override
  String hoursMinutes(int h, int m) {
    return '${h}s ${m}dk';
  }

  @override
  String get screenTime => 'Ekran Süresi';

  @override
  String get phonePickups => 'Telefon Açma';

  @override
  String pickupsToday(int count) {
    return 'Bugün $count Kez Ele Alındı';
  }

  @override
  String get topTriggers => 'En Çok Tetikleyenler';

  @override
  String get longestOffScreen => 'En Uzun Mola';

  @override
  String get dailyGoal => 'Günlük Hedef';

  @override
  String goalHours(int count) {
    return 'Hedef: $count saat';
  }

  @override
  String get streak => 'Seri';

  @override
  String streakDays(int count) {
    return '$count gün';
  }

  @override
  String get level => 'Seviye';

  @override
  String get badges => 'Rozetler';

  @override
  String get duels => 'Düellolar';

  @override
  String get activeDuels => 'Aktif';

  @override
  String get pastDuels => 'Geçmiş';

  @override
  String get createDuel => 'Düello Oluştur';

  @override
  String get startDuel => 'Düello Başlat';

  @override
  String get invite => 'Davet Et';

  @override
  String get accept => 'Kabul Et';

  @override
  String get decline => 'Reddet';

  @override
  String get win => 'Kazandı';

  @override
  String get lose => 'Kaybetti';

  @override
  String get draw => 'Berabere';

  @override
  String get addFriend => 'Arkadaş Ekle';

  @override
  String get friendCode => 'Arkadaş Kodu';

  @override
  String get search => 'Ara';

  @override
  String get notifications => 'Bildirimler';

  @override
  String get dailyReminder => 'Günlük Hatırlatıcı';

  @override
  String get duelNotifications => 'Düello Bildirimleri';

  @override
  String get locationSharing => 'Konum Paylaşımı';

  @override
  String get subscription => 'Abonelik';

  @override
  String get free => 'Ücretsiz';

  @override
  String get pro => 'Pro';

  @override
  String get proPlus => 'Pro+';

  @override
  String get currentPlan => 'Mevcut Plan';

  @override
  String get recommended => 'Önerilen';

  @override
  String get start => 'Başla';

  @override
  String get upgradeToPro => 'Pro\'ya Yükselt';

  @override
  String get upgradeToProPlus => 'Pro+\'ya Yükselt';

  @override
  String get restorePurchases => 'Satın Alımları Geri Yükle';

  @override
  String monthlyPrice(String price) {
    return '$price/ay';
  }

  @override
  String get freeFeature1 => 'Günlük ekran süresi takibi';

  @override
  String get freeFeature2 => 'Arkadaş sıralamaları';

  @override
  String get freeFeature3 => '3 aktif düello';

  @override
  String get freeFeature4 => 'Temel rozetler';

  @override
  String get proFeature1 => 'Tüm sıralamalar (şehir, ülke, global)';

  @override
  String get proFeature2 => 'Detaylı istatistikler & odak takvimi';

  @override
  String get proFeature3 => 'Sınırsız düello';

  @override
  String get proFeature4 => 'Off-Grid Biletleri dahil';

  @override
  String get proFeature5 => 'Reklamsız deneyim';

  @override
  String get proPlusFeature1 => 'Pro içeriklerin tamamı';

  @override
  String get proPlusFeature2 => 'Aile planı (5 kişi)';

  @override
  String get proPlusFeature3 => 'Öncelikli destek';

  @override
  String get proPlusFeature4 => 'Özel rozetler & temalar';

  @override
  String get proPlusFeature5 => 'Beta özelliklere erken erişim';

  @override
  String get paywallTitle => 'Off-Grid Kulübü';

  @override
  String get paywallSubtitle => 'Ekranından kopmanın ödülünü al.';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get shareProfile => 'Profilimi Paylaş';

  @override
  String get shareReportCard => 'Havamı At';

  @override
  String get appUsage => 'Uygulama Kullanımı';

  @override
  String get whatDidYouUse => 'Bugün ne kullandın?';

  @override
  String get weeklyReport => 'Haftalık Rapor';

  @override
  String get weeklyTrend => '7 Günlük Trend';

  @override
  String get seasons => 'Sezonlar';

  @override
  String get seasonPass => 'Off-Grid Biletleri';

  @override
  String get groups => 'Gruplar';

  @override
  String get createGroup => 'Grup Oluştur';

  @override
  String get stats => 'İstatistikler';

  @override
  String get analytics => 'Analitik';

  @override
  String get detailedAnalytics => 'Detaylı Analitik';

  @override
  String get categories => 'Kategoriler';

  @override
  String get weeklyUsage => 'Haftalık Kullanım';

  @override
  String get appDetails => 'Uygulama Detayları';

  @override
  String get focusCalendar => 'Odak Takvimi';

  @override
  String get whatIf => 'Ya Olsaydı?';

  @override
  String get focusMode => 'Odak Modu';

  @override
  String get startFocusMode => 'Odak Modunu Başlat';

  @override
  String get focusing => 'Odaklanıyorsun...';

  @override
  String focusComplete(int minutes) {
    return 'Harika! $minutes dk odaklandın';
  }

  @override
  String get focusTimeout => 'Oturum Zaman Aşımı';

  @override
  String get focusTimeoutDesc =>
      '120 dakika limitine ulaştın.\nHâlâ orada mısın?';

  @override
  String get end => 'Bitir';

  @override
  String get reportCard => 'Karne';

  @override
  String get antiSocialStory => 'Anti-Sosyal An';

  @override
  String get storyQuestion => 'Telefonundan uzakta ne yapıyorsun?';

  @override
  String get postStory => 'Paylaş';

  @override
  String get storyExpired => 'Süresi doldu';

  @override
  String get noStories => 'Henüz hikaye yok';

  @override
  String get noStoriesHint =>
      'Arkadaşların off-grid anlarını paylaşmaya başlasın!';

  @override
  String get storyBlocked => 'Hikaye Paylaşamazsın';

  @override
  String get storyBlockedHint =>
      'Günlük ekran süresi hedefini aştın. Hedefine sadık kalarak hikaye paylaşma hakkını kazan!';

  @override
  String get duration => 'Süre';

  @override
  String get walk => 'Yürüyüş';

  @override
  String get run => 'Koşu';

  @override
  String get book => 'Kitap';

  @override
  String get meditation => 'Meditasyon';

  @override
  String get nature => 'Doğada';

  @override
  String get sports => 'Spor';

  @override
  String get music => 'Müzik';

  @override
  String get cooking => 'Yemek';

  @override
  String get friendsActivity => 'Arkadaş';

  @override
  String get family => 'Aile';

  @override
  String get o2Balance => 'O₂ Puanı';

  @override
  String o2Remaining(int count) {
    return 'Kalan: $count';
  }

  @override
  String o2Today(int earned, int max) {
    return 'Bugün: $earned/$max O₂';
  }

  @override
  String get o2Rules => 'O₂ Kuralları';

  @override
  String get o2RuleTime => 'Sadece 08:00-00:00 arası kazanılır';

  @override
  String get o2RuleDaily => 'Günde max 500 O₂';

  @override
  String get o2RuleFocus => 'Odak modu max 120 dk';

  @override
  String get o2RuleTransfer => 'Transfer ve bahis yasak';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂ (tahmini)';
  }

  @override
  String get offGridMarket => 'Ganimetler';

  @override
  String get offGridMarketHint =>
      'O₂ puanlarını gerçek dünya ganimetlerine dönüştür';

  @override
  String get redeem => 'Al';

  @override
  String get insufficient => 'Yetersiz';

  @override
  String get redeemSuccess => 'Tebrikler!';

  @override
  String get couponCode => 'Kupon kodun:';

  @override
  String get recentTransactions => 'Son İşlemler';

  @override
  String get noTransactions => 'Henüz işlem yok';

  @override
  String get categorySocial => 'Sosyal';

  @override
  String get categoryGame => 'Oyun';

  @override
  String get categoryVideo => 'Video';

  @override
  String get categoryAudio => 'Müzik';

  @override
  String get categoryProductivity => 'Üretkenlik';

  @override
  String get categoryNews => 'Haber';

  @override
  String get categoryGames => 'Oyunlar';

  @override
  String get categoryShopping => 'Alışveriş';

  @override
  String get categoryBrowser => 'Tarayıcı';

  @override
  String get categoryMaps => 'Harita';

  @override
  String get categoryImage => 'Fotoğraf';

  @override
  String get categoryOther => 'Diğer';

  @override
  String hello(String name) {
    return 'Merhaba, $name';
  }

  @override
  String get goalCompleted => 'Hedef tamamlandı!';

  @override
  String get dailyGoalShort => 'Günlük hedef';

  @override
  String get streakDaysLabel => 'gün seri';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => 'sıra';

  @override
  String get offlineLabel => 'çevrimdışı';

  @override
  String get todaysApps => 'Bugünün Uygulamaları';

  @override
  String get seeAll => 'Tümünü Gör';

  @override
  String get activeDuel => 'Aktif Düello';

  @override
  String get startDuelPrompt => 'Düello başlat!';

  @override
  String get you => 'Sen';

  @override
  String moreCount(int count) {
    return '+$count daha';
  }

  @override
  String get removeWithPro => 'Pro ile kaldır';

  @override
  String get adLabel => 'Reklam';

  @override
  String get focus => 'Odaklan';

  @override
  String get legal => 'Yasal';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get termsOfService => 'Kullanım Şartları';

  @override
  String get kvkkText => 'KVKK Aydınlatma Metni';

  @override
  String get deleteMyAccount => 'Hesabımı Sil';

  @override
  String get edit => 'Düzenle';

  @override
  String get adminAddLoot => 'Admin: Ganimet Ekle';

  @override
  String get continueConsent => 'Devam ederek';

  @override
  String get acceptTermsSuffix => '\'ni kabul ediyorum.';

  @override
  String get alreadyHaveAccount => 'Zaten hesabım var';

  @override
  String get screenTimePermissionTitle =>
      'Ekran süreni takip etmemiz gerekiyor';

  @override
  String get screenTimePermissionDesc =>
      'Hangi uygulamalarda ne kadar vakit geçirdiğini görmek için ekran süresi erişimi gerekiyor.';

  @override
  String get screenTimeGranted => 'Ekran süresi izni verildi!';

  @override
  String get continueButton => 'Devam Et';

  @override
  String get skip => 'Atla';

  @override
  String get yourName => 'İsmin';

  @override
  String get nameHint => 'Adını yaz';

  @override
  String get ageGroup => 'Yaş Grubu';

  @override
  String get imReady => 'Hazırım';

  @override
  String get dailyGoalTitle => 'Günlük Hedefin';

  @override
  String get goalQuestion => 'Günde kaç saat ekran süresi hedefliyorsun?';

  @override
  String get goalMotivational1 => 'Harika! Gerçek bir dijital detox hedefi 💪';

  @override
  String get goalMotivational2 => 'Dengeli bir hedef, başarabilirsin! 🎯';

  @override
  String get goalMotivational3 =>
      'İyi bir başlangıç, zamanla azaltabilirsin 📉';

  @override
  String get goalMotivational4 => 'Adım adım ilerle, her dakika önemli ⭐';

  @override
  String get next => 'İleri';

  @override
  String hourShort(int count) {
    return '${count}sa';
  }

  @override
  String get welcomeSlogan =>
      'Ekranını bırak. Arkadaşlarını yen.\nŞehrinde 1 numara ol.';

  @override
  String get deleteAccount => 'Hesabı Sil';

  @override
  String get deleteAccountConfirm =>
      'Hesabınız ve tüm verileriniz kalıcı olarak silinecek. Bu işlem geri alınamaz.';

  @override
  String get cancel => 'İptal';

  @override
  String get confirm => 'Onayla';

  @override
  String get ok => 'Tamam';

  @override
  String get error => 'Hata';

  @override
  String get tryAgain => 'Tekrar Dene';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get loadFailed => 'Yüklenemedi';

  @override
  String get noDataYet => 'Henüz veri yok';

  @override
  String get welcome => 'Hoş Geldin';

  @override
  String get welcomeSubtitle => 'Ekranını bırak. Arkadaşlarını yen.';

  @override
  String get continueWithGoogle => 'Google ile Devam Et';

  @override
  String get continueWithApple => 'Apple ile Devam Et';

  @override
  String get continueWithEmail => 'E-posta ile Devam Et';

  @override
  String get permissionsTitle => 'İzinler';

  @override
  String get permissionsSubtitle =>
      'Ekran sürenizi takip edebilmemiz için izin gerekiyor.';

  @override
  String get grantPermission => 'İzin Ver';

  @override
  String get setupProfile => 'Profil Oluştur';

  @override
  String get displayName => 'Görünen Ad';

  @override
  String get selectCity => 'Şehir Seç';

  @override
  String get selectGoal => 'Günlük Hedef Seç';

  @override
  String get noDuelsYet => 'Henüz düello yok';

  @override
  String get noDuelsYetSubtitle => 'İlk düellonu başlat!';

  @override
  String get activeDuelsTitle => 'Aktif Duellolar';

  @override
  String get newDuel => 'Yeni Düello';

  @override
  String get selectDuelType => 'Düello Türü Seç';

  @override
  String get selectDurationStep => 'Süre Seç';

  @override
  String get selectOpponent => 'Rakip Seç';

  @override
  String get duelStartButton => 'Düelloya Başla! ⚔️';

  @override
  String get freePlanDuelLimit =>
      'Ücretsiz planda en fazla 3 aktif düello! Pro\'ya yükselt.';

  @override
  String get quickSelect => 'Hızlı Seçim';

  @override
  String get customDuration => 'Özel Süre Seç';

  @override
  String selectedDuration(String duration) {
    return 'Seçilen: $duration';
  }

  @override
  String get minDurationWarning => 'En az 10 dakika seçmelisin';

  @override
  String get selectPenalty => 'Ceza Seç (opsiyonel)';

  @override
  String get searchFriend => 'Arkadaş ara...';

  @override
  String get inviteWithLink => 'Link ile Davet Et 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '${count}dk bugün';
  }

  @override
  String duelRemaining(int h, int m) {
    return '${h}s ${m}dk kaldı';
  }

  @override
  String get remainingTime => 'Kalan Süre';

  @override
  String watchersCount(int count) {
    return '$count kişi izliyor 👀';
  }

  @override
  String get giveUp => 'Pes Et';

  @override
  String get duelWon => 'Kazandın! 🎉';

  @override
  String get duelLost => 'Kaybettin 😔';

  @override
  String get greatPerformance => 'Harika performans gösterdin!';

  @override
  String get betterNextTime => 'Bir dahaki sefere daha iyi olacak!';

  @override
  String get revenge => 'İntikam Al 🔥';

  @override
  String get share => 'Paylaş';

  @override
  String get selectFriend => 'Arkadaş Seç';

  @override
  String get orSendLink => 'veya Link Gönder';

  @override
  String get social => 'Sosyal';

  @override
  String get myFriends => 'Arkadaşlarım';

  @override
  String get inMyCity => 'Şehrimdekiler';

  @override
  String get shareFirstStory => 'İlk hikayeni paylaşarak başlat!';

  @override
  String get createStoryTitle => 'Hikaye Paylaş';

  @override
  String get addPhoto => 'Fotoğraf Ekle';

  @override
  String get whatAreYouDoing => 'Ne yapıyorsun?';

  @override
  String get captionHint => 'Telefondan uzakta ne yapıyorsun?';

  @override
  String get howLongVisible => 'Ne kadar süre görünsün?';

  @override
  String get whoCanSee => 'Kimler görsün?';

  @override
  String get onlyFriends => 'Sadece Arkadaşlarım';

  @override
  String get cityPeople => 'Şehrimdekiler';

  @override
  String get photoStoriesPro =>
      'Fotoğraflı hikayeler Pro planında! Ayarlar > Off-Grid Kulübü';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galeri';

  @override
  String get writeFirst => 'Bir şeyler yaz!';

  @override
  String get inappropriateContent => 'Uygunsuz içerik tespit edildi';

  @override
  String viewsCount(int count) {
    return '$count görüntülenme';
  }

  @override
  String get editProfile => 'Profili Düzenle';

  @override
  String get changePhoto => 'Fotoğraf Değiştir';

  @override
  String get firstName => 'Ad';

  @override
  String get firstNameHint => 'Adınız';

  @override
  String get lastName => 'Soyad';

  @override
  String get lastNameHint => 'Soyadınız';

  @override
  String get usernameLabel => 'Kullanıcı Adı';

  @override
  String get updateLocation => 'Konumunu Güncelle';

  @override
  String get locationUnknown => 'Bilinmeyen';

  @override
  String get save => 'Kaydet';

  @override
  String get usernameAvailable => 'Kullanılabilir';

  @override
  String get usernameTaken => 'Bu kullanıcı adı alınmış';

  @override
  String get usernameFormatError => 'En az 3 karakter, sadece harf, rakam ve _';

  @override
  String get profileUpdated => 'Profil güncellendi';

  @override
  String get photoSelectedDemo => 'Fotoğraf seçildi (demo modda yüklenmez)';

  @override
  String get locationError => 'Konum alınamadı';

  @override
  String get errorOccurred => 'Bir hata oluştu';

  @override
  String get detailedScreenTime => 'Detaylı Ekran Süresi';

  @override
  String get monthlyTop10 => 'Ayın En İyileri';

  @override
  String get searchHint => 'Ara...';

  @override
  String get noFriendsYet => 'Henüz arkadaş yok';

  @override
  String get noFriendsHint => 'Arkadaş ekleyerek başla';

  @override
  String get showQrCode => 'QR kodunu göster';

  @override
  String get enterCode => 'Kod Gir';

  @override
  String get inviteLinkShare => 'Davet Linki Paylaş';

  @override
  String get startDuelAction => 'Düello Başlat';

  @override
  String get pointsLabel => 'Puan';

  @override
  String get mostUsedLabel => 'En cok:';

  @override
  String get recentBadges => 'Son Rozetler';

  @override
  String get allBadgesLabel => 'Tüm Rozetler';

  @override
  String get removeFriend => 'Arkadaşlıktan Çıkar';

  @override
  String get removeFriendConfirm =>
      'Bu kişiyi arkadaş listenden çıkarmak istediğine emin misin?';

  @override
  String get remove => 'Çıkar';

  @override
  String get requestSent => 'İstek Gönderildi';

  @override
  String get whatCouldYouDo => 'Ne Yapabilirdin?';

  @override
  String get back => 'Geri';

  @override
  String get weekly => 'Haftalık';

  @override
  String get daily => 'Günlük';

  @override
  String get mostUsedApps => 'En Çok Kullanılanlar';

  @override
  String get unlockSection => 'Kilit Açma';

  @override
  String get selectedDayLabel => 'Seçili Gün';

  @override
  String get todayLabel => 'Bugün';

  @override
  String weeklyAvgLabel(int h, int m) {
    return 'Günlük ort: ${h}sa ${m}dk';
  }

  @override
  String get firstUnlock => 'İlk Açılış';

  @override
  String get mostOpened => 'En Çok Açılan';

  @override
  String get timesPickedUp => 'Kez Ele Alındı';

  @override
  String get openingCount => 'açma';

  @override
  String get notificationUnit => 'bildirim';

  @override
  String get timesUnit => 'kez';

  @override
  String get turkey => 'Türkiye';

  @override
  String get consecutiveDays => 'gün üst üste';

  @override
  String bestStreakLabel(int days) {
    return 'En iyi: $days gün';
  }

  @override
  String get seriFriends => 'Arkadaşlar';

  @override
  String get oxygenTitle => 'Oksijen (O₂)';

  @override
  String get totalO2 => 'Toplam';

  @override
  String get remainingShort => 'Kalan';

  @override
  String get noOffersYet => 'Henüz teklif yok';

  @override
  String o2SpentMsg(int amount) {
    return '$amount O₂ harcandı';
  }

  @override
  String get mapLoadFailed => 'Harita yüklenemedi';

  @override
  String confirmRedeemMsg(String reward) {
    return '$reward ödülünü almak istiyor musun?';
  }

  @override
  String itemReceived(String item) {
    return '$item alındı!';
  }

  @override
  String get insufficientO2 => 'Yetersiz O₂';

  @override
  String get season1Title => 'Sezon 1';

  @override
  String get season1Subtitle => 'Bahar Uyanışı';

  @override
  String get seasonPassBtn => 'Sezon Pass (99TL)';

  @override
  String get seasonPassLabel => 'Sezon Pass';

  @override
  String get noGroupsYet => 'Henüz grup yok';

  @override
  String get noGroupsSubtitle => 'Arkadaşlarınla grup oluştur';

  @override
  String get newGroup => 'Yeni Grup';

  @override
  String memberCount(int count) {
    return '$count üye';
  }

  @override
  String get weeklyGoal => 'Haftalık Hedef';

  @override
  String challengeProgress(int percent) {
    return '%$percent tamamlandı';
  }

  @override
  String get membersLabel => 'Üyeler';

  @override
  String get inviteLink => 'Davet Linki';

  @override
  String get linkCopied => 'Link kopyalandı!';

  @override
  String get copy => 'Kopyala';

  @override
  String get qrCode => 'QR Kod';

  @override
  String get groupNameLabel => 'Grup Adı';

  @override
  String get groupNameHint => 'Grup adını gir';

  @override
  String get groupNameEmpty => 'Grup adı boş olamaz';

  @override
  String dailyGoalHours(int hours) {
    return 'Günlük Hedef: $hours saat';
  }

  @override
  String get addMember => 'Üye Ekle';

  @override
  String selectedCount(int count) {
    return '$count kişi seçildi';
  }

  @override
  String get create => 'Oluştur';

  @override
  String groupCreated(String name) {
    return '$name oluşturuldu!';
  }

  @override
  String invitedCount(int count) {
    return '$count kişi davet edildi';
  }

  @override
  String get screenTimeLower => 'ekran süresi';

  @override
  String get improvedFromLastWeek => 'Geçen haftadan %12 daha iyi';

  @override
  String get o2Earned => 'O₂ Kazanılan';

  @override
  String get friendRank => 'Arkadaş Sıra';

  @override
  String cityRankLabel(String city) {
    return '$city Sıra';
  }

  @override
  String get mostUsed => 'En çok kullanılan';

  @override
  String get offGridClub => 'Off-Grid Kulübü';

  @override
  String get clubSubtitle => 'Dijital dengeyi yakala, ödülünü al.';

  @override
  String get planStarter => 'Başlangıç';

  @override
  String get planStarterSubtitle => 'Temel özelliklerle başla';

  @override
  String get currentPlanBtn => 'Mevcut Plan';

  @override
  String get billingMonthly => 'Aylık';

  @override
  String get billingYearly => 'Yıllık';

  @override
  String get yearlySavings => '%33 tasarruf';

  @override
  String get planComparison => 'Plan Karşılaştırma';

  @override
  String get breathTechniquesComp => 'Nefes teknikleri';

  @override
  String get activeDuelsComp => 'Aktif düello';

  @override
  String get storyPhoto => 'Hikaye fotoğraf';

  @override
  String get heatMap => 'Isı haritası';

  @override
  String get top10Report => 'Top 10 rapor';

  @override
  String get exclusiveBadges => 'Özel rozetler';

  @override
  String get adFree => 'Reklamsız';

  @override
  String get familyPlanComp => 'Aile planı';

  @override
  String get familyReport => 'Aile raporu';

  @override
  String get exclusiveThemes => 'Özel temalar';

  @override
  String get prioritySupport => 'Öncelikli destek';

  @override
  String get billingNote =>
      'Abonelik istediğin zaman iptal edilebilir.\nÖdeme App Store/Google Play üzerinden yapılır.\nAbonelik dönem sonunda otomatik yenilenir.';

  @override
  String get restoreSuccess => 'Satın alımlar geri yüklendi!';

  @override
  String get restoreFailed => 'Geri yüklenecek satın alım bulunamadı.';

  @override
  String get packagesLoadFailed => 'Paketler yüklenemedi. Lütfen tekrar dene.';

  @override
  String get themesTitle => 'Temalar';

  @override
  String get themeLockedMsg =>
      'Bu tema Pro+ planında! Ayarlar > Off-Grid Kulübü';

  @override
  String get familyPlanTitle => 'Aile Planı';

  @override
  String get familyPlanLocked => 'Ailenle Birlikte Dijital Denge';

  @override
  String get familyPlanLockedDesc =>
      '5 kişiye kadar aile üyesi ekle, birlikte hedef koy ve haftalık aile raporu al.';

  @override
  String get weeklyFamilyReport => 'Haftalık Aile Raporu';

  @override
  String get familyRanking => 'Aile Sıralaması';

  @override
  String get totalOffline => 'Toplam Offline';

  @override
  String get average => 'Ortalama';

  @override
  String get best => 'En İyi';

  @override
  String offlineTime(int h, int m) {
    return '${h}s ${m}dk offline';
  }

  @override
  String get enterName => 'İsim gir';

  @override
  String get cannotUndo => 'Bu işlem geri alınamaz!';

  @override
  String get deleteWarningDesc =>
      'Hesabını sildiğinde aşağıdaki veriler kalıcı olarak silinecektir:';

  @override
  String get deleteItem1 => 'Profil bilgilerin ve avatar';

  @override
  String get deleteItem2 => 'Tüm ekran süresi istatistiklerin';

  @override
  String get deleteItem3 => 'Arkadaş listen ve düellolar';

  @override
  String get deleteItem4 => 'Hikayelerin ve yorumların';

  @override
  String get deleteItem5 => 'O₂ puanların ve ganimetlerin';

  @override
  String get deleteItem6 => 'Abonelik geçmişin';

  @override
  String get deleteSubscriptionNote =>
      'Aktif aboneliğin varsa önce Apple App Store veya Google Play Store üzerinden iptal etmen gerekir.';

  @override
  String get deleteConfirmCheck =>
      'Hesabımın ve tüm verilerimin kalıcı olarak silineceğini anlıyorum.';

  @override
  String get deleteAccountBtn => 'Hesabımı Kalıcı Olarak Sil';

  @override
  String get deleteErrorMsg => 'Bir hata oluştu. Lütfen tekrar dene.';

  @override
  String get emailHint => 'E-posta';

  @override
  String get passwordHint => 'Şifre';

  @override
  String get forgotPassword => 'Şifremi unuttum';

  @override
  String get passwordResetSent => 'Şifre sıfırlama maili gönderildi.';

  @override
  String get signUp => 'Kayıt Ol';

  @override
  String get signIn => 'Giriş Yap';

  @override
  String get orDivider => 'veya';

  @override
  String get continueWithGoogleShort => 'Google ile devam et';

  @override
  String get continueWithAppleShort => 'Apple ile devam et';

  @override
  String get noAccountYet => 'Hesabın yok mu? ';

  @override
  String get adminExistingPoints => 'Mevcut Noktalar';

  @override
  String get adminSearchPlace => 'Mekan ara...';

  @override
  String get adminRewardTitle => 'Ödül Başlığı (ör: Bedava Kahve)';

  @override
  String get adminO2Cost => 'O₂ Maliyeti';

  @override
  String get adminSave => 'Kaydet';

  @override
  String get adminSaved => 'Kaydedildi!';

  @override
  String get adminDeleteTitle => 'Sil';

  @override
  String get adminDeleteMsg => 'Bu noktayı silmek istediğine emin misin?';

  @override
  String adminDeleteError(String error) {
    return 'Silme hatası: $error';
  }

  @override
  String get adminFillFields => 'Ödül ve O₂ maliyeti doldurun';

  @override
  String breathCount(int count) {
    return '$count nefes';
  }

  @override
  String minutesRemaining(int count) {
    return '${count}dk kaldı';
  }

  @override
  String focusMinutes(int count) {
    return '$count dakika odaklandın';
  }

  @override
  String get o2TimeRestriction => 'O₂ sadece 08:00–00:00 arası kazanılır';

  @override
  String get breathTechniqueProMsg =>
      'Bu teknik Pro planında! Ayarlar > Off-Grid Kulübü';

  @override
  String get inhale => 'Al';

  @override
  String get holdBreath => 'Tut';

  @override
  String get exhale => 'Ver';

  @override
  String get waitBreath => 'Bekle';

  @override
  String get proMostPopular => 'En Popüler';

  @override
  String get proFamilyBadge => 'AİLE';

  @override
  String get comparedToLastWeek => 'geçen haftaya göre';

  @override
  String get appBlockTitle => 'Uygulama Engelleme';

  @override
  String get appBlockSchedule => 'Program';

  @override
  String get appBlockEnableBlocking => 'Engellemeyi Aktif Et';

  @override
  String get appBlockActive => 'Engelleme açık';

  @override
  String get appBlockInactive => 'Engelleme kapalı';

  @override
  String get appBlockStrictMode => 'Katı Mod';

  @override
  String get appBlockStrictDesc => 'Aktifken engelleme kapatılamaz';

  @override
  String get appBlockStrictExpired => 'Süre doldu';

  @override
  String get appBlockStrictDurationTitle => 'Katı Mod Süresi';

  @override
  String get appBlockDuration30m => '30 dakika';

  @override
  String get appBlockDuration1h => '1 saat';

  @override
  String get appBlockDuration2h => '2 saat';

  @override
  String get appBlockDuration4h => '4 saat';

  @override
  String get appBlockDurationAllDay => 'Tüm Gün (24 saat)';

  @override
  String get appBlockScheduleTitle => 'Engelleme Programı';

  @override
  String get appBlockScheduleDesc => 'Günlük zaman aralıkları ayarla';

  @override
  String get appBlockBlockedApps => 'Engellenen Uygulamalar';

  @override
  String get appBlockNoApps => 'Henüz uygulama eklenmedi';

  @override
  String get appBlockAddApp => 'Uygulama Ekle';

  @override
  String get appBlockPickerTitle => 'Uygulama Seç';

  @override
  String get appBlockPresetWork => 'Çalışma Saatleri (09-18)';

  @override
  String get appBlockPresetSleep => 'Uyku Saati (23-07)';

  @override
  String get appBlockPresetAllDay => 'Tüm Gün';

  @override
  String get appBlockInterventionTitle => 'Dur bir saniye...';

  @override
  String get appBlockInterventionSubtitle => 'Bir nefes al, kendini izle';

  @override
  String get appBlockInterventionGiveUp => 'Vazgeçtim';

  @override
  String get appBlockInterventionOpenAnyway => 'Yine de aç';

  @override
  String get appBlockStrictModeActive => 'Katı mod — açılamaz';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return '$app\'da bu hafta $hours saat geçirdin';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return 'Bu ay $count kez vazgeçtin';
  }

  @override
  String get pickAppToBan => 'Yasaklanacak uygulamayı seç';

  @override
  String get pickAppToBanDesc => 'Rakibin 24 saat bu uygulamayı açamayacak';

  @override
  String get pickCategory => 'Kategori seç';

  @override
  String get pickCategoryDesc => 'Sadece bu kategorideki süre sayılacak';

  @override
  String get rollDiceForTarget => 'Zar at, hedefini belirlesin';

  @override
  String get rollDiceDesc => 'Zarın değeri × 30 dakika = hedef süre';

  @override
  String get diceTapToRoll => 'Atmak için dokun';

  @override
  String get diceRolling => 'Zar dönüyor...';

  @override
  String diceResult(int value) {
    return 'Sonuç: $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return 'Hedef süre: $minutes dk';
  }

  @override
  String get chooseTeammates => 'Takım arkadaşı seç';

  @override
  String teammatesSelected(int count) {
    return '$count/3 seçildi  ·  2 veya 3 takım arkadaşı seç';
  }

  @override
  String get nightDuelInfo => 'Gece Düellosu';

  @override
  String get nightDuelRange => '23:00 — 07:00';

  @override
  String get nightDuelBody =>
      'Telefona bakmadan uyu. Kim daha uzun dokunmazsa kazanır. Süre sabit 8 saat.';

  @override
  String get nightDuelAutoStart => 'Bu düello saat 23:00\'de otomatik başlar.';

  @override
  String get mysteryMissionTitle => 'Gizemli Görev';

  @override
  String get mysteryMissionSubtitle => 'Görev düello başlayınca açıklanır';

  @override
  String get mysteryMissionBody =>
      'Düelloyu başlattığında rastgele bir görev seçilir.';

  @override
  String get mysteryStart => 'Göreve Başla';

  @override
  String opponentWantsToBanApp(String app) {
    return 'Rakibin $app uygulamasını yasaklamanı istiyor';
  }

  @override
  String opponentWantsCategory(String category) {
    return 'Rakibin $category kategorisinde yarışmanı istiyor';
  }

  @override
  String get proposeDifferentApp => 'O uygulamam yok, başka öner';

  @override
  String get proposeDifferentCategory =>
      'O kategoriyi kullanmıyorum, başka öner';

  @override
  String get acceptInvite => 'Kabul Et';

  @override
  String proposalSent(String value) {
    return 'Öneri gönderildi: $value';
  }

  @override
  String get stepAppPicker => 'Uygulama seç';

  @override
  String get stepCategoryPicker => 'Kategori seç';

  @override
  String get stepDice => 'Zar at';

  @override
  String get stepNightInfo => 'Gece düellosu';

  @override
  String get stepMystery => 'Gizemli görev';

  @override
  String get stepTeamPicker => 'Takım arkadaşı seç';
}
