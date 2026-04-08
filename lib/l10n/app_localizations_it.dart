// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan => 'Stacca la spina. Gioca. Non perderti nel digitale.';

  @override
  String get home => 'Home';

  @override
  String get ranking => 'Classifica';

  @override
  String get duel => 'Duello';

  @override
  String get profile => 'Profilo';

  @override
  String get settings => 'Impostazioni';

  @override
  String get stories => 'Storie';

  @override
  String get today => 'Oggi';

  @override
  String get thisWeek => 'Questa settimana';

  @override
  String get friends => 'Amici';

  @override
  String get friendsOf => 'Amici di';

  @override
  String get allFriends => 'Tutti';

  @override
  String get city => 'Città';

  @override
  String get country => 'Paese';

  @override
  String get global => 'Globale';

  @override
  String minutes(int count) {
    return '$count min';
  }

  @override
  String hours(int count) {
    return '$count h';
  }

  @override
  String hoursMinutes(int h, int m) {
    return '${h}h ${m}m';
  }

  @override
  String get screenTime => 'Tempo schermo';

  @override
  String get phonePickups => 'Volte che hai preso il telefono';

  @override
  String pickupsToday(int count) {
    return 'Hai preso il telefono $count volte oggi';
  }

  @override
  String get topTriggers => 'Principali trigger';

  @override
  String get longestOffScreen => 'Più lungo tempo offline';

  @override
  String get dailyGoal => 'Obiettivo giornaliero';

  @override
  String goalHours(int count) {
    return 'Obiettivo: $count ore';
  }

  @override
  String get streak => 'Serie';

  @override
  String streakDays(int count) {
    return '$count giorni';
  }

  @override
  String get level => 'Livello';

  @override
  String get badges => 'Badge';

  @override
  String get duels => 'Duelli';

  @override
  String get activeDuels => 'Attivi';

  @override
  String get pastDuels => 'Passati';

  @override
  String get createDuel => 'Crea duello';

  @override
  String get startDuel => 'Inizia duello';

  @override
  String get invite => 'Invita';

  @override
  String get accept => 'Accetta';

  @override
  String get decline => 'Rifiuta';

  @override
  String get win => 'Vinto';

  @override
  String get lose => 'Perso';

  @override
  String get draw => 'Pareggio';

  @override
  String get addFriend => 'Aggiungi amico';

  @override
  String get friendCode => 'Codice amico';

  @override
  String get search => 'Cerca';

  @override
  String get notifications => 'Notifiche';

  @override
  String get dailyReminder => 'Promemoria giornaliero';

  @override
  String get duelNotifications => 'Notifiche duello';

  @override
  String get locationSharing => 'Condivisione posizione';

  @override
  String get subscription => 'Abbonamento';

  @override
  String get free => 'Gratuito';

  @override
  String get pro => 'Pro';

  @override
  String get proPlus => 'Pro+';

  @override
  String get currentPlan => 'Piano attuale';

  @override
  String get recommended => 'Consigliato';

  @override
  String get start => 'Inizia';

  @override
  String get upgradeToPro => 'Passa a Pro';

  @override
  String get upgradeToProPlus => 'Passa a Pro+';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String monthlyPrice(String price) {
    return '$price/mese';
  }

  @override
  String get freeFeature1 => 'Monitoraggio giornaliero del tempo schermo';

  @override
  String get freeFeature2 => 'Classifiche amici';

  @override
  String get freeFeature3 => '3 duelli attivi';

  @override
  String get freeFeature4 => 'Badge base';

  @override
  String get proFeature1 => 'Tutte le classifiche (città, paese, globale)';

  @override
  String get proFeature2 => 'Statistiche dettagliate e calendario focus';

  @override
  String get proFeature3 => 'Duelli illimitati';

  @override
  String get proFeature4 => 'Pass Off-Grid inclusi';

  @override
  String get proFeature5 => 'Esperienza senza pubblicità';

  @override
  String get proPlusFeature1 => 'Tutto di Pro';

  @override
  String get proPlusFeature2 => 'Piano famiglia (5 persone)';

  @override
  String get proPlusFeature3 => 'Supporto prioritario';

  @override
  String get proPlusFeature4 => 'Badge e temi esclusivi';

  @override
  String get proPlusFeature5 => 'Accesso anticipato alle funzioni beta';

  @override
  String get paywallTitle => 'Club Off-Grid';

  @override
  String get paywallSubtitle => 'Vieni premiato per esserti disconnesso.';

  @override
  String get logout => 'Esci';

  @override
  String get shareProfile => 'Condividi profilo';

  @override
  String get shareReportCard => 'Mostra il tuo record';

  @override
  String get appUsage => 'Utilizzo app';

  @override
  String get whatDidYouUse => 'Cosa hai usato oggi?';

  @override
  String get weeklyReport => 'Report settimanale';

  @override
  String get weeklyTrend => 'Andamento 7 giorni';

  @override
  String get seasons => 'Stagioni';

  @override
  String get seasonPass => 'Pass Off-Grid';

  @override
  String get groups => 'Gruppi';

  @override
  String get createGroup => 'Crea gruppo';

  @override
  String get stats => 'Statistiche';

  @override
  String get analytics => 'Analisi';

  @override
  String get detailedAnalytics => 'Analisi dettagliate';

  @override
  String get categories => 'Categorie';

  @override
  String get weeklyUsage => 'Utilizzo settimanale';

  @override
  String get appDetails => 'Dettagli app';

  @override
  String get focusCalendar => 'Calendario focus';

  @override
  String get whatIf => 'E se?';

  @override
  String get focusMode => 'Respira';

  @override
  String get startFocusMode => 'Avvia modalità focus';

  @override
  String get focusing => 'Stai concentrandoti...';

  @override
  String focusComplete(int minutes) {
    return 'Ottimo! Ti sei concentrato per $minutes min';
  }

  @override
  String get focusTimeout => 'Timeout sessione';

  @override
  String get focusTimeoutDesc =>
      'Hai raggiunto il limite di 120 minuti.\nSei ancora lì?';

  @override
  String get end => 'Termina';

  @override
  String get reportCard => 'Pagella';

  @override
  String get antiSocialStory => 'Momento anti-sociale';

  @override
  String get storyQuestion => 'Cosa stai facendo lontano dal telefono?';

  @override
  String get postStory => 'Pubblica';

  @override
  String get storyExpired => 'Scaduta';

  @override
  String get noStories => 'Ancora nessuna storia';

  @override
  String get noStoriesHint =>
      'Che i tuoi amici inizino a condividere i loro momenti off-grid!';

  @override
  String get storyBlocked => 'Non puoi condividere una storia';

  @override
  String get storyBlockedHint =>
      'Hai superato il tuo obiettivo giornaliero di tempo schermo. Rispetta il tuo obiettivo per guadagnare il diritto di condividere storie!';

  @override
  String get duration => 'Durata';

  @override
  String get walk => 'Camminata';

  @override
  String get run => 'Corsa';

  @override
  String get book => 'Libro';

  @override
  String get meditation => 'Meditazione';

  @override
  String get nature => 'Natura';

  @override
  String get sports => 'Sport';

  @override
  String get music => 'Musica';

  @override
  String get cooking => 'Cucina';

  @override
  String get friendsActivity => 'Amici';

  @override
  String get family => 'Famiglia';

  @override
  String get o2Balance => 'Punti O₂';

  @override
  String o2Remaining(int count) {
    return 'Rimanenti: $count';
  }

  @override
  String o2Today(int earned, int max) {
    return 'Oggi: $earned/$max O₂';
  }

  @override
  String get o2Rules => 'Regole O₂';

  @override
  String get o2RuleTime => 'Guadagnabili solo tra le 08:00 e le 00:00';

  @override
  String get o2RuleDaily => 'Max 500 O₂ al giorno';

  @override
  String get o2RuleFocus => 'Modalità focus max 120 min';

  @override
  String get o2RuleTransfer => 'Nessun trasferimento o scommessa';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂ (stimato)';
  }

  @override
  String get offGridMarket => 'Bottino';

  @override
  String get offGridMarketHint => 'Converti i punti O₂ in premi reali';

  @override
  String get redeem => 'Riscatta';

  @override
  String get insufficient => 'Insufficiente';

  @override
  String get redeemSuccess => 'Congratulazioni!';

  @override
  String get couponCode => 'Il tuo codice coupon:';

  @override
  String get recentTransactions => 'Transazioni recenti';

  @override
  String get noTransactions => 'Ancora nessuna transazione';

  @override
  String get categorySocial => 'Social';

  @override
  String get categoryGame => 'Giochi';

  @override
  String get categoryVideo => 'Video';

  @override
  String get categoryAudio => 'Musica';

  @override
  String get categoryProductivity => 'Produttività';

  @override
  String get categoryNews => 'Notizie';

  @override
  String get categoryGames => 'Giochi';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryBrowser => 'Browser';

  @override
  String get categoryMaps => 'Mappe';

  @override
  String get categoryImage => 'Foto';

  @override
  String get categoryOther => 'Altro';

  @override
  String hello(String name) {
    return 'Ciao, $name';
  }

  @override
  String get goalCompleted => 'Obiettivo raggiunto!';

  @override
  String get dailyGoalShort => 'Obiettivo giornaliero';

  @override
  String get streakDaysLabel => 'giorni di fila';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => 'classifica';

  @override
  String get offlineLabel => 'offline';

  @override
  String get todaysApps => 'App di oggi';

  @override
  String get seeAll => 'Vedi tutto';

  @override
  String get activeDuel => 'Duello attivo';

  @override
  String get startDuelPrompt => 'Inizia un duello!';

  @override
  String get you => 'Tu';

  @override
  String moreCount(int count) {
    return '+$count altri';
  }

  @override
  String get removeWithPro => 'Rimuovi con Pro';

  @override
  String get adLabel => 'Pub';

  @override
  String get focus => 'Focus';

  @override
  String get legal => 'Note legali';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get termsOfService => 'Termini di servizio';

  @override
  String get kvkkText => 'Informativa sulla privacy KVKK';

  @override
  String get deleteMyAccount => 'Elimina il mio account';

  @override
  String get edit => 'Modifica';

  @override
  String get adminAddLoot => 'Admin: Aggiungi bottino';

  @override
  String get continueConsent => 'Continuando';

  @override
  String get acceptTermsSuffix => 'accetti.';

  @override
  String get alreadyHaveAccount => 'Ho già un account';

  @override
  String get screenTimePermissionTitle =>
      'Dobbiamo monitorare il tuo tempo schermo';

  @override
  String get screenTimePermissionDesc =>
      'L\'accesso al tempo schermo è necessario per vedere quanto tempo trascorri su ogni app.';

  @override
  String get screenTimeGranted => 'Autorizzazione tempo schermo concessa!';

  @override
  String get continueButton => 'Continua';

  @override
  String get skip => 'Salta';

  @override
  String get yourName => 'Il tuo nome';

  @override
  String get nameHint => 'Inserisci il tuo nome';

  @override
  String get ageGroup => 'Fascia d\'età';

  @override
  String get imReady => 'Sono pronto';

  @override
  String get dailyGoalTitle => 'Il tuo obiettivo giornaliero';

  @override
  String get goalQuestion =>
      'Quante ore di tempo schermo vuoi avere al giorno?';

  @override
  String get goalMotivational1 =>
      'Fantastico! Un vero obiettivo di digital detox 💪';

  @override
  String get goalMotivational2 => 'Un obiettivo equilibrato, ce la fai! 🎯';

  @override
  String get goalMotivational3 => 'Un buon inizio, puoi ridurre nel tempo 📉';

  @override
  String get goalMotivational4 => 'Passo dopo passo, ogni minuto conta ⭐';

  @override
  String get next => 'Avanti';

  @override
  String hourShort(int count) {
    return '${count}h';
  }

  @override
  String get welcomeSlogan =>
      'Posa il telefono. Supera i tuoi amici.\nSii #1 nella tua città.';

  @override
  String get deleteAccount => 'Elimina account';

  @override
  String get deleteAccountConfirm =>
      'Il tuo account e tutti i dati verranno eliminati definitivamente. Questa azione non può essere annullata.';

  @override
  String get cancel => 'Annulla';

  @override
  String get confirm => 'Conferma';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Errore';

  @override
  String get tryAgain => 'Riprova';

  @override
  String get loading => 'Caricamento...';

  @override
  String get loadFailed => 'Caricamento fallito';

  @override
  String get noDataYet => 'Ancora nessun dato';

  @override
  String get welcome => 'Benvenuto';

  @override
  String get welcomeSubtitle => 'Posa il telefono. Supera i tuoi amici.';

  @override
  String get continueWithGoogle => 'Continua con Google';

  @override
  String get continueWithApple => 'Continua con Apple';

  @override
  String get continueWithEmail => 'Continua con email';

  @override
  String get permissionsTitle => 'Autorizzazioni';

  @override
  String get permissionsSubtitle =>
      'Abbiamo bisogno del permesso per monitorare il tuo tempo schermo.';

  @override
  String get grantPermission => 'Concedi autorizzazione';

  @override
  String get setupProfile => 'Configura profilo';

  @override
  String get displayName => 'Nome visualizzato';

  @override
  String get selectCity => 'Seleziona città';

  @override
  String get selectGoal => 'Seleziona obiettivo giornaliero';

  @override
  String get noDuelsYet => 'Ancora nessun duello';

  @override
  String get noDuelsYetSubtitle => 'Inizia il tuo primo duello!';

  @override
  String get activeDuelsTitle => 'Duelli attivi';

  @override
  String get newDuel => 'Nuovo duello';

  @override
  String get selectDuelType => 'Seleziona tipo di duello';

  @override
  String get selectDurationStep => 'Seleziona durata';

  @override
  String get selectOpponent => 'Seleziona avversario';

  @override
  String get duelStartButton => 'Inizia duello! ⚔️';

  @override
  String get freePlanDuelLimit =>
      'Il piano gratuito consente max 3 duelli attivi! Passa a Pro.';

  @override
  String get quickSelect => 'Selezione rapida';

  @override
  String get customDuration => 'Durata personalizzata';

  @override
  String selectedDuration(String duration) {
    return 'Selezionato: $duration';
  }

  @override
  String get minDurationWarning => 'Devi selezionare almeno 10 minuti';

  @override
  String get selectPenalty => 'Seleziona penalità (opzionale)';

  @override
  String get searchFriend => 'Cerca amico...';

  @override
  String get inviteWithLink => 'Invita con link 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '${count}min oggi';
  }

  @override
  String duelRemaining(int h, int m) {
    return '${h}h ${m}m rimasti';
  }

  @override
  String get remainingTime => 'Tempo rimanente';

  @override
  String watchersCount(int count) {
    return '$count spettatori 👀';
  }

  @override
  String get giveUp => 'Arrendersi';

  @override
  String get duelWon => 'Hai vinto! 🎉';

  @override
  String get duelLost => 'Hai perso 😔';

  @override
  String get greatPerformance => 'Ottima prestazione!';

  @override
  String get betterNextTime => 'Meglio la prossima volta!';

  @override
  String get revenge => 'Rivincita 🔥';

  @override
  String get share => 'Condividi';

  @override
  String get selectFriend => 'Seleziona amico';

  @override
  String get orSendLink => 'o invia link';

  @override
  String get social => 'Social';

  @override
  String get myFriends => 'I miei amici';

  @override
  String get inMyCity => 'Nella mia città';

  @override
  String get shareFirstStory =>
      'Sii il primo a condividere il tuo momento off-grid!';

  @override
  String get createStoryTitle => 'Condividi storia';

  @override
  String get addPhoto => 'Aggiungi foto';

  @override
  String get whatAreYouDoing => 'Cosa stai facendo?';

  @override
  String get captionHint => 'Cosa stai facendo lontano dal telefono?';

  @override
  String get howLongVisible => 'Per quanto tempo dovrebbe essere visibile?';

  @override
  String get whoCanSee => 'Chi può vederla?';

  @override
  String get onlyFriends => 'Solo i miei amici';

  @override
  String get cityPeople => 'Persone nella mia città';

  @override
  String get photoStoriesPro =>
      'Le storie con foto sono Pro! Impostazioni > Club Off-Grid';

  @override
  String get camera => 'Fotocamera';

  @override
  String get gallery => 'Galleria';

  @override
  String get writeFirst => 'Scrivi prima qualcosa!';

  @override
  String get inappropriateContent => 'Contenuto inappropriato rilevato';

  @override
  String viewsCount(int count) {
    return '$count visualizzazioni';
  }

  @override
  String get editProfile => 'Modifica profilo';

  @override
  String get changePhoto => 'Cambia foto';

  @override
  String get firstName => 'Nome';

  @override
  String get firstNameHint => 'Il tuo nome';

  @override
  String get lastName => 'Cognome';

  @override
  String get lastNameHint => 'Il tuo cognome';

  @override
  String get usernameLabel => 'Nome utente';

  @override
  String get updateLocation => 'Aggiorna posizione';

  @override
  String get locationUnknown => 'Sconosciuta';

  @override
  String get save => 'Salva';

  @override
  String get usernameAvailable => 'Disponibile';

  @override
  String get usernameTaken => 'Questo nome utente è già preso';

  @override
  String get usernameFormatError =>
      'Almeno 3 caratteri, solo lettere, numeri e _';

  @override
  String get profileUpdated => 'Profilo aggiornato';

  @override
  String get photoSelectedDemo =>
      'Foto selezionata (non verrà caricata in modalità demo)';

  @override
  String get locationError => 'Impossibile ottenere la posizione';

  @override
  String get errorOccurred => 'Si è verificato un errore';

  @override
  String get detailedScreenTime => 'Tempo schermo dettagliato';

  @override
  String get monthlyTop10 => 'Top 10 mensile';

  @override
  String get searchHint => 'Cerca...';

  @override
  String get noFriendsYet => 'Ancora nessun amico';

  @override
  String get noFriendsHint => 'Inizia aggiungendo un amico';

  @override
  String get showQrCode => 'Mostra il tuo codice QR';

  @override
  String get enterCode => 'Inserisci codice';

  @override
  String get inviteLinkShare => 'Condividi link d\'invito';

  @override
  String get startDuelAction => 'Inizia duello';

  @override
  String get pointsLabel => 'Punti';

  @override
  String get mostUsedLabel => 'Più usata:';

  @override
  String get recentBadges => 'Badge recenti';

  @override
  String get allBadgesLabel => 'Tutti i badge';

  @override
  String get removeFriend => 'Rimuovi amico';

  @override
  String get removeFriendConfirm =>
      'Sei sicuro di voler rimuovere questa persona dalla tua lista amici?';

  @override
  String get remove => 'Rimuovi';

  @override
  String get requestSent => 'Richiesta inviata';

  @override
  String get whatCouldYouDo => 'Cosa avresti potuto fare?';

  @override
  String get back => 'Indietro';

  @override
  String get weekly => 'Settimanale';

  @override
  String get daily => 'Giornaliero';

  @override
  String get mostUsedApps => 'App più usate';

  @override
  String get unlockSection => 'Sblocchi';

  @override
  String get selectedDayLabel => 'Giorno selezionato';

  @override
  String get todayLabel => 'Oggi';

  @override
  String weeklyAvgLabel(int h, int m) {
    return 'Media giornaliera: ${h}h ${m}m';
  }

  @override
  String get firstUnlock => 'Primo sblocco';

  @override
  String get mostOpened => 'Più aperta';

  @override
  String get timesPickedUp => 'Volte preso in mano';

  @override
  String get openingCount => 'aperture';

  @override
  String get notificationUnit => 'notifiche';

  @override
  String get timesUnit => 'volte';

  @override
  String get turkey => 'Türkiye';

  @override
  String get consecutiveDays => 'giorni di fila';

  @override
  String bestStreakLabel(int days) {
    return 'Record: $days giorni';
  }

  @override
  String get seriFriends => 'Amici';

  @override
  String get oxygenTitle => 'Ossigeno (O₂)';

  @override
  String get totalO2 => 'Totale';

  @override
  String get remainingShort => 'Rimanenti';

  @override
  String get noOffersYet => 'Ancora nessuna offerta';

  @override
  String o2SpentMsg(int amount) {
    return '$amount O₂ spesi';
  }

  @override
  String get mapLoadFailed => 'Caricamento mappa fallito';

  @override
  String confirmRedeemMsg(String reward) {
    return 'Vuoi riscattare $reward?';
  }

  @override
  String itemReceived(String item) {
    return '$item riscattato!';
  }

  @override
  String get insufficientO2 => 'O₂ insufficienti';

  @override
  String get season1Title => 'Stagione 1';

  @override
  String get season1Subtitle => 'Risveglio primaverile';

  @override
  String get seasonPassBtn => 'Season Pass (99TL)';

  @override
  String get seasonPassLabel => 'Season Pass';

  @override
  String get noGroupsYet => 'Ancora nessun gruppo';

  @override
  String get noGroupsSubtitle => 'Crea un gruppo con i tuoi amici';

  @override
  String get newGroup => 'Nuovo gruppo';

  @override
  String memberCount(int count) {
    return '$count membri';
  }

  @override
  String get weeklyGoal => 'Obiettivo settimanale';

  @override
  String challengeProgress(int percent) {
    return '$percent% completato';
  }

  @override
  String get membersLabel => 'Membri';

  @override
  String get inviteLink => 'Link d\'invito';

  @override
  String get linkCopied => 'Link copiato!';

  @override
  String get copy => 'Copia';

  @override
  String get qrCode => 'Codice QR';

  @override
  String get groupNameLabel => 'Nome del gruppo';

  @override
  String get groupNameHint => 'Inserisci il nome del gruppo';

  @override
  String get groupNameEmpty => 'Il nome del gruppo non può essere vuoto';

  @override
  String dailyGoalHours(int hours) {
    return 'Obiettivo giornaliero: $hours ore';
  }

  @override
  String get addMember => 'Aggiungi membro';

  @override
  String selectedCount(int count) {
    return '$count selezionati';
  }

  @override
  String get create => 'Crea';

  @override
  String groupCreated(String name) {
    return '$name creato!';
  }

  @override
  String invitedCount(int count) {
    return '$count persone invitate';
  }

  @override
  String get screenTimeLower => 'tempo schermo';

  @override
  String get improvedFromLastWeek => '12% meglio della settimana scorsa';

  @override
  String get o2Earned => 'O₂ guadagnati';

  @override
  String get friendRank => 'Classifica amici';

  @override
  String cityRankLabel(String city) {
    return 'Classifica $city';
  }

  @override
  String get mostUsed => 'Più usata';

  @override
  String get offGridClub => 'Club Off-Grid';

  @override
  String get clubSubtitle =>
      'Raggiungi l\'equilibrio digitale, vieni premiato.';

  @override
  String get planStarter => 'Starter';

  @override
  String get planStarterSubtitle => 'Inizia con le funzioni base';

  @override
  String get currentPlanBtn => 'Piano attuale';

  @override
  String get billingMonthly => 'Mensile';

  @override
  String get billingYearly => 'Annuale';

  @override
  String get yearlySavings => '33% di sconto';

  @override
  String get planComparison => 'Confronto piani';

  @override
  String get breathTechniquesComp => 'Tecniche di respirazione';

  @override
  String get activeDuelsComp => 'Duelli attivi';

  @override
  String get storyPhoto => 'Foto storia';

  @override
  String get heatMap => 'Mappa di calore';

  @override
  String get top10Report => 'Report top 10';

  @override
  String get exclusiveBadges => 'Badge esclusivi';

  @override
  String get adFree => 'Senza pubblicità';

  @override
  String get familyPlanComp => 'Piano famiglia';

  @override
  String get familyReport => 'Report famiglia';

  @override
  String get exclusiveThemes => 'Temi esclusivi';

  @override
  String get prioritySupport => 'Supporto prioritario';

  @override
  String get billingNote =>
      'L\'abbonamento può essere annullato in qualsiasi momento.\nPagamento elaborato tramite App Store/Google Play.\nL\'abbonamento si rinnova automaticamente alla fine del periodo.';

  @override
  String get restoreSuccess => 'Acquisti ripristinati!';

  @override
  String get restoreFailed => 'Nessun acquisto da ripristinare.';

  @override
  String get packagesLoadFailed => 'Caricamento pacchetti fallito. Riprova.';

  @override
  String get themesTitle => 'Temi';

  @override
  String get themeLockedMsg =>
      'Questo tema è Pro+! Impostazioni > Club Off-Grid';

  @override
  String get familyPlanTitle => 'Piano famiglia';

  @override
  String get familyPlanLocked => 'Equilibrio digitale insieme';

  @override
  String get familyPlanLockedDesc =>
      'Aggiungi fino a 5 familiari, imposta obiettivi insieme e ricevi report settimanali di famiglia.';

  @override
  String get weeklyFamilyReport => 'Report settimanale famiglia';

  @override
  String get familyRanking => 'Classifica famiglia';

  @override
  String get totalOffline => 'Totale offline';

  @override
  String get average => 'Media';

  @override
  String get best => 'Migliore';

  @override
  String offlineTime(int h, int m) {
    return '${h}h ${m}m offline';
  }

  @override
  String get enterName => 'Inserisci nome';

  @override
  String get cannotUndo => 'Questa azione non può essere annullata!';

  @override
  String get deleteWarningDesc =>
      'Quando elimini il tuo account, i seguenti dati verranno eliminati definitivamente:';

  @override
  String get deleteItem1 => 'Info profilo e avatar';

  @override
  String get deleteItem2 => 'Tutte le statistiche del tempo schermo';

  @override
  String get deleteItem3 => 'Lista amici e duelli';

  @override
  String get deleteItem4 => 'Storie e commenti';

  @override
  String get deleteItem5 => 'Punti O₂ e bottino';

  @override
  String get deleteItem6 => 'Cronologia abbonamento';

  @override
  String get deleteSubscriptionNote =>
      'Se hai un abbonamento attivo, devi prima annullarlo tramite Apple App Store o Google Play Store.';

  @override
  String get deleteConfirmCheck =>
      'Capisco che il mio account e tutti i dati verranno eliminati definitivamente.';

  @override
  String get deleteAccountBtn => 'Elimina definitivamente il mio account';

  @override
  String get deleteErrorMsg => 'Si è verificato un errore. Riprova.';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get forgotPassword => 'Password dimenticata';

  @override
  String get passwordResetSent => 'Email di reimpostazione password inviata.';

  @override
  String get signUp => 'Registrati';

  @override
  String get signIn => 'Accedi';

  @override
  String get orDivider => 'oppure';

  @override
  String get continueWithGoogleShort => 'Continua con Google';

  @override
  String get continueWithAppleShort => 'Continua con Apple';

  @override
  String get noAccountYet => 'Non hai ancora un account? ';

  @override
  String get adminExistingPoints => 'Punti esistenti';

  @override
  String get adminSearchPlace => 'Cerca luogo...';

  @override
  String get adminRewardTitle => 'Titolo premio (es. Caffè gratis)';

  @override
  String get adminO2Cost => 'Costo O₂';

  @override
  String get adminSave => 'Salva';

  @override
  String get adminSaved => 'Salvato!';

  @override
  String get adminDeleteTitle => 'Elimina';

  @override
  String get adminDeleteMsg => 'Sei sicuro di voler eliminare questo punto?';

  @override
  String adminDeleteError(String error) {
    return 'Errore di eliminazione: $error';
  }

  @override
  String get adminFillFields => 'Compila il premio e il costo O₂';

  @override
  String breathCount(int count) {
    return '$count respiri';
  }

  @override
  String minutesRemaining(int count) {
    return '${count}min rimasti';
  }

  @override
  String focusMinutes(int count) {
    return 'Ti sei concentrato per $count minuti';
  }

  @override
  String get o2TimeRestriction =>
      'O₂ guadagnabili solo tra le 08:00 e le 00:00';

  @override
  String get breathTechniqueProMsg =>
      'Questa tecnica è Pro! Impostazioni > Club Off-Grid';

  @override
  String get inhale => 'Inspira';

  @override
  String get holdBreath => 'Tieni';

  @override
  String get exhale => 'Espira';

  @override
  String get waitBreath => 'Aspetta';

  @override
  String get proMostPopular => 'Più popolare';

  @override
  String get proFamilyBadge => 'FAMIGLIA';

  @override
  String get comparedToLastWeek => 'rispetto alla settimana scorsa';

  @override
  String get appBlockTitle => 'Blocco app';

  @override
  String get appBlockSchedule => 'Programmazione';

  @override
  String get appBlockEnableBlocking => 'Attiva blocco';

  @override
  String get appBlockActive => 'Il blocco è attivo';

  @override
  String get appBlockInactive => 'Il blocco è disattivato';

  @override
  String get appBlockStrictMode => 'Modalità rigorosa';

  @override
  String get appBlockStrictDesc =>
      'Non può essere disattivato fino allo scadere del timer';

  @override
  String get appBlockStrictExpired => 'Timer scaduto';

  @override
  String get appBlockStrictDurationTitle => 'Durata modalità rigorosa';

  @override
  String get appBlockDuration30m => '30 minuti';

  @override
  String get appBlockDuration1h => '1 ora';

  @override
  String get appBlockDuration2h => '2 ore';

  @override
  String get appBlockDuration4h => '4 ore';

  @override
  String get appBlockDurationAllDay => 'Tutto il giorno (24 ore)';

  @override
  String get appBlockScheduleTitle => 'Programmazione blocco';

  @override
  String get appBlockScheduleDesc => 'Imposta fasce orarie giornaliere';

  @override
  String get appBlockBlockedApps => 'App bloccate';

  @override
  String get appBlockNoApps => 'Nessuna app aggiunta';

  @override
  String get appBlockAddApp => 'Aggiungi app';

  @override
  String get appBlockPickerTitle => 'Scegli app';

  @override
  String get appBlockPresetWork => 'Orario di lavoro (09-18)';

  @override
  String get appBlockPresetSleep => 'Ora di dormire (23-07)';

  @override
  String get appBlockPresetAllDay => 'Tutto il giorno';

  @override
  String get appBlockInterventionTitle => 'Aspetta un attimo...';

  @override
  String get appBlockInterventionSubtitle => 'Fai un respiro e osservati';

  @override
  String get appBlockInterventionGiveUp => 'Lascio perdere';

  @override
  String get appBlockInterventionOpenAnyway => 'Apri comunque';

  @override
  String get appBlockStrictModeActive =>
      'Modalità rigorosa — impossibile aprire';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return 'Hai trascorso $hours ore su $app questa settimana';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return 'Hai rinunciato $count volte questo mese';
  }

  @override
  String get pickAppToBan => 'Scegli app da bandire';

  @override
  String get pickAppToBanDesc =>
      'Il tuo avversario non potrà aprire questa app per 24 ore';

  @override
  String get pickCategory => 'Scegli categoria';

  @override
  String get pickCategoryDesc => 'Conta solo l\'uso in questa categoria';

  @override
  String get rollDiceForTarget => 'Lancia i dadi per il tuo obiettivo';

  @override
  String get rollDiceDesc => 'Valore del dado × 30 minuti = durata obiettivo';

  @override
  String get diceTapToRoll => 'Tocca per lanciare';

  @override
  String get diceRolling => 'Lancio in corso...';

  @override
  String diceResult(int value) {
    return 'Risultato: $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return 'Durata obiettivo: $minutes min';
  }

  @override
  String get chooseTeammates => 'Scegli compagni di squadra';

  @override
  String teammatesSelected(int count) {
    return '$count/3 selezionati  ·  Scegli 2 o 3 compagni';
  }

  @override
  String get nightDuelInfo => 'Duello notturno';

  @override
  String get nightDuelRange => '23:00 — 07:00';

  @override
  String get nightDuelBody =>
      'Dormi senza toccare il telefono. Chi resiste di più vince. 8 ore fisse.';

  @override
  String get nightDuelAutoStart =>
      'Questo duello inizia automaticamente alle 23:00.';

  @override
  String get mysteryMissionTitle => 'Missione misteriosa';

  @override
  String get mysteryMissionSubtitle =>
      'La tua missione viene rivelata all\'inizio del duello';

  @override
  String get mysteryMissionBody =>
      'Quando inizi il duello, viene selezionata una missione casuale.';

  @override
  String get mysteryStart => 'Avvia missione';

  @override
  String opponentWantsToBanApp(String app) {
    return 'Il tuo avversario vuole che tu bandisca $app';
  }

  @override
  String opponentWantsCategory(String category) {
    return 'Il tuo avversario vuole competere nella categoria $category';
  }

  @override
  String get proposeDifferentApp => 'Non ho quell\'app, proponine un\'altra';

  @override
  String get proposeDifferentCategory =>
      'Non uso quella categoria, proponine un\'altra';

  @override
  String get acceptInvite => 'Accetta';

  @override
  String proposalSent(String value) {
    return 'Proposta inviata: $value';
  }

  @override
  String get stepAppPicker => 'Scegli app';

  @override
  String get stepCategoryPicker => 'Scegli categoria';

  @override
  String get stepDice => 'Lancia dadi';

  @override
  String get stepNightInfo => 'Duello notturno';

  @override
  String get stepMystery => 'Missione misteriosa';

  @override
  String get stepTeamPicker => 'Scegli compagni';
}
