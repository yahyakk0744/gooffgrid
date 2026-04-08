// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan =>
      'Stecker raus. Spiel beginnen. Nicht im Digitalen verlieren.';

  @override
  String get home => 'Startseite';

  @override
  String get ranking => 'Rangliste';

  @override
  String get duel => 'Duell';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Einstellungen';

  @override
  String get stories => 'Storys';

  @override
  String get today => 'Heute';

  @override
  String get thisWeek => 'Diese Woche';

  @override
  String get friends => 'Freunde';

  @override
  String get friendsOf => 'Freunde von';

  @override
  String get allFriends => 'Alle';

  @override
  String get city => 'Stadt';

  @override
  String get country => 'Land';

  @override
  String get global => 'Global';

  @override
  String minutes(int count) {
    return '$count Min';
  }

  @override
  String hours(int count) {
    return '$count Std';
  }

  @override
  String hoursMinutes(int h, int m) {
    return '${h}Std ${m}Min';
  }

  @override
  String get screenTime => 'Bildschirmzeit';

  @override
  String get phonePickups => 'Handyaufnahmen';

  @override
  String pickupsToday(int count) {
    return 'Heute $count Mal aufgenommen';
  }

  @override
  String get topTriggers => 'Häufigste Auslöser';

  @override
  String get longestOffScreen => 'Längste Offline-Zeit';

  @override
  String get dailyGoal => 'Tagesziel';

  @override
  String goalHours(int count) {
    return 'Ziel: $count Stunden';
  }

  @override
  String get streak => 'Serie';

  @override
  String streakDays(int count) {
    return '$count Tage';
  }

  @override
  String get level => 'Level';

  @override
  String get badges => 'Abzeichen';

  @override
  String get duels => 'Duelle';

  @override
  String get activeDuels => 'Aktiv';

  @override
  String get pastDuels => 'Vergangen';

  @override
  String get createDuel => 'Duell erstellen';

  @override
  String get startDuel => 'Duell starten';

  @override
  String get invite => 'Einladen';

  @override
  String get accept => 'Annehmen';

  @override
  String get decline => 'Ablehnen';

  @override
  String get win => 'Gewonnen';

  @override
  String get lose => 'Verloren';

  @override
  String get draw => 'Unentschieden';

  @override
  String get addFriend => 'Freund hinzufügen';

  @override
  String get friendCode => 'Freundescode';

  @override
  String get search => 'Suchen';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get dailyReminder => 'Tägliche Erinnerung';

  @override
  String get duelNotifications => 'Duell-Benachrichtigungen';

  @override
  String get locationSharing => 'Standortfreigabe';

  @override
  String get subscription => 'Abonnement';

  @override
  String get free => 'Kostenlos';

  @override
  String get pro => 'Pro';

  @override
  String get proPlus => 'Pro+';

  @override
  String get currentPlan => 'Aktueller Plan';

  @override
  String get recommended => 'Empfohlen';

  @override
  String get start => 'Starten';

  @override
  String get upgradeToPro => 'Auf Pro upgraden';

  @override
  String get upgradeToProPlus => 'Auf Pro+ upgraden';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String monthlyPrice(String price) {
    return '$price/Mo';
  }

  @override
  String get freeFeature1 => 'Tägliche Bildschirmzeit-Verfolgung';

  @override
  String get freeFeature2 => 'Freundes-Ranglisten';

  @override
  String get freeFeature3 => '3 aktive Duelle';

  @override
  String get freeFeature4 => 'Grundlegende Abzeichen';

  @override
  String get proFeature1 => 'Alle Ranglisten (Stadt, Land, Global)';

  @override
  String get proFeature2 => 'Detaillierte Statistiken & Fokus-Kalender';

  @override
  String get proFeature3 => 'Unbegrenzte Duelle';

  @override
  String get proFeature4 => 'Off-Grid-Pässe inklusive';

  @override
  String get proFeature5 => 'Werbefreies Erlebnis';

  @override
  String get proPlusFeature1 => 'Alles aus Pro';

  @override
  String get proPlusFeature2 => 'Familienplan (5 Personen)';

  @override
  String get proPlusFeature3 => 'Prioritäts-Support';

  @override
  String get proPlusFeature4 => 'Exklusive Abzeichen & Themes';

  @override
  String get proPlusFeature5 => 'Frühzeitiger Zugang zu Beta-Funktionen';

  @override
  String get paywallTitle => 'Off-Grid Club';

  @override
  String get paywallSubtitle => 'Werde dafür belohnt, abzuschalten.';

  @override
  String get logout => 'Abmelden';

  @override
  String get shareProfile => 'Profil teilen';

  @override
  String get shareReportCard => 'Zeig was du drauf hast';

  @override
  String get appUsage => 'App-Nutzung';

  @override
  String get whatDidYouUse => 'Was hast du heute genutzt?';

  @override
  String get weeklyReport => 'Wochenbericht';

  @override
  String get weeklyTrend => '7-Tage-Trend';

  @override
  String get seasons => 'Saisons';

  @override
  String get seasonPass => 'Off-Grid-Pässe';

  @override
  String get groups => 'Gruppen';

  @override
  String get createGroup => 'Gruppe erstellen';

  @override
  String get stats => 'Statistiken';

  @override
  String get analytics => 'Analytik';

  @override
  String get detailedAnalytics => 'Detaillierte Analytik';

  @override
  String get categories => 'Kategorien';

  @override
  String get weeklyUsage => 'Wöchentliche Nutzung';

  @override
  String get appDetails => 'App-Details';

  @override
  String get focusCalendar => 'Fokus-Kalender';

  @override
  String get whatIf => 'Was wäre wenn?';

  @override
  String get focusMode => 'Atmen';

  @override
  String get startFocusMode => 'Fokus-Modus starten';

  @override
  String get focusing => 'Du fokussierst dich...';

  @override
  String focusComplete(int minutes) {
    return 'Super! Du hast dich $minutes Min fokussiert';
  }

  @override
  String get focusTimeout => 'Sitzungs-Timeout';

  @override
  String get focusTimeoutDesc =>
      'Du hast das 120-Minuten-Limit erreicht.\nNoch da?';

  @override
  String get end => 'Beenden';

  @override
  String get reportCard => 'Zeugnis';

  @override
  String get antiSocialStory => 'Anti-Sozial-Moment';

  @override
  String get storyQuestion => 'Was machst du gerade ohne dein Handy?';

  @override
  String get postStory => 'Posten';

  @override
  String get storyExpired => 'Abgelaufen';

  @override
  String get noStories => 'Noch keine Storys';

  @override
  String get noStoriesHint =>
      'Lass deine Freunde ihre Off-Grid-Momente teilen!';

  @override
  String get storyBlocked => 'Story kann nicht geteilt werden';

  @override
  String get storyBlockedHint =>
      'Du hast dein tägliches Bildschirmzeit-Ziel überschritten. Halte dein Ziel ein, um Stories teilen zu dürfen!';

  @override
  String get duration => 'Dauer';

  @override
  String get walk => 'Spaziergang';

  @override
  String get run => 'Laufen';

  @override
  String get book => 'Buch';

  @override
  String get meditation => 'Meditation';

  @override
  String get nature => 'Natur';

  @override
  String get sports => 'Sport';

  @override
  String get music => 'Musik';

  @override
  String get cooking => 'Kochen';

  @override
  String get friendsActivity => 'Freunde';

  @override
  String get family => 'Familie';

  @override
  String get o2Balance => 'O₂-Punkte';

  @override
  String o2Remaining(int count) {
    return 'Verbleibend: $count';
  }

  @override
  String o2Today(int earned, int max) {
    return 'Heute: $earned/$max O₂';
  }

  @override
  String get o2Rules => 'O₂-Regeln';

  @override
  String get o2RuleTime => 'Nur zwischen 08:00–00:00 verdienbar';

  @override
  String get o2RuleDaily => 'Max. 500 O₂ pro Tag';

  @override
  String get o2RuleFocus => 'Fokus-Modus max. 120 Min';

  @override
  String get o2RuleTransfer => 'Kein Transfer oder Wetten';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂ (geschätzt)';
  }

  @override
  String get offGridMarket => 'Beute';

  @override
  String get offGridMarketHint => 'Wandle O₂-Punkte in echte Belohnungen um';

  @override
  String get redeem => 'Einlösen';

  @override
  String get insufficient => 'Nicht genug';

  @override
  String get redeemSuccess => 'Glückwunsch!';

  @override
  String get couponCode => 'Dein Gutscheincode:';

  @override
  String get recentTransactions => 'Letzte Transaktionen';

  @override
  String get noTransactions => 'Noch keine Transaktionen';

  @override
  String get categorySocial => 'Soziale Medien';

  @override
  String get categoryGame => 'Spiele';

  @override
  String get categoryVideo => 'Video';

  @override
  String get categoryAudio => 'Musik';

  @override
  String get categoryProductivity => 'Produktivität';

  @override
  String get categoryNews => 'Nachrichten';

  @override
  String get categoryGames => 'Spiele';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryBrowser => 'Browser';

  @override
  String get categoryMaps => 'Karten';

  @override
  String get categoryImage => 'Fotos';

  @override
  String get categoryOther => 'Sonstiges';

  @override
  String hello(String name) {
    return 'Hallo, $name';
  }

  @override
  String get goalCompleted => 'Ziel erreicht!';

  @override
  String get dailyGoalShort => 'Tagesziel';

  @override
  String get streakDaysLabel => 'Tage in Folge';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => 'Rang';

  @override
  String get offlineLabel => 'offline';

  @override
  String get todaysApps => 'Apps heute';

  @override
  String get seeAll => 'Alle anzeigen';

  @override
  String get activeDuel => 'Aktives Duell';

  @override
  String get startDuelPrompt => 'Starte ein Duell!';

  @override
  String get you => 'Du';

  @override
  String moreCount(int count) {
    return '+$count mehr';
  }

  @override
  String get removeWithPro => 'Mit Pro entfernen';

  @override
  String get adLabel => 'Anzeige';

  @override
  String get focus => 'Fokus';

  @override
  String get legal => 'Rechtliches';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get kvkkText => 'DSGVO-Datenschutzhinweis';

  @override
  String get deleteMyAccount => 'Mein Konto löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get adminAddLoot => 'Admin: Beute hinzufügen';

  @override
  String get continueConsent => 'Mit dem Fortfahren';

  @override
  String get acceptTermsSuffix => 'akzeptierst du.';

  @override
  String get alreadyHaveAccount => 'Ich habe bereits ein Konto';

  @override
  String get screenTimePermissionTitle =>
      'Wir müssen deine Bildschirmzeit verfolgen';

  @override
  String get screenTimePermissionDesc =>
      'Zugriff auf die Bildschirmzeit ist erforderlich, um zu sehen, wie viel Zeit du in den einzelnen Apps verbringst.';

  @override
  String get screenTimeGranted => 'Bildschirmzeit-Berechtigung erteilt!';

  @override
  String get continueButton => 'Weiter';

  @override
  String get skip => 'Überspringen';

  @override
  String get yourName => 'Dein Name';

  @override
  String get nameHint => 'Gib deinen Namen ein';

  @override
  String get ageGroup => 'Altersgruppe';

  @override
  String get imReady => 'Ich bin bereit';

  @override
  String get dailyGoalTitle => 'Dein Tagesziel';

  @override
  String get goalQuestion =>
      'Wie viele Stunden Bildschirmzeit strebst du täglich an?';

  @override
  String get goalMotivational1 =>
      'Fantastisch! Ein echtes Digital-Detox-Ziel 💪';

  @override
  String get goalMotivational2 => 'Ein ausgewogenes Ziel, du schaffst das! 🎯';

  @override
  String get goalMotivational3 =>
      'Ein guter Start, du kannst es mit der Zeit reduzieren 📉';

  @override
  String get goalMotivational4 => 'Schritt für Schritt, jede Minute zählt ⭐';

  @override
  String get next => 'Weiter';

  @override
  String hourShort(int count) {
    return '${count}Std';
  }

  @override
  String get welcomeSlogan =>
      'Leg dein Handy weg. Schlage deine Freunde.\nSei #1 in deiner Stadt.';

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get deleteAccountConfirm =>
      'Dein Konto und alle Daten werden dauerhaft gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Fehler';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get loading => 'Laden...';

  @override
  String get loadFailed => 'Laden fehlgeschlagen';

  @override
  String get noDataYet => 'Noch keine Daten';

  @override
  String get welcome => 'Willkommen';

  @override
  String get welcomeSubtitle => 'Leg dein Handy weg. Schlage deine Freunde.';

  @override
  String get continueWithGoogle => 'Mit Google fortfahren';

  @override
  String get continueWithApple => 'Mit Apple fortfahren';

  @override
  String get continueWithEmail => 'Mit E-Mail fortfahren';

  @override
  String get permissionsTitle => 'Berechtigungen';

  @override
  String get permissionsSubtitle =>
      'Wir benötigen die Erlaubnis, deine Bildschirmzeit zu verfolgen.';

  @override
  String get grantPermission => 'Berechtigung erteilen';

  @override
  String get setupProfile => 'Profil einrichten';

  @override
  String get displayName => 'Anzeigename';

  @override
  String get selectCity => 'Stadt auswählen';

  @override
  String get selectGoal => 'Tagesziel auswählen';

  @override
  String get noDuelsYet => 'Noch keine Duelle';

  @override
  String get noDuelsYetSubtitle => 'Starte dein erstes Duell!';

  @override
  String get activeDuelsTitle => 'Aktive Duelle';

  @override
  String get newDuel => 'Neues Duell';

  @override
  String get selectDuelType => 'Duelltyp auswählen';

  @override
  String get selectDurationStep => 'Dauer auswählen';

  @override
  String get selectOpponent => 'Gegner auswählen';

  @override
  String get duelStartButton => 'Duell starten! ⚔️';

  @override
  String get freePlanDuelLimit =>
      'Der kostenlose Plan erlaubt max. 3 aktive Duelle! Upgrade auf Pro.';

  @override
  String get quickSelect => 'Schnellauswahl';

  @override
  String get customDuration => 'Benutzerdefinierte Dauer';

  @override
  String selectedDuration(String duration) {
    return 'Ausgewählt: $duration';
  }

  @override
  String get minDurationWarning => 'Du musst mindestens 10 Minuten auswählen';

  @override
  String get selectPenalty => 'Strafe auswählen (optional)';

  @override
  String get searchFriend => 'Freund suchen...';

  @override
  String get inviteWithLink => 'Per Link einladen 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '${count}Min heute';
  }

  @override
  String duelRemaining(int h, int m) {
    return 'Noch ${h}Std ${m}Min';
  }

  @override
  String get remainingTime => 'Verbleibende Zeit';

  @override
  String watchersCount(int count) {
    return '$count schauen zu 👀';
  }

  @override
  String get giveUp => 'Aufgeben';

  @override
  String get duelWon => 'Du hast gewonnen! 🎉';

  @override
  String get duelLost => 'Du hast verloren 😔';

  @override
  String get greatPerformance => 'Tolle Leistung!';

  @override
  String get betterNextTime => 'Beim nächsten Mal klappt\'s besser!';

  @override
  String get revenge => 'Revanche 🔥';

  @override
  String get share => 'Teilen';

  @override
  String get selectFriend => 'Freund auswählen';

  @override
  String get orSendLink => 'oder Link senden';

  @override
  String get social => 'Sozial';

  @override
  String get myFriends => 'Meine Freunde';

  @override
  String get inMyCity => 'In meiner Stadt';

  @override
  String get shareFirstStory =>
      'Sei der Erste, der seinen Off-Grid-Moment teilt!';

  @override
  String get createStoryTitle => 'Story teilen';

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String get whatAreYouDoing => 'Was machst du?';

  @override
  String get captionHint => 'Was machst du gerade ohne dein Handy?';

  @override
  String get howLongVisible => 'Wie lange soll es sichtbar sein?';

  @override
  String get whoCanSee => 'Wer kann es sehen?';

  @override
  String get onlyFriends => 'Nur meine Freunde';

  @override
  String get cityPeople => 'Menschen in meiner Stadt';

  @override
  String get photoStoriesPro =>
      'Foto-Storys sind Pro! Einstellungen > Off-Grid Club';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galerie';

  @override
  String get writeFirst => 'Schreib zuerst etwas!';

  @override
  String get inappropriateContent => 'Unangemessener Inhalt erkannt';

  @override
  String viewsCount(int count) {
    return '$count Aufrufe';
  }

  @override
  String get editProfile => 'Profil bearbeiten';

  @override
  String get changePhoto => 'Foto ändern';

  @override
  String get firstName => 'Vorname';

  @override
  String get firstNameHint => 'Dein Vorname';

  @override
  String get lastName => 'Nachname';

  @override
  String get lastNameHint => 'Dein Nachname';

  @override
  String get usernameLabel => 'Benutzername';

  @override
  String get updateLocation => 'Standort aktualisieren';

  @override
  String get locationUnknown => 'Unbekannt';

  @override
  String get save => 'Speichern';

  @override
  String get usernameAvailable => 'Verfügbar';

  @override
  String get usernameTaken => 'Dieser Benutzername ist vergeben';

  @override
  String get usernameFormatError =>
      'Mindestens 3 Zeichen, nur Buchstaben, Zahlen und _';

  @override
  String get profileUpdated => 'Profil aktualisiert';

  @override
  String get photoSelectedDemo =>
      'Foto ausgewählt (wird im Demo-Modus nicht hochgeladen)';

  @override
  String get locationError => 'Standort konnte nicht ermittelt werden';

  @override
  String get errorOccurred => 'Ein Fehler ist aufgetreten';

  @override
  String get detailedScreenTime => 'Detaillierte Bildschirmzeit';

  @override
  String get monthlyTop10 => 'Monatliche Top 10';

  @override
  String get searchHint => 'Suchen...';

  @override
  String get noFriendsYet => 'Noch keine Freunde';

  @override
  String get noFriendsHint => 'Füge einen Freund hinzu';

  @override
  String get showQrCode => 'Zeige deinen QR-Code';

  @override
  String get enterCode => 'Code eingeben';

  @override
  String get inviteLinkShare => 'Einladungslink teilen';

  @override
  String get startDuelAction => 'Duell starten';

  @override
  String get pointsLabel => 'Punkte';

  @override
  String get mostUsedLabel => 'Am meisten genutzt:';

  @override
  String get recentBadges => 'Neueste Abzeichen';

  @override
  String get allBadgesLabel => 'Alle Abzeichen';

  @override
  String get removeFriend => 'Freund entfernen';

  @override
  String get removeFriendConfirm =>
      'Möchtest du diese Person wirklich aus deiner Freundesliste entfernen?';

  @override
  String get remove => 'Entfernen';

  @override
  String get requestSent => 'Anfrage gesendet';

  @override
  String get whatCouldYouDo => 'Was hättest du tun können?';

  @override
  String get back => 'Zurück';

  @override
  String get weekly => 'Wöchentlich';

  @override
  String get daily => 'Täglich';

  @override
  String get mostUsedApps => 'Meistgenutzte Apps';

  @override
  String get unlockSection => 'Entsperrungen';

  @override
  String get selectedDayLabel => 'Ausgewählter Tag';

  @override
  String get todayLabel => 'Heute';

  @override
  String weeklyAvgLabel(int h, int m) {
    return 'Tägl. Durchschn.: ${h}Std ${m}Min';
  }

  @override
  String get firstUnlock => 'Erste Entsperrung';

  @override
  String get mostOpened => 'Am häufigsten geöffnet';

  @override
  String get timesPickedUp => 'Aufgenommen';

  @override
  String get openingCount => 'Öffnungen';

  @override
  String get notificationUnit => 'Benachrichtigungen';

  @override
  String get timesUnit => 'Mal';

  @override
  String get turkey => 'Türkiye';

  @override
  String get consecutiveDays => 'Tage in Folge';

  @override
  String bestStreakLabel(int days) {
    return 'Bestwert: $days Tage';
  }

  @override
  String get seriFriends => 'Freunde';

  @override
  String get oxygenTitle => 'Sauerstoff (O₂)';

  @override
  String get totalO2 => 'Gesamt';

  @override
  String get remainingShort => 'Verbleibend';

  @override
  String get noOffersYet => 'Noch keine Angebote';

  @override
  String o2SpentMsg(int amount) {
    return '$amount O₂ ausgegeben';
  }

  @override
  String get mapLoadFailed => 'Karte konnte nicht geladen werden';

  @override
  String confirmRedeemMsg(String reward) {
    return 'Möchtest du $reward einlösen?';
  }

  @override
  String itemReceived(String item) {
    return '$item eingelöst!';
  }

  @override
  String get insufficientO2 => 'Nicht genug O₂';

  @override
  String get season1Title => 'Saison 1';

  @override
  String get season1Subtitle => 'Frühlingserwachen';

  @override
  String get seasonPassBtn => 'Saison-Pass (99TL)';

  @override
  String get seasonPassLabel => 'Saison-Pass';

  @override
  String get noGroupsYet => 'Noch keine Gruppen';

  @override
  String get noGroupsSubtitle => 'Erstelle eine Gruppe mit deinen Freunden';

  @override
  String get newGroup => 'Neue Gruppe';

  @override
  String memberCount(int count) {
    return '$count Mitglieder';
  }

  @override
  String get weeklyGoal => 'Wochenziel';

  @override
  String challengeProgress(int percent) {
    return '$percent% abgeschlossen';
  }

  @override
  String get membersLabel => 'Mitglieder';

  @override
  String get inviteLink => 'Einladungslink';

  @override
  String get linkCopied => 'Link kopiert!';

  @override
  String get copy => 'Kopieren';

  @override
  String get qrCode => 'QR-Code';

  @override
  String get groupNameLabel => 'Gruppenname';

  @override
  String get groupNameHint => 'Gruppenname eingeben';

  @override
  String get groupNameEmpty => 'Gruppenname darf nicht leer sein';

  @override
  String dailyGoalHours(int hours) {
    return 'Tagesziel: $hours Stunden';
  }

  @override
  String get addMember => 'Mitglied hinzufügen';

  @override
  String selectedCount(int count) {
    return '$count ausgewählt';
  }

  @override
  String get create => 'Erstellen';

  @override
  String groupCreated(String name) {
    return '$name erstellt!';
  }

  @override
  String invitedCount(int count) {
    return '$count Personen eingeladen';
  }

  @override
  String get screenTimeLower => 'Bildschirmzeit';

  @override
  String get improvedFromLastWeek => '12 % besser als letzte Woche';

  @override
  String get o2Earned => 'O₂ verdient';

  @override
  String get friendRank => 'Freundes-Rang';

  @override
  String cityRankLabel(String city) {
    return '$city Rang';
  }

  @override
  String get mostUsed => 'Am meisten genutzt';

  @override
  String get offGridClub => 'Off-Grid Club';

  @override
  String get clubSubtitle => 'Digitale Balance erreichen und belohnt werden.';

  @override
  String get planStarter => 'Starter';

  @override
  String get planStarterSubtitle => 'Fang mit den Grundlagen an';

  @override
  String get currentPlanBtn => 'Aktueller Plan';

  @override
  String get billingMonthly => 'Monatlich';

  @override
  String get billingYearly => 'Jährlich';

  @override
  String get yearlySavings => '33 % Rabatt';

  @override
  String get planComparison => 'Planvergleich';

  @override
  String get breathTechniquesComp => 'Atemtechniken';

  @override
  String get activeDuelsComp => 'Aktive Duelle';

  @override
  String get storyPhoto => 'Story-Foto';

  @override
  String get heatMap => 'Heatmap';

  @override
  String get top10Report => 'Top-10-Bericht';

  @override
  String get exclusiveBadges => 'Exklusive Abzeichen';

  @override
  String get adFree => 'Werbefrei';

  @override
  String get familyPlanComp => 'Familienplan';

  @override
  String get familyReport => 'Familienbericht';

  @override
  String get exclusiveThemes => 'Exklusive Themes';

  @override
  String get prioritySupport => 'Prioritäts-Support';

  @override
  String get billingNote =>
      'Das Abonnement kann jederzeit gekündigt werden.\nZahlung erfolgt über App Store/Google Play.\nDas Abonnement verlängert sich automatisch.';

  @override
  String get restoreSuccess => 'Käufe wiederhergestellt!';

  @override
  String get restoreFailed => 'Keine Käufe zum Wiederherstellen gefunden.';

  @override
  String get packagesLoadFailed =>
      'Pakete konnten nicht geladen werden. Bitte erneut versuchen.';

  @override
  String get themesTitle => 'Themes';

  @override
  String get themeLockedMsg =>
      'Dieses Theme ist Pro+! Einstellungen > Off-Grid Club';

  @override
  String get familyPlanTitle => 'Familienplan';

  @override
  String get familyPlanLocked => 'Digitale Balance gemeinsam';

  @override
  String get familyPlanLockedDesc =>
      'Füge bis zu 5 Familienmitglieder hinzu, setzt gemeinsam Ziele und erhalte wöchentliche Familienberichte.';

  @override
  String get weeklyFamilyReport => 'Wöchentlicher Familienbericht';

  @override
  String get familyRanking => 'Familien-Rangliste';

  @override
  String get totalOffline => 'Gesamt offline';

  @override
  String get average => 'Durchschnitt';

  @override
  String get best => 'Beste';

  @override
  String offlineTime(int h, int m) {
    return '${h}Std ${m}Min offline';
  }

  @override
  String get enterName => 'Namen eingeben';

  @override
  String get cannotUndo => 'Diese Aktion kann nicht rückgängig gemacht werden!';

  @override
  String get deleteWarningDesc =>
      'Wenn du dein Konto löschst, werden folgende Daten dauerhaft gelöscht:';

  @override
  String get deleteItem1 => 'Profilinformationen und Avatar';

  @override
  String get deleteItem2 => 'Alle Bildschirmzeit-Statistiken';

  @override
  String get deleteItem3 => 'Freundesliste und Duelle';

  @override
  String get deleteItem4 => 'Storys und Kommentare';

  @override
  String get deleteItem5 => 'O₂-Punkte und Beute';

  @override
  String get deleteItem6 => 'Abonnementverlauf';

  @override
  String get deleteSubscriptionNote =>
      'Wenn du ein aktives Abonnement hast, musst du es zuerst über den Apple App Store oder Google Play Store kündigen.';

  @override
  String get deleteConfirmCheck =>
      'Ich verstehe, dass mein Konto und alle Daten dauerhaft gelöscht werden.';

  @override
  String get deleteAccountBtn => 'Mein Konto dauerhaft löschen';

  @override
  String get deleteErrorMsg =>
      'Ein Fehler ist aufgetreten. Bitte erneut versuchen.';

  @override
  String get emailHint => 'E-Mail';

  @override
  String get passwordHint => 'Passwort';

  @override
  String get forgotPassword => 'Passwort vergessen';

  @override
  String get passwordResetSent =>
      'E-Mail zum Zurücksetzen des Passworts wurde gesendet.';

  @override
  String get signUp => 'Registrieren';

  @override
  String get signIn => 'Anmelden';

  @override
  String get orDivider => 'oder';

  @override
  String get continueWithGoogleShort => 'Mit Google fortfahren';

  @override
  String get continueWithAppleShort => 'Mit Apple fortfahren';

  @override
  String get noAccountYet => 'Noch kein Konto? ';

  @override
  String get adminExistingPoints => 'Vorhandene Punkte';

  @override
  String get adminSearchPlace => 'Ort suchen...';

  @override
  String get adminRewardTitle => 'Belohnungstitel (z.B. Gratiskaffee)';

  @override
  String get adminO2Cost => 'O₂-Kosten';

  @override
  String get adminSave => 'Speichern';

  @override
  String get adminSaved => 'Gespeichert!';

  @override
  String get adminDeleteTitle => 'Löschen';

  @override
  String get adminDeleteMsg => 'Möchtest du diesen Punkt wirklich löschen?';

  @override
  String adminDeleteError(String error) {
    return 'Löschfehler: $error';
  }

  @override
  String get adminFillFields => 'Belohnung und O₂-Kosten ausfüllen';

  @override
  String breathCount(int count) {
    return '$count Atemzüge';
  }

  @override
  String minutesRemaining(int count) {
    return 'Noch ${count}Min';
  }

  @override
  String focusMinutes(int count) {
    return 'Du hast dich $count Minuten fokussiert';
  }

  @override
  String get o2TimeRestriction => 'O₂ nur zwischen 08:00 und 00:00 verdienbar';

  @override
  String get breathTechniqueProMsg =>
      'Diese Technik ist Pro! Einstellungen > Off-Grid Club';

  @override
  String get inhale => 'Ein';

  @override
  String get holdBreath => 'Halten';

  @override
  String get exhale => 'Aus';

  @override
  String get waitBreath => 'Warten';

  @override
  String get proMostPopular => 'Am beliebtesten';

  @override
  String get proFamilyBadge => 'FAMILIE';

  @override
  String get comparedToLastWeek => 'im Vergleich zur letzten Woche';

  @override
  String get appBlockTitle => 'App-Sperre';

  @override
  String get appBlockSchedule => 'Zeitplan';

  @override
  String get appBlockEnableBlocking => 'Sperre aktivieren';

  @override
  String get appBlockActive => 'Sperre ist aktiv';

  @override
  String get appBlockInactive => 'Sperre ist deaktiviert';

  @override
  String get appBlockStrictMode => 'Strenger Modus';

  @override
  String get appBlockStrictDesc =>
      'Kann nicht deaktiviert werden, bis der Timer abläuft';

  @override
  String get appBlockStrictExpired => 'Timer abgelaufen';

  @override
  String get appBlockStrictDurationTitle => 'Dauer des strengen Modus';

  @override
  String get appBlockDuration30m => '30 Minuten';

  @override
  String get appBlockDuration1h => '1 Stunde';

  @override
  String get appBlockDuration2h => '2 Stunden';

  @override
  String get appBlockDuration4h => '4 Stunden';

  @override
  String get appBlockDurationAllDay => 'Ganzer Tag (24 Stunden)';

  @override
  String get appBlockScheduleTitle => 'Sperrzeitplan';

  @override
  String get appBlockScheduleDesc => 'Tägliche Zeiträume festlegen';

  @override
  String get appBlockBlockedApps => 'Gesperrte Apps';

  @override
  String get appBlockNoApps => 'Noch keine Apps hinzugefügt';

  @override
  String get appBlockAddApp => 'App hinzufügen';

  @override
  String get appBlockPickerTitle => 'App auswählen';

  @override
  String get appBlockPresetWork => 'Arbeitszeit (09-18)';

  @override
  String get appBlockPresetSleep => 'Schlafenszeit (23-07)';

  @override
  String get appBlockPresetAllDay => 'Ganzer Tag';

  @override
  String get appBlockInterventionTitle => 'Moment mal...';

  @override
  String get appBlockInterventionSubtitle =>
      'Atme durch und beobachte dich selbst';

  @override
  String get appBlockInterventionGiveUp => 'Ich verzichte';

  @override
  String get appBlockInterventionOpenAnyway => 'Trotzdem öffnen';

  @override
  String get appBlockStrictModeActive =>
      'Strenger Modus — Öffnen nicht möglich';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return 'Du hast diese Woche $hours Stunden mit $app verbracht';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return 'Du hast diesen Monat $count Mal verzichtet';
  }

  @override
  String get pickAppToBan => 'App zum Sperren auswählen';

  @override
  String get pickAppToBanDesc =>
      'Dein Gegner kann diese App 24 Stunden nicht öffnen';

  @override
  String get pickCategory => 'Kategorie wählen';

  @override
  String get pickCategoryDesc => 'Nur die Nutzung in dieser Kategorie zählt';

  @override
  String get rollDiceForTarget => 'Würfle für dein Ziel';

  @override
  String get rollDiceDesc => 'Würfelwert × 30 Minuten = Zieldauer';

  @override
  String get diceTapToRoll => 'Zum Würfeln tippen';

  @override
  String get diceRolling => 'Würfelt...';

  @override
  String diceResult(int value) {
    return 'Ergebnis: $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return 'Zieldauer: $minutes Min.';
  }

  @override
  String get chooseTeammates => 'Teammitglieder wählen';

  @override
  String teammatesSelected(int count) {
    return '$count/3 ausgewählt  ·  Wähle 2 oder 3 Teammitglieder';
  }

  @override
  String get nightDuelInfo => 'Nachtduell';

  @override
  String get nightDuelRange => '23:00 — 07:00';

  @override
  String get nightDuelBody =>
      'Schlafe, ohne dein Telefon zu berühren. Wer länger durchhält, gewinnt. Feste 8 Stunden.';

  @override
  String get nightDuelAutoStart =>
      'Dieses Duell startet automatisch um 23:00 Uhr.';

  @override
  String get mysteryMissionTitle => 'Geheime Mission';

  @override
  String get mysteryMissionSubtitle =>
      'Deine Mission wird beim Duellstart enthüllt';

  @override
  String get mysteryMissionBody =>
      'Wenn du das Duell startest, wird eine zufällige Mission ausgewählt.';

  @override
  String get mysteryStart => 'Mission starten';

  @override
  String opponentWantsToBanApp(String app) {
    return 'Dein Gegner möchte, dass du $app sperrst';
  }

  @override
  String opponentWantsCategory(String category) {
    return 'Dein Gegner möchte in der Kategorie $category antreten';
  }

  @override
  String get proposeDifferentApp =>
      'Ich habe diese App nicht, schlage eine andere vor';

  @override
  String get proposeDifferentCategory =>
      'Ich nutze diese Kategorie nicht, schlage eine andere vor';

  @override
  String get acceptInvite => 'Annehmen';

  @override
  String proposalSent(String value) {
    return 'Vorschlag gesendet: $value';
  }

  @override
  String get stepAppPicker => 'App wählen';

  @override
  String get stepCategoryPicker => 'Kategorie wählen';

  @override
  String get stepDice => 'Würfeln';

  @override
  String get stepNightInfo => 'Nachtduell';

  @override
  String get stepMystery => 'Geheime Mission';

  @override
  String get stepTeamPicker => 'Teammitglieder wählen';
}
