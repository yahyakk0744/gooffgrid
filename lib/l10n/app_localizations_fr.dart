// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan =>
      'Déconnecte-toi. Joue. Ne te perds pas dans le numérique.';

  @override
  String get home => 'Accueil';

  @override
  String get ranking => 'Classement';

  @override
  String get duel => 'Duel';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Paramètres';

  @override
  String get stories => 'Stories';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get friends => 'Amis';

  @override
  String get friendsOf => 'Amis de';

  @override
  String get allFriends => 'Tous';

  @override
  String get city => 'Ville';

  @override
  String get country => 'Pays';

  @override
  String get global => 'Mondial';

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
  String get screenTime => 'Temps d\'écran';

  @override
  String get phonePickups => 'Prises en main';

  @override
  String pickupsToday(int count) {
    return 'Pris en main $count fois aujourd\'hui';
  }

  @override
  String get topTriggers => 'Principaux déclencheurs';

  @override
  String get longestOffScreen => 'Plus longue déconnexion';

  @override
  String get dailyGoal => 'Objectif quotidien';

  @override
  String goalHours(int count) {
    return 'Objectif : $count heures';
  }

  @override
  String get streak => 'Série';

  @override
  String streakDays(int count) {
    return '$count jours';
  }

  @override
  String get level => 'Niveau';

  @override
  String get badges => 'Badges';

  @override
  String get duels => 'Duels';

  @override
  String get activeDuels => 'Actifs';

  @override
  String get pastDuels => 'Passés';

  @override
  String get createDuel => 'Créer un duel';

  @override
  String get startDuel => 'Lancer le duel';

  @override
  String get invite => 'Inviter';

  @override
  String get accept => 'Accepter';

  @override
  String get decline => 'Refuser';

  @override
  String get win => 'Gagné';

  @override
  String get lose => 'Perdu';

  @override
  String get draw => 'Égalité';

  @override
  String get addFriend => 'Ajouter un ami';

  @override
  String get friendCode => 'Code ami';

  @override
  String get search => 'Rechercher';

  @override
  String get notifications => 'Notifications';

  @override
  String get dailyReminder => 'Rappel quotidien';

  @override
  String get duelNotifications => 'Notifications de duel';

  @override
  String get locationSharing => 'Partage de localisation';

  @override
  String get subscription => 'Abonnement';

  @override
  String get free => 'Gratuit';

  @override
  String get pro => 'Pro';

  @override
  String get proPlus => 'Pro+';

  @override
  String get currentPlan => 'Plan actuel';

  @override
  String get recommended => 'Recommandé';

  @override
  String get start => 'Commencer';

  @override
  String get upgradeToPro => 'Passer à Pro';

  @override
  String get upgradeToProPlus => 'Passer à Pro+';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String monthlyPrice(String price) {
    return '$price/mois';
  }

  @override
  String get freeFeature1 => 'Suivi quotidien du temps d\'écran';

  @override
  String get freeFeature2 => 'Classements des amis';

  @override
  String get freeFeature3 => '3 duels actifs';

  @override
  String get freeFeature4 => 'Badges de base';

  @override
  String get proFeature1 => 'Tous les classements (ville, pays, mondial)';

  @override
  String get proFeature2 => 'Statistiques détaillées & calendrier de focus';

  @override
  String get proFeature3 => 'Duels illimités';

  @override
  String get proFeature4 => 'Passes Off-Grid inclus';

  @override
  String get proFeature5 => 'Expérience sans publicité';

  @override
  String get proPlusFeature1 => 'Tout ce qui est dans Pro';

  @override
  String get proPlusFeature2 => 'Plan familial (5 personnes)';

  @override
  String get proPlusFeature3 => 'Support prioritaire';

  @override
  String get proPlusFeature4 => 'Badges & thèmes exclusifs';

  @override
  String get proPlusFeature5 => 'Accès anticipé aux fonctionnalités bêta';

  @override
  String get paywallTitle => 'Club Off-Grid';

  @override
  String get paywallSubtitle => 'Sois récompensé pour avoir décroché.';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get shareProfile => 'Partager le profil';

  @override
  String get shareReportCard => 'Montre ce que tu vaux';

  @override
  String get appUsage => 'Utilisation des apps';

  @override
  String get whatDidYouUse => 'Qu\'as-tu utilisé aujourd\'hui ?';

  @override
  String get weeklyReport => 'Rapport hebdomadaire';

  @override
  String get weeklyTrend => 'Tendance sur 7 jours';

  @override
  String get seasons => 'Saisons';

  @override
  String get seasonPass => 'Passes Off-Grid';

  @override
  String get groups => 'Groupes';

  @override
  String get createGroup => 'Créer un groupe';

  @override
  String get stats => 'Statistiques';

  @override
  String get analytics => 'Analytique';

  @override
  String get detailedAnalytics => 'Analytique détaillée';

  @override
  String get categories => 'Catégories';

  @override
  String get weeklyUsage => 'Utilisation hebdomadaire';

  @override
  String get appDetails => 'Détails de l\'app';

  @override
  String get focusCalendar => 'Calendrier de focus';

  @override
  String get whatIf => 'Et si ?';

  @override
  String get focusMode => 'Respirer';

  @override
  String get startFocusMode => 'Démarrer le mode focus';

  @override
  String get focusing => 'Tu te concentres...';

  @override
  String focusComplete(int minutes) {
    return 'Bravo ! Tu t\'es concentré $minutes min';
  }

  @override
  String get focusTimeout => 'Délai de session dépassé';

  @override
  String get focusTimeoutDesc =>
      'Tu as atteint la limite de 120 minutes.\nToujours là ?';

  @override
  String get end => 'Terminer';

  @override
  String get reportCard => 'Bulletin';

  @override
  String get antiSocialStory => 'Moment anti-social';

  @override
  String get storyQuestion => 'Que fais-tu loin de ton téléphone ?';

  @override
  String get postStory => 'Publier';

  @override
  String get storyExpired => 'Expirée';

  @override
  String get noStories => 'Pas encore de stories';

  @override
  String get noStoriesHint =>
      'Que tes amis commencent à partager leurs moments off-grid !';

  @override
  String get storyBlocked => 'Impossible de partager une story';

  @override
  String get storyBlockedHint =>
      'Tu as dépassé ton objectif quotidien de temps d\'écran. Respecte ton objectif pour gagner le droit de partager des stories !';

  @override
  String get duration => 'Durée';

  @override
  String get walk => 'Marche';

  @override
  String get run => 'Course';

  @override
  String get book => 'Livre';

  @override
  String get meditation => 'Méditation';

  @override
  String get nature => 'Nature';

  @override
  String get sports => 'Sports';

  @override
  String get music => 'Musique';

  @override
  String get cooking => 'Cuisine';

  @override
  String get friendsActivity => 'Amis';

  @override
  String get family => 'Famille';

  @override
  String get o2Balance => 'Points O₂';

  @override
  String o2Remaining(int count) {
    return 'Restant : $count';
  }

  @override
  String o2Today(int earned, int max) {
    return 'Aujourd\'hui : $earned/$max O₂';
  }

  @override
  String get o2Rules => 'Règles O₂';

  @override
  String get o2RuleTime => 'Gagnable uniquement entre 08h00 et 00h00';

  @override
  String get o2RuleDaily => 'Max 500 O₂ par jour';

  @override
  String get o2RuleFocus => 'Mode focus max 120 min';

  @override
  String get o2RuleTransfer => 'Pas de transfert ni de pari';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂ (estimé)';
  }

  @override
  String get offGridMarket => 'Butin';

  @override
  String get offGridMarketHint =>
      'Convertis tes points O₂ en récompenses réelles';

  @override
  String get redeem => 'Échanger';

  @override
  String get insufficient => 'Insuffisant';

  @override
  String get redeemSuccess => 'Félicitations !';

  @override
  String get couponCode => 'Ton code de coupon :';

  @override
  String get recentTransactions => 'Transactions récentes';

  @override
  String get noTransactions => 'Pas encore de transactions';

  @override
  String get categorySocial => 'Réseaux sociaux';

  @override
  String get categoryGame => 'Jeux';

  @override
  String get categoryVideo => 'Vidéo';

  @override
  String get categoryAudio => 'Musique';

  @override
  String get categoryProductivity => 'Productivité';

  @override
  String get categoryNews => 'Actualités';

  @override
  String get categoryGames => 'Jeux';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryBrowser => 'Navigateur';

  @override
  String get categoryMaps => 'Cartes';

  @override
  String get categoryImage => 'Photos';

  @override
  String get categoryOther => 'Autre';

  @override
  String hello(String name) {
    return 'Bonjour, $name';
  }

  @override
  String get goalCompleted => 'Objectif atteint !';

  @override
  String get dailyGoalShort => 'Objectif du jour';

  @override
  String get streakDaysLabel => 'jours d\'affilée';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => 'rang';

  @override
  String get offlineLabel => 'hors ligne';

  @override
  String get todaysApps => 'Apps du jour';

  @override
  String get seeAll => 'Tout voir';

  @override
  String get activeDuel => 'Duel actif';

  @override
  String get startDuelPrompt => 'Lance un duel !';

  @override
  String get you => 'Toi';

  @override
  String moreCount(int count) {
    return '+$count de plus';
  }

  @override
  String get removeWithPro => 'Supprimer avec Pro';

  @override
  String get adLabel => 'Pub';

  @override
  String get focus => 'Focus';

  @override
  String get legal => 'Mentions légales';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get kvkkText => 'Notice de confidentialité RGPD';

  @override
  String get deleteMyAccount => 'Supprimer mon compte';

  @override
  String get edit => 'Modifier';

  @override
  String get adminAddLoot => 'Admin : Ajouter du butin';

  @override
  String get continueConsent => 'En continuant, tu';

  @override
  String get acceptTermsSuffix => 'acceptes.';

  @override
  String get alreadyHaveAccount => 'J\'ai déjà un compte';

  @override
  String get screenTimePermissionTitle =>
      'Nous devons suivre ton temps d\'écran';

  @override
  String get screenTimePermissionDesc =>
      'L\'accès au temps d\'écran est nécessaire pour voir combien de temps tu passes sur chaque app.';

  @override
  String get screenTimeGranted => 'Autorisation de temps d\'écran accordée !';

  @override
  String get continueButton => 'Continuer';

  @override
  String get skip => 'Passer';

  @override
  String get yourName => 'Ton prénom';

  @override
  String get nameHint => 'Saisis ton prénom';

  @override
  String get ageGroup => 'Tranche d\'âge';

  @override
  String get imReady => 'Je suis prêt';

  @override
  String get dailyGoalTitle => 'Ton objectif quotidien';

  @override
  String get goalQuestion =>
      'Combien d\'heures de temps d\'écran vises-tu par jour ?';

  @override
  String get goalMotivational1 =>
      'Incroyable ! Un vrai objectif de détox numérique 💪';

  @override
  String get goalMotivational2 =>
      'Un objectif équilibré, tu peux le faire ! 🎯';

  @override
  String get goalMotivational3 =>
      'Un bon début, tu pourras réduire progressivement 📉';

  @override
  String get goalMotivational4 => 'Pas à pas, chaque minute compte ⭐';

  @override
  String get next => 'Suivant';

  @override
  String hourShort(int count) {
    return '${count}h';
  }

  @override
  String get welcomeSlogan =>
      'Pose ton téléphone. Bats tes amis.\nSois #1 dans ta ville.';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteAccountConfirm =>
      'Votre compte et toutes les données seront définitivement supprimés. Cette action est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Erreur';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get loading => 'Chargement...';

  @override
  String get loadFailed => 'Échec du chargement';

  @override
  String get noDataYet => 'Pas encore de données';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get welcomeSubtitle => 'Posez votre téléphone. Battez vos amis.';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get continueWithApple => 'Continuer avec Apple';

  @override
  String get continueWithEmail => 'Continuer avec e-mail';

  @override
  String get permissionsTitle => 'Autorisations';

  @override
  String get permissionsSubtitle =>
      'Nous avons besoin d\'une autorisation pour suivre votre temps d\'écran.';

  @override
  String get grantPermission => 'Accorder l\'autorisation';

  @override
  String get setupProfile => 'Configurer le profil';

  @override
  String get displayName => 'Nom affiché';

  @override
  String get selectCity => 'Sélectionner une ville';

  @override
  String get selectGoal => 'Sélectionner l\'objectif quotidien';

  @override
  String get noDuelsYet => 'Pas encore de duels';

  @override
  String get noDuelsYetSubtitle => 'Lance ton premier duel !';

  @override
  String get activeDuelsTitle => 'Duels actifs';

  @override
  String get newDuel => 'Nouveau duel';

  @override
  String get selectDuelType => 'Choisir le type de duel';

  @override
  String get selectDurationStep => 'Choisir la durée';

  @override
  String get selectOpponent => 'Choisir l\'adversaire';

  @override
  String get duelStartButton => 'Lancer le duel ! ⚔️';

  @override
  String get freePlanDuelLimit =>
      'Le plan gratuit autorise max. 3 duels actifs ! Passe à Pro.';

  @override
  String get quickSelect => 'Sélection rapide';

  @override
  String get customDuration => 'Durée personnalisée';

  @override
  String selectedDuration(String duration) {
    return 'Sélectionné : $duration';
  }

  @override
  String get minDurationWarning => 'Tu dois sélectionner au moins 10 minutes';

  @override
  String get selectPenalty => 'Choisir la pénalité (optionnel)';

  @override
  String get searchFriend => 'Rechercher un ami...';

  @override
  String get inviteWithLink => 'Inviter par lien 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '${count}min aujourd\'hui';
  }

  @override
  String duelRemaining(int h, int m) {
    return 'Il reste ${h}h ${m}m';
  }

  @override
  String get remainingTime => 'Temps restant';

  @override
  String watchersCount(int count) {
    return '$count regardent 👀';
  }

  @override
  String get giveUp => 'Abandonner';

  @override
  String get duelWon => 'Tu as gagné ! 🎉';

  @override
  String get duelLost => 'Tu as perdu 😔';

  @override
  String get greatPerformance => 'Belle performance !';

  @override
  String get betterNextTime => 'La prochaine fois sera meilleure !';

  @override
  String get revenge => 'Prendre ma revanche 🔥';

  @override
  String get share => 'Partager';

  @override
  String get selectFriend => 'Choisir un ami';

  @override
  String get orSendLink => 'ou envoyer un lien';

  @override
  String get social => 'Social';

  @override
  String get myFriends => 'Mes amis';

  @override
  String get inMyCity => 'Dans ma ville';

  @override
  String get shareFirstStory =>
      'Sois le premier à partager ton moment off-grid !';

  @override
  String get createStoryTitle => 'Partager une story';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get whatAreYouDoing => 'Que fais-tu ?';

  @override
  String get captionHint => 'Que fais-tu loin de ton téléphone ?';

  @override
  String get howLongVisible => 'Combien de temps doit-elle être visible ?';

  @override
  String get whoCanSee => 'Qui peut la voir ?';

  @override
  String get onlyFriends => 'Seulement mes amis';

  @override
  String get cityPeople => 'Les gens de ma ville';

  @override
  String get photoStoriesPro =>
      'Les stories photo sont Pro ! Paramètres > Club Off-Grid';

  @override
  String get camera => 'Appareil photo';

  @override
  String get gallery => 'Galerie';

  @override
  String get writeFirst => 'Écris quelque chose d\'abord !';

  @override
  String get inappropriateContent => 'Contenu inapproprié détecté';

  @override
  String viewsCount(int count) {
    return '$count vues';
  }

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get changePhoto => 'Changer de photo';

  @override
  String get firstName => 'Prénom';

  @override
  String get firstNameHint => 'Ton prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get lastNameHint => 'Ton nom';

  @override
  String get usernameLabel => 'Nom d\'utilisateur';

  @override
  String get updateLocation => 'Mettre à jour la localisation';

  @override
  String get locationUnknown => 'Inconnu';

  @override
  String get save => 'Enregistrer';

  @override
  String get usernameAvailable => 'Disponible';

  @override
  String get usernameTaken => 'Ce nom d\'utilisateur est pris';

  @override
  String get usernameFormatError =>
      'Au moins 3 caractères, lettres, chiffres et _ uniquement';

  @override
  String get profileUpdated => 'Profil mis à jour';

  @override
  String get photoSelectedDemo =>
      'Photo sélectionnée (ne sera pas uploadée en mode démo)';

  @override
  String get locationError => 'Impossible d\'obtenir la localisation';

  @override
  String get errorOccurred => 'Une erreur s\'est produite';

  @override
  String get detailedScreenTime => 'Temps d\'écran détaillé';

  @override
  String get monthlyTop10 => 'Top 10 mensuel';

  @override
  String get searchHint => 'Rechercher...';

  @override
  String get noFriendsYet => 'Pas encore d\'amis';

  @override
  String get noFriendsHint => 'Commence par ajouter un ami';

  @override
  String get showQrCode => 'Affiche ton QR code';

  @override
  String get enterCode => 'Saisir le code';

  @override
  String get inviteLinkShare => 'Partager le lien d\'invitation';

  @override
  String get startDuelAction => 'Lancer le duel';

  @override
  String get pointsLabel => 'Points';

  @override
  String get mostUsedLabel => 'Le plus utilisé :';

  @override
  String get recentBadges => 'Badges récents';

  @override
  String get allBadgesLabel => 'Tous les badges';

  @override
  String get removeFriend => 'Supprimer l\'ami';

  @override
  String get removeFriendConfirm =>
      'Es-tu sûr de vouloir retirer cette personne de ta liste d\'amis ?';

  @override
  String get remove => 'Retirer';

  @override
  String get requestSent => 'Demande envoyée';

  @override
  String get whatCouldYouDo => 'Qu\'aurais-tu pu faire ?';

  @override
  String get back => 'Retour';

  @override
  String get weekly => 'Hebdomadaire';

  @override
  String get daily => 'Quotidien';

  @override
  String get mostUsedApps => 'Apps les plus utilisées';

  @override
  String get unlockSection => 'Déverrouillages';

  @override
  String get selectedDayLabel => 'Jour sélectionné';

  @override
  String get todayLabel => 'Aujourd\'hui';

  @override
  String weeklyAvgLabel(int h, int m) {
    return 'Moy. quotidienne : ${h}h ${m}m';
  }

  @override
  String get firstUnlock => 'Premier déverrouillage';

  @override
  String get mostOpened => 'Le plus ouvert';

  @override
  String get timesPickedUp => 'Prises en main';

  @override
  String get openingCount => 'ouvertures';

  @override
  String get notificationUnit => 'notifications';

  @override
  String get timesUnit => 'fois';

  @override
  String get turkey => 'Türkiye';

  @override
  String get consecutiveDays => 'jours d\'affilée';

  @override
  String bestStreakLabel(int days) {
    return 'Meilleur : $days jours';
  }

  @override
  String get seriFriends => 'Amis';

  @override
  String get oxygenTitle => 'Oxygène (O₂)';

  @override
  String get totalO2 => 'Total';

  @override
  String get remainingShort => 'Restant';

  @override
  String get noOffersYet => 'Pas encore d\'offres';

  @override
  String o2SpentMsg(int amount) {
    return '$amount O₂ dépensés';
  }

  @override
  String get mapLoadFailed => 'Impossible de charger la carte';

  @override
  String confirmRedeemMsg(String reward) {
    return 'Veux-tu échanger $reward ?';
  }

  @override
  String itemReceived(String item) {
    return '$item échangé !';
  }

  @override
  String get insufficientO2 => 'O₂ insuffisant';

  @override
  String get season1Title => 'Saison 1';

  @override
  String get season1Subtitle => 'Éveil printanier';

  @override
  String get seasonPassBtn => 'Pass Saison (99TL)';

  @override
  String get seasonPassLabel => 'Pass Saison';

  @override
  String get noGroupsYet => 'Pas encore de groupes';

  @override
  String get noGroupsSubtitle => 'Crée un groupe avec tes amis';

  @override
  String get newGroup => 'Nouveau groupe';

  @override
  String memberCount(int count) {
    return '$count membres';
  }

  @override
  String get weeklyGoal => 'Objectif hebdomadaire';

  @override
  String challengeProgress(int percent) {
    return '$percent% accompli';
  }

  @override
  String get membersLabel => 'Membres';

  @override
  String get inviteLink => 'Lien d\'invitation';

  @override
  String get linkCopied => 'Lien copié !';

  @override
  String get copy => 'Copier';

  @override
  String get qrCode => 'QR Code';

  @override
  String get groupNameLabel => 'Nom du groupe';

  @override
  String get groupNameHint => 'Saisis le nom du groupe';

  @override
  String get groupNameEmpty => 'Le nom du groupe ne peut pas être vide';

  @override
  String dailyGoalHours(int hours) {
    return 'Objectif quotidien : $hours heures';
  }

  @override
  String get addMember => 'Ajouter un membre';

  @override
  String selectedCount(int count) {
    return '$count sélectionné(s)';
  }

  @override
  String get create => 'Créer';

  @override
  String groupCreated(String name) {
    return '$name créé !';
  }

  @override
  String invitedCount(int count) {
    return '$count personnes invitées';
  }

  @override
  String get screenTimeLower => 'temps d\'écran';

  @override
  String get improvedFromLastWeek => '12 % mieux que la semaine dernière';

  @override
  String get o2Earned => 'O₂ gagné';

  @override
  String get friendRank => 'Rang parmi les amis';

  @override
  String cityRankLabel(String city) {
    return 'Rang à $city';
  }

  @override
  String get mostUsed => 'Le plus utilisé';

  @override
  String get offGridClub => 'Club Off-Grid';

  @override
  String get clubSubtitle =>
      'Atteins l\'équilibre numérique et sois récompensé.';

  @override
  String get planStarter => 'Starter';

  @override
  String get planStarterSubtitle => 'Commence avec les bases';

  @override
  String get currentPlanBtn => 'Plan actuel';

  @override
  String get billingMonthly => 'Mensuel';

  @override
  String get billingYearly => 'Annuel';

  @override
  String get yearlySavings => '33 % de réduction';

  @override
  String get planComparison => 'Comparaison des plans';

  @override
  String get breathTechniquesComp => 'Techniques de respiration';

  @override
  String get activeDuelsComp => 'Duels actifs';

  @override
  String get storyPhoto => 'Photo story';

  @override
  String get heatMap => 'Carte de chaleur';

  @override
  String get top10Report => 'Rapport Top 10';

  @override
  String get exclusiveBadges => 'Badges exclusifs';

  @override
  String get adFree => 'Sans publicité';

  @override
  String get familyPlanComp => 'Plan familial';

  @override
  String get familyReport => 'Rapport familial';

  @override
  String get exclusiveThemes => 'Thèmes exclusifs';

  @override
  String get prioritySupport => 'Support prioritaire';

  @override
  String get billingNote =>
      'L\'abonnement peut être annulé à tout moment.\nPaiement via App Store/Google Play.\nL\'abonnement se renouvelle automatiquement.';

  @override
  String get restoreSuccess => 'Achats restaurés !';

  @override
  String get restoreFailed => 'Aucun achat à restaurer.';

  @override
  String get packagesLoadFailed =>
      'Impossible de charger les offres. Réessaie.';

  @override
  String get themesTitle => 'Thèmes';

  @override
  String get themeLockedMsg => 'Ce thème est Pro+ ! Paramètres > Club Off-Grid';

  @override
  String get familyPlanTitle => 'Plan familial';

  @override
  String get familyPlanLocked => 'L\'équilibre numérique ensemble';

  @override
  String get familyPlanLockedDesc =>
      'Ajoute jusqu\'à 5 membres de la famille, fixez des objectifs ensemble et recevez des rapports familiaux hebdomadaires.';

  @override
  String get weeklyFamilyReport => 'Rapport familial hebdomadaire';

  @override
  String get familyRanking => 'Classement familial';

  @override
  String get totalOffline => 'Total hors ligne';

  @override
  String get average => 'Moyenne';

  @override
  String get best => 'Meilleur';

  @override
  String offlineTime(int h, int m) {
    return '${h}h ${m}m hors ligne';
  }

  @override
  String get enterName => 'Saisir un nom';

  @override
  String get cannotUndo => 'Cette action est irréversible !';

  @override
  String get deleteWarningDesc =>
      'Lorsque tu supprimes ton compte, les données suivantes seront définitivement supprimées :';

  @override
  String get deleteItem1 => 'Informations de profil et avatar';

  @override
  String get deleteItem2 => 'Toutes les statistiques de temps d\'écran';

  @override
  String get deleteItem3 => 'Liste d\'amis et duels';

  @override
  String get deleteItem4 => 'Stories et commentaires';

  @override
  String get deleteItem5 => 'Points O₂ et butin';

  @override
  String get deleteItem6 => 'Historique d\'abonnement';

  @override
  String get deleteSubscriptionNote =>
      'Si tu as un abonnement actif, tu dois d\'abord l\'annuler via l\'App Store Apple ou Google Play Store.';

  @override
  String get deleteConfirmCheck =>
      'Je comprends que mon compte et toutes mes données seront définitivement supprimés.';

  @override
  String get deleteAccountBtn => 'Supprimer définitivement mon compte';

  @override
  String get deleteErrorMsg => 'Une erreur s\'est produite. Réessaie.';

  @override
  String get emailHint => 'E-mail';

  @override
  String get passwordHint => 'Mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié';

  @override
  String get passwordResetSent =>
      'E-mail de réinitialisation du mot de passe envoyé.';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get signIn => 'Se connecter';

  @override
  String get orDivider => 'ou';

  @override
  String get continueWithGoogleShort => 'Continuer avec Google';

  @override
  String get continueWithAppleShort => 'Continuer avec Apple';

  @override
  String get noAccountYet => 'Pas encore de compte ? ';

  @override
  String get adminExistingPoints => 'Points existants';

  @override
  String get adminSearchPlace => 'Rechercher un lieu...';

  @override
  String get adminRewardTitle => 'Titre de la récompense (ex. Café gratuit)';

  @override
  String get adminO2Cost => 'Coût O₂';

  @override
  String get adminSave => 'Enregistrer';

  @override
  String get adminSaved => 'Enregistré !';

  @override
  String get adminDeleteTitle => 'Supprimer';

  @override
  String get adminDeleteMsg => 'Es-tu sûr de vouloir supprimer ce point ?';

  @override
  String adminDeleteError(String error) {
    return 'Erreur de suppression : $error';
  }

  @override
  String get adminFillFields => 'Remplis la récompense et le coût O₂';

  @override
  String breathCount(int count) {
    return '$count respirations';
  }

  @override
  String minutesRemaining(int count) {
    return 'Encore ${count}min';
  }

  @override
  String focusMinutes(int count) {
    return 'Tu t\'es concentré pendant $count minutes';
  }

  @override
  String get o2TimeRestriction => 'O₂ gagnable uniquement entre 08h00 et 00h00';

  @override
  String get breathTechniqueProMsg =>
      'Cette technique est Pro ! Paramètres > Club Off-Grid';

  @override
  String get inhale => 'Inspiration';

  @override
  String get holdBreath => 'Rétention';

  @override
  String get exhale => 'Expiration';

  @override
  String get waitBreath => 'Attente';

  @override
  String get proMostPopular => 'Le plus populaire';

  @override
  String get proFamilyBadge => 'FAMILLE';

  @override
  String get comparedToLastWeek => 'par rapport à la semaine dernière';

  @override
  String get appBlockTitle => 'Blocage d\'apps';

  @override
  String get appBlockSchedule => 'Horaire';

  @override
  String get appBlockEnableBlocking => 'Activer le blocage';

  @override
  String get appBlockActive => 'Le blocage est activé';

  @override
  String get appBlockInactive => 'Le blocage est désactivé';

  @override
  String get appBlockStrictMode => 'Mode strict';

  @override
  String get appBlockStrictDesc =>
      'Ne peut pas être désactivé avant la fin du minuteur';

  @override
  String get appBlockStrictExpired => 'Minuteur expiré';

  @override
  String get appBlockStrictDurationTitle => 'Durée du mode strict';

  @override
  String get appBlockDuration30m => '30 minutes';

  @override
  String get appBlockDuration1h => '1 heure';

  @override
  String get appBlockDuration2h => '2 heures';

  @override
  String get appBlockDuration4h => '4 heures';

  @override
  String get appBlockDurationAllDay => 'Toute la journée (24 heures)';

  @override
  String get appBlockScheduleTitle => 'Horaire de blocage';

  @override
  String get appBlockScheduleDesc => 'Définir des plages horaires quotidiennes';

  @override
  String get appBlockBlockedApps => 'Apps bloquées';

  @override
  String get appBlockNoApps => 'Aucune app ajoutée pour le moment';

  @override
  String get appBlockAddApp => 'Ajouter une app';

  @override
  String get appBlockPickerTitle => 'Choisir une app';

  @override
  String get appBlockPresetWork => 'Heures de travail (09-18)';

  @override
  String get appBlockPresetSleep => 'Heure du coucher (23-07)';

  @override
  String get appBlockPresetAllDay => 'Toute la journée';

  @override
  String get appBlockInterventionTitle => 'Attends une seconde...';

  @override
  String get appBlockInterventionSubtitle => 'Respire et observe-toi';

  @override
  String get appBlockInterventionGiveUp => 'Je laisse tomber';

  @override
  String get appBlockInterventionOpenAnyway => 'Ouvrir quand même';

  @override
  String get appBlockStrictModeActive => 'Mode strict — impossible d\'ouvrir';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return 'Tu as passé $hours heures sur $app cette semaine';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return 'Tu as renoncé $count fois ce mois-ci';
  }

  @override
  String get pickAppToBan => 'Choisir l\'app à bannir';

  @override
  String get pickAppToBanDesc =>
      'Ton adversaire ne pourra pas ouvrir cette app pendant 24 heures';

  @override
  String get pickCategory => 'Choisir la catégorie';

  @override
  String get pickCategoryDesc => 'Seul l\'usage de cette catégorie compte';

  @override
  String get rollDiceForTarget => 'Lance les dés pour ton objectif';

  @override
  String get rollDiceDesc => 'Valeur du dé × 30 minutes = durée cible';

  @override
  String get diceTapToRoll => 'Appuie pour lancer';

  @override
  String get diceRolling => 'Lancement...';

  @override
  String diceResult(int value) {
    return 'Résultat : $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return 'Durée cible : $minutes min';
  }

  @override
  String get chooseTeammates => 'Choisir les coéquipiers';

  @override
  String teammatesSelected(int count) {
    return '$count/3 sélectionnés  ·  Choisis 2 ou 3 coéquipiers';
  }

  @override
  String get nightDuelInfo => 'Duel de nuit';

  @override
  String get nightDuelRange => '23h00 — 07h00';

  @override
  String get nightDuelBody =>
      'Dors sans toucher ton téléphone. Celui qui tient le plus longtemps gagne. 8 heures fixes.';

  @override
  String get nightDuelAutoStart => 'Ce duel démarre automatiquement à 23h00.';

  @override
  String get mysteryMissionTitle => 'Mission mystère';

  @override
  String get mysteryMissionSubtitle =>
      'Ta mission est révélée au début du duel';

  @override
  String get mysteryMissionBody =>
      'Quand tu lances le duel, une mission aléatoire est sélectionnée.';

  @override
  String get mysteryStart => 'Lancer la mission';

  @override
  String opponentWantsToBanApp(String app) {
    return 'Ton adversaire veut que tu bannisses $app';
  }

  @override
  String opponentWantsCategory(String category) {
    return 'Ton adversaire veut s\'affronter en catégorie $category';
  }

  @override
  String get proposeDifferentApp =>
      'Je n\'ai pas cette app, propose-en une autre';

  @override
  String get proposeDifferentCategory =>
      'Je n\'utilise pas cette catégorie, propose-en une autre';

  @override
  String get acceptInvite => 'Accepter';

  @override
  String proposalSent(String value) {
    return 'Proposition envoyée : $value';
  }

  @override
  String get stepAppPicker => 'Choisir l\'app';

  @override
  String get stepCategoryPicker => 'Choisir la catégorie';

  @override
  String get stepDice => 'Lancer les dés';

  @override
  String get stepNightInfo => 'Duel de nuit';

  @override
  String get stepMystery => 'Mission mystère';

  @override
  String get stepTeamPicker => 'Choisir les coéquipiers';
}
