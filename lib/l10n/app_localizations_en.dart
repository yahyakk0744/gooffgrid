// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan => 'Unplug. Play. Don\'t get lost in the digital.';

  @override
  String get home => 'Home';

  @override
  String get ranking => 'Ranking';

  @override
  String get duel => 'Duel';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get stories => 'Stories';

  @override
  String get today => 'Today';

  @override
  String get thisWeek => 'This Week';

  @override
  String get friends => 'Friends';

  @override
  String get friendsOf => 'Friends of';

  @override
  String get allFriends => 'All';

  @override
  String get city => 'City';

  @override
  String get country => 'Country';

  @override
  String get global => 'Global';

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
  String get screenTime => 'Screen Time';

  @override
  String get phonePickups => 'Phone Pickups';

  @override
  String pickupsToday(int count) {
    return 'Picked up $count times today';
  }

  @override
  String get topTriggers => 'Top Triggers';

  @override
  String get longestOffScreen => 'Longest Offline';

  @override
  String get dailyGoal => 'Daily Goal';

  @override
  String goalHours(int count) {
    return 'Goal: $count hours';
  }

  @override
  String get streak => 'Streak';

  @override
  String streakDays(int count) {
    return '$count days';
  }

  @override
  String get level => 'Level';

  @override
  String get badges => 'Badges';

  @override
  String get duels => 'Duels';

  @override
  String get activeDuels => 'Active';

  @override
  String get pastDuels => 'Past';

  @override
  String get createDuel => 'Create Duel';

  @override
  String get startDuel => 'Start Duel';

  @override
  String get invite => 'Invite';

  @override
  String get accept => 'Accept';

  @override
  String get decline => 'Decline';

  @override
  String get win => 'Won';

  @override
  String get lose => 'Lost';

  @override
  String get draw => 'Draw';

  @override
  String get addFriend => 'Add Friend';

  @override
  String get friendCode => 'Friend Code';

  @override
  String get search => 'Search';

  @override
  String get notifications => 'Notifications';

  @override
  String get dailyReminder => 'Daily Reminder';

  @override
  String get duelNotifications => 'Duel Notifications';

  @override
  String get locationSharing => 'Location Sharing';

  @override
  String get subscription => 'Subscription';

  @override
  String get free => 'Free';

  @override
  String get pro => 'Pro';

  @override
  String get proPlus => 'Pro+';

  @override
  String get currentPlan => 'Current Plan';

  @override
  String get recommended => 'Recommended';

  @override
  String get start => 'Start';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get upgradeToProPlus => 'Upgrade to Pro+';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String monthlyPrice(String price) {
    return '$price/mo';
  }

  @override
  String get freeFeature1 => 'Daily screen time tracking';

  @override
  String get freeFeature2 => 'Friend leaderboards';

  @override
  String get freeFeature3 => '3 active duels';

  @override
  String get freeFeature4 => 'Basic badges';

  @override
  String get proFeature1 => 'All leaderboards (city, country, global)';

  @override
  String get proFeature2 => 'Detailed stats & focus calendar';

  @override
  String get proFeature3 => 'Unlimited duels';

  @override
  String get proFeature4 => 'Off-Grid Passes included';

  @override
  String get proFeature5 => 'Ad-free experience';

  @override
  String get proPlusFeature1 => 'Everything in Pro';

  @override
  String get proPlusFeature2 => 'Family plan (5 people)';

  @override
  String get proPlusFeature3 => 'Priority support';

  @override
  String get proPlusFeature4 => 'Exclusive badges & themes';

  @override
  String get proPlusFeature5 => 'Early access to beta features';

  @override
  String get paywallTitle => 'Off-Grid Club';

  @override
  String get paywallSubtitle => 'Get rewarded for disconnecting.';

  @override
  String get logout => 'Log Out';

  @override
  String get shareProfile => 'Share Profile';

  @override
  String get shareReportCard => 'Drop the Air';

  @override
  String get appUsage => 'App Usage';

  @override
  String get whatDidYouUse => 'What did you use today?';

  @override
  String get weeklyReport => 'Weekly Report';

  @override
  String get weeklyTrend => '7-Day Trend';

  @override
  String get seasons => 'Seasons';

  @override
  String get seasonPass => 'Off-Grid Passes';

  @override
  String get groups => 'Groups';

  @override
  String get createGroup => 'Create Group';

  @override
  String get stats => 'Statistics';

  @override
  String get analytics => 'Analytics';

  @override
  String get detailedAnalytics => 'Detailed Analytics';

  @override
  String get categories => 'Categories';

  @override
  String get weeklyUsage => 'Weekly Usage';

  @override
  String get appDetails => 'App Details';

  @override
  String get focusCalendar => 'Focus Calendar';

  @override
  String get whatIf => 'What If?';

  @override
  String get focusMode => 'Breathe';

  @override
  String get startFocusMode => 'Start Focus Mode';

  @override
  String get focusing => 'You\'re focusing...';

  @override
  String focusComplete(int minutes) {
    return 'Great! You focused for $minutes min';
  }

  @override
  String get focusTimeout => 'Session Timeout';

  @override
  String get focusTimeoutDesc =>
      'You\'ve reached the 120-minute limit.\nStill there?';

  @override
  String get end => 'End';

  @override
  String get reportCard => 'Report Card';

  @override
  String get antiSocialStory => 'Anti-Social Moment';

  @override
  String get storyQuestion => 'What are you doing away from your phone?';

  @override
  String get postStory => 'Post';

  @override
  String get storyExpired => 'Expired';

  @override
  String get noStories => 'No stories yet';

  @override
  String get noStoriesHint =>
      'Let your friends start sharing their off-grid moments!';

  @override
  String get storyBlocked => 'Can\'t Share a Story';

  @override
  String get storyBlockedHint =>
      'You\'ve exceeded your daily screen time goal. Stay on track to earn the right to share stories!';

  @override
  String get duration => 'Duration';

  @override
  String get walk => 'Walk';

  @override
  String get run => 'Run';

  @override
  String get book => 'Book';

  @override
  String get meditation => 'Meditation';

  @override
  String get nature => 'Nature';

  @override
  String get sports => 'Sports';

  @override
  String get music => 'Music';

  @override
  String get cooking => 'Cooking';

  @override
  String get friendsActivity => 'Friends';

  @override
  String get family => 'Family';

  @override
  String get o2Balance => 'O₂ Points';

  @override
  String o2Remaining(int count) {
    return 'Remaining: $count';
  }

  @override
  String o2Today(int earned, int max) {
    return 'Today: $earned/$max O₂';
  }

  @override
  String get o2Rules => 'O₂ Rules';

  @override
  String get o2RuleTime => 'Earned only between 08:00–00:00';

  @override
  String get o2RuleDaily => 'Max 500 O₂ per day';

  @override
  String get o2RuleFocus => 'Focus mode max 120 min';

  @override
  String get o2RuleTransfer => 'No transfers or wagering';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂ (estimated)';
  }

  @override
  String get offGridMarket => 'Loot';

  @override
  String get offGridMarketHint => 'Turn O₂ points into real-world loot';

  @override
  String get redeem => 'Redeem';

  @override
  String get insufficient => 'Insufficient';

  @override
  String get redeemSuccess => 'Congrats!';

  @override
  String get couponCode => 'Your coupon code:';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get categorySocial => 'Social';

  @override
  String get categoryGame => 'Games';

  @override
  String get categoryVideo => 'Video';

  @override
  String get categoryAudio => 'Music';

  @override
  String get categoryProductivity => 'Productivity';

  @override
  String get categoryNews => 'News';

  @override
  String get categoryGames => 'Games';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryBrowser => 'Browser';

  @override
  String get categoryMaps => 'Maps';

  @override
  String get categoryImage => 'Photos';

  @override
  String get categoryOther => 'Other';

  @override
  String hello(String name) {
    return 'Hello, $name';
  }

  @override
  String get goalCompleted => 'Goal completed!';

  @override
  String get dailyGoalShort => 'Daily goal';

  @override
  String get streakDaysLabel => 'day streak';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => 'rank';

  @override
  String get offlineLabel => 'offline';

  @override
  String get todaysApps => 'Today\'s Apps';

  @override
  String get seeAll => 'See All';

  @override
  String get activeDuel => 'Active Duel';

  @override
  String get startDuelPrompt => 'Start a duel!';

  @override
  String get you => 'You';

  @override
  String moreCount(int count) {
    return '+$count more';
  }

  @override
  String get removeWithPro => 'Remove with Pro';

  @override
  String get adLabel => 'Ad';

  @override
  String get focus => 'Focus';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get kvkkText => 'KVKK Privacy Notice';

  @override
  String get deleteMyAccount => 'Delete My Account';

  @override
  String get edit => 'Edit';

  @override
  String get adminAddLoot => 'Admin: Add Loot';

  @override
  String get continueConsent => 'By continuing you';

  @override
  String get acceptTermsSuffix => 'accept.';

  @override
  String get alreadyHaveAccount => 'I already have an account';

  @override
  String get screenTimePermissionTitle => 'We need to track your screen time';

  @override
  String get screenTimePermissionDesc =>
      'Screen time access is required to see how much time you spend on each app.';

  @override
  String get screenTimeGranted => 'Screen time permission granted!';

  @override
  String get continueButton => 'Continue';

  @override
  String get skip => 'Skip';

  @override
  String get yourName => 'Your Name';

  @override
  String get nameHint => 'Enter your name';

  @override
  String get ageGroup => 'Age Group';

  @override
  String get imReady => 'I\'m Ready';

  @override
  String get dailyGoalTitle => 'Your Daily Goal';

  @override
  String get goalQuestion =>
      'How many hours of screen time do you aim for daily?';

  @override
  String get goalMotivational1 => 'Amazing! A real digital detox goal 💪';

  @override
  String get goalMotivational2 => 'A balanced goal, you can do it! 🎯';

  @override
  String get goalMotivational3 => 'A good start, you can reduce over time 📉';

  @override
  String get goalMotivational4 => 'Step by step, every minute counts ⭐';

  @override
  String get next => 'Next';

  @override
  String hourShort(int count) {
    return '${count}h';
  }

  @override
  String get welcomeSlogan =>
      'Put down your phone. Beat your friends.\nBe #1 in your city.';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirm =>
      'Your account and all data will be permanently deleted. This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get loading => 'Loading...';

  @override
  String get loadFailed => 'Failed to load';

  @override
  String get noDataYet => 'No data yet';

  @override
  String get welcome => 'Welcome';

  @override
  String get welcomeSubtitle => 'Put down your phone. Beat your friends.';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get continueWithEmail => 'Continue with Email';

  @override
  String get permissionsTitle => 'Permissions';

  @override
  String get permissionsSubtitle =>
      'We need permission to track your screen time.';

  @override
  String get grantPermission => 'Grant Permission';

  @override
  String get setupProfile => 'Setup Profile';

  @override
  String get displayName => 'Display Name';

  @override
  String get selectCity => 'Select City';

  @override
  String get selectGoal => 'Select Daily Goal';

  @override
  String get noDuelsYet => 'No duels yet';

  @override
  String get noDuelsYetSubtitle => 'Start your first duel!';

  @override
  String get activeDuelsTitle => 'Active Duels';

  @override
  String get newDuel => 'New Duel';

  @override
  String get selectDuelType => 'Select Duel Type';

  @override
  String get selectDurationStep => 'Select Duration';

  @override
  String get selectOpponent => 'Select Opponent';

  @override
  String get duelStartButton => 'Start Duel! ⚔️';

  @override
  String get freePlanDuelLimit =>
      'Free plan allows max 3 active duels! Upgrade to Pro.';

  @override
  String get quickSelect => 'Quick Select';

  @override
  String get customDuration => 'Custom Duration';

  @override
  String selectedDuration(String duration) {
    return 'Selected: $duration';
  }

  @override
  String get minDurationWarning => 'You must select at least 10 minutes';

  @override
  String get selectPenalty => 'Select Penalty (optional)';

  @override
  String get searchFriend => 'Search friend...';

  @override
  String get inviteWithLink => 'Invite with Link 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '${count}min today';
  }

  @override
  String duelRemaining(int h, int m) {
    return '${h}h ${m}m left';
  }

  @override
  String get remainingTime => 'Time Remaining';

  @override
  String watchersCount(int count) {
    return '$count watching 👀';
  }

  @override
  String get giveUp => 'Give Up';

  @override
  String get duelWon => 'You Won! 🎉';

  @override
  String get duelLost => 'You Lost 😔';

  @override
  String get greatPerformance => 'Great performance!';

  @override
  String get betterNextTime => 'Better luck next time!';

  @override
  String get revenge => 'Get Revenge 🔥';

  @override
  String get share => 'Share';

  @override
  String get selectFriend => 'Select Friend';

  @override
  String get orSendLink => 'or Send Link';

  @override
  String get social => 'Social';

  @override
  String get myFriends => 'My Friends';

  @override
  String get inMyCity => 'In My City';

  @override
  String get shareFirstStory => 'Be the first to share your off-grid moment!';

  @override
  String get createStoryTitle => 'Share Story';

  @override
  String get addPhoto => 'Add Photo';

  @override
  String get whatAreYouDoing => 'What are you doing?';

  @override
  String get captionHint => 'What are you doing away from your phone?';

  @override
  String get howLongVisible => 'How long should it be visible?';

  @override
  String get whoCanSee => 'Who can see it?';

  @override
  String get onlyFriends => 'Only My Friends';

  @override
  String get cityPeople => 'People in My City';

  @override
  String get photoStoriesPro =>
      'Photo stories are Pro! Settings > Off-Grid Club';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get writeFirst => 'Write something first!';

  @override
  String get inappropriateContent => 'Inappropriate content detected';

  @override
  String viewsCount(int count) {
    return '$count views';
  }

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get firstName => 'First Name';

  @override
  String get firstNameHint => 'Your first name';

  @override
  String get lastName => 'Last Name';

  @override
  String get lastNameHint => 'Your last name';

  @override
  String get usernameLabel => 'Username';

  @override
  String get updateLocation => 'Update Location';

  @override
  String get locationUnknown => 'Unknown';

  @override
  String get save => 'Save';

  @override
  String get usernameAvailable => 'Available';

  @override
  String get usernameTaken => 'This username is taken';

  @override
  String get usernameFormatError =>
      'At least 3 characters, only letters, numbers and _';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get photoSelectedDemo => 'Photo selected (won\'t upload in demo mode)';

  @override
  String get locationError => 'Could not get location';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get detailedScreenTime => 'Detailed Screen Time';

  @override
  String get monthlyTop10 => 'Monthly Top 10';

  @override
  String get searchHint => 'Search...';

  @override
  String get noFriendsYet => 'No friends yet';

  @override
  String get noFriendsHint => 'Start by adding a friend';

  @override
  String get showQrCode => 'Show your QR code';

  @override
  String get enterCode => 'Enter Code';

  @override
  String get inviteLinkShare => 'Share Invite Link';

  @override
  String get startDuelAction => 'Start Duel';

  @override
  String get pointsLabel => 'Points';

  @override
  String get mostUsedLabel => 'Most used:';

  @override
  String get recentBadges => 'Recent Badges';

  @override
  String get allBadgesLabel => 'All Badges';

  @override
  String get removeFriend => 'Remove Friend';

  @override
  String get removeFriendConfirm =>
      'Are you sure you want to remove this person from your friends list?';

  @override
  String get remove => 'Remove';

  @override
  String get requestSent => 'Request Sent';

  @override
  String get whatCouldYouDo => 'What Could You Have Done?';

  @override
  String get back => 'Back';

  @override
  String get weekly => 'Weekly';

  @override
  String get daily => 'Daily';

  @override
  String get mostUsedApps => 'Most Used Apps';

  @override
  String get unlockSection => 'Unlocks';

  @override
  String get selectedDayLabel => 'Selected Day';

  @override
  String get todayLabel => 'Today';

  @override
  String weeklyAvgLabel(int h, int m) {
    return 'Daily avg: ${h}h ${m}m';
  }

  @override
  String get firstUnlock => 'First Unlock';

  @override
  String get mostOpened => 'Most Opened';

  @override
  String get timesPickedUp => 'Times Picked Up';

  @override
  String get openingCount => 'opens';

  @override
  String get notificationUnit => 'notifications';

  @override
  String get timesUnit => 'times';

  @override
  String get turkey => 'Türkiye';

  @override
  String get consecutiveDays => 'days in a row';

  @override
  String bestStreakLabel(int days) {
    return 'Best: $days days';
  }

  @override
  String get seriFriends => 'Friends';

  @override
  String get oxygenTitle => 'Oxygen (O₂)';

  @override
  String get totalO2 => 'Total';

  @override
  String get remainingShort => 'Remaining';

  @override
  String get noOffersYet => 'No offers yet';

  @override
  String o2SpentMsg(int amount) {
    return '$amount O₂ spent';
  }

  @override
  String get mapLoadFailed => 'Failed to load map';

  @override
  String confirmRedeemMsg(String reward) {
    return 'Do you want to redeem $reward?';
  }

  @override
  String itemReceived(String item) {
    return '$item redeemed!';
  }

  @override
  String get insufficientO2 => 'Insufficient O₂';

  @override
  String get season1Title => 'Season 1';

  @override
  String get season1Subtitle => 'Spring Awakening';

  @override
  String get seasonPassBtn => 'Season Pass (99TL)';

  @override
  String get seasonPassLabel => 'Season Pass';

  @override
  String get noGroupsYet => 'No groups yet';

  @override
  String get noGroupsSubtitle => 'Create a group with your friends';

  @override
  String get newGroup => 'New Group';

  @override
  String memberCount(int count) {
    return '$count members';
  }

  @override
  String get weeklyGoal => 'Weekly Goal';

  @override
  String challengeProgress(int percent) {
    return '$percent% completed';
  }

  @override
  String get membersLabel => 'Members';

  @override
  String get inviteLink => 'Invite Link';

  @override
  String get linkCopied => 'Link copied!';

  @override
  String get copy => 'Copy';

  @override
  String get qrCode => 'QR Code';

  @override
  String get groupNameLabel => 'Group Name';

  @override
  String get groupNameHint => 'Enter group name';

  @override
  String get groupNameEmpty => 'Group name cannot be empty';

  @override
  String dailyGoalHours(int hours) {
    return 'Daily Goal: $hours hours';
  }

  @override
  String get addMember => 'Add Member';

  @override
  String selectedCount(int count) {
    return '$count selected';
  }

  @override
  String get create => 'Create';

  @override
  String groupCreated(String name) {
    return '$name created!';
  }

  @override
  String invitedCount(int count) {
    return '$count people invited';
  }

  @override
  String get screenTimeLower => 'screen time';

  @override
  String get improvedFromLastWeek => '12% better than last week';

  @override
  String get o2Earned => 'O₂ Earned';

  @override
  String get friendRank => 'Friend Rank';

  @override
  String cityRankLabel(String city) {
    return '$city Rank';
  }

  @override
  String get mostUsed => 'Most used';

  @override
  String get offGridClub => 'Off-Grid Club';

  @override
  String get clubSubtitle => 'Achieve digital balance, get rewarded.';

  @override
  String get planStarter => 'Starter';

  @override
  String get planStarterSubtitle => 'Start with the basics';

  @override
  String get currentPlanBtn => 'Current Plan';

  @override
  String get billingMonthly => 'Monthly';

  @override
  String get billingYearly => 'Yearly';

  @override
  String get yearlySavings => '33% off';

  @override
  String get planComparison => 'Plan Comparison';

  @override
  String get breathTechniquesComp => 'Breath techniques';

  @override
  String get activeDuelsComp => 'Active duels';

  @override
  String get storyPhoto => 'Story photo';

  @override
  String get heatMap => 'Heat map';

  @override
  String get top10Report => 'Top 10 report';

  @override
  String get exclusiveBadges => 'Exclusive badges';

  @override
  String get adFree => 'Ad-free';

  @override
  String get familyPlanComp => 'Family plan';

  @override
  String get familyReport => 'Family report';

  @override
  String get exclusiveThemes => 'Exclusive themes';

  @override
  String get prioritySupport => 'Priority support';

  @override
  String get billingNote =>
      'Subscription can be cancelled anytime.\nPayment processed via App Store/Google Play.\nSubscription auto-renews at end of period.';

  @override
  String get restoreSuccess => 'Purchases restored!';

  @override
  String get restoreFailed => 'No purchases found to restore.';

  @override
  String get packagesLoadFailed => 'Failed to load packages. Please try again.';

  @override
  String get themesTitle => 'Themes';

  @override
  String get themeLockedMsg => 'This theme is Pro+! Settings > Off-Grid Club';

  @override
  String get familyPlanTitle => 'Family Plan';

  @override
  String get familyPlanLocked => 'Digital Balance Together';

  @override
  String get familyPlanLockedDesc =>
      'Add up to 5 family members, set goals together and get weekly family reports.';

  @override
  String get weeklyFamilyReport => 'Weekly Family Report';

  @override
  String get familyRanking => 'Family Ranking';

  @override
  String get totalOffline => 'Total Offline';

  @override
  String get average => 'Average';

  @override
  String get best => 'Best';

  @override
  String offlineTime(int h, int m) {
    return '${h}h ${m}m offline';
  }

  @override
  String get enterName => 'Enter name';

  @override
  String get cannotUndo => 'This action cannot be undone!';

  @override
  String get deleteWarningDesc =>
      'When you delete your account, the following data will be permanently deleted:';

  @override
  String get deleteItem1 => 'Profile info and avatar';

  @override
  String get deleteItem2 => 'All screen time statistics';

  @override
  String get deleteItem3 => 'Friend list and duels';

  @override
  String get deleteItem4 => 'Stories and comments';

  @override
  String get deleteItem5 => 'O₂ points and loot';

  @override
  String get deleteItem6 => 'Subscription history';

  @override
  String get deleteSubscriptionNote =>
      'If you have an active subscription, you must cancel it first via Apple App Store or Google Play Store.';

  @override
  String get deleteConfirmCheck =>
      'I understand that my account and all data will be permanently deleted.';

  @override
  String get deleteAccountBtn => 'Permanently Delete My Account';

  @override
  String get deleteErrorMsg => 'An error occurred. Please try again.';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get passwordResetSent => 'Password reset email sent.';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signIn => 'Sign In';

  @override
  String get orDivider => 'or';

  @override
  String get continueWithGoogleShort => 'Continue with Google';

  @override
  String get continueWithAppleShort => 'Continue with Apple';

  @override
  String get noAccountYet => 'Don\'t have an account? ';

  @override
  String get adminExistingPoints => 'Existing Points';

  @override
  String get adminSearchPlace => 'Search place...';

  @override
  String get adminRewardTitle => 'Reward Title (e.g. Free Coffee)';

  @override
  String get adminO2Cost => 'O₂ Cost';

  @override
  String get adminSave => 'Save';

  @override
  String get adminSaved => 'Saved!';

  @override
  String get adminDeleteTitle => 'Delete';

  @override
  String get adminDeleteMsg => 'Are you sure you want to delete this point?';

  @override
  String adminDeleteError(String error) {
    return 'Delete error: $error';
  }

  @override
  String get adminFillFields => 'Fill in reward and O₂ cost';

  @override
  String breathCount(int count) {
    return '$count breaths';
  }

  @override
  String minutesRemaining(int count) {
    return '${count}min left';
  }

  @override
  String focusMinutes(int count) {
    return 'You focused for $count minutes';
  }

  @override
  String get o2TimeRestriction => 'O₂ earned only between 08:00–00:00';

  @override
  String get breathTechniqueProMsg =>
      'This technique is Pro! Settings > Off-Grid Club';

  @override
  String get inhale => 'In';

  @override
  String get holdBreath => 'Hold';

  @override
  String get exhale => 'Out';

  @override
  String get waitBreath => 'Wait';

  @override
  String get proMostPopular => 'Most Popular';

  @override
  String get proFamilyBadge => 'FAMILY';

  @override
  String get comparedToLastWeek => 'compared to last week';

  @override
  String get appBlockTitle => 'App Blocking';

  @override
  String get appBlockSchedule => 'Schedule';

  @override
  String get appBlockEnableBlocking => 'Enable Blocking';

  @override
  String get appBlockActive => 'Blocking is on';

  @override
  String get appBlockInactive => 'Blocking is off';

  @override
  String get appBlockStrictMode => 'Strict Mode';

  @override
  String get appBlockStrictDesc => 'Cannot be disabled until timer ends';

  @override
  String get appBlockStrictExpired => 'Timer expired';

  @override
  String get appBlockStrictDurationTitle => 'Strict Mode Duration';

  @override
  String get appBlockDuration30m => '30 minutes';

  @override
  String get appBlockDuration1h => '1 hour';

  @override
  String get appBlockDuration2h => '2 hours';

  @override
  String get appBlockDuration4h => '4 hours';

  @override
  String get appBlockDurationAllDay => 'All Day (24 hours)';

  @override
  String get appBlockScheduleTitle => 'Block Schedule';

  @override
  String get appBlockScheduleDesc => 'Set daily time ranges';

  @override
  String get appBlockBlockedApps => 'Blocked Apps';

  @override
  String get appBlockNoApps => 'No apps added yet';

  @override
  String get appBlockAddApp => 'Add App';

  @override
  String get appBlockPickerTitle => 'Pick App';

  @override
  String get appBlockPresetWork => 'Work Hours (09-18)';

  @override
  String get appBlockPresetSleep => 'Sleep Time (23-07)';

  @override
  String get appBlockPresetAllDay => 'All Day';

  @override
  String get appBlockInterventionTitle => 'Wait a second...';

  @override
  String get appBlockInterventionSubtitle =>
      'Take a breath and observe yourself';

  @override
  String get appBlockInterventionGiveUp => 'I\'ll pass';

  @override
  String get appBlockInterventionOpenAnyway => 'Open anyway';

  @override
  String get appBlockStrictModeActive => 'Strict mode — can\'t open';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return 'You spent $hours hours on $app this week';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return 'You\'ve passed $count times this month';
  }

  @override
  String get pickAppToBan => 'Pick an app to ban';

  @override
  String get pickAppToBanDesc =>
      'Your opponent won\'t be able to open this app for 24 hours';

  @override
  String get pickCategory => 'Pick a category';

  @override
  String get pickCategoryDesc => 'Only time in this category will count';

  @override
  String get rollDiceForTarget => 'Roll the dice, set your target';

  @override
  String get rollDiceDesc => 'Dice value × 30 minutes = target duration';

  @override
  String get diceTapToRoll => 'Tap to roll';

  @override
  String get diceRolling => 'Rolling...';

  @override
  String diceResult(int value) {
    return 'Result: $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return 'Target duration: $minutes min';
  }

  @override
  String get chooseTeammates => 'Choose teammates';

  @override
  String teammatesSelected(int count) {
    return '$count/3 selected  ·  pick 2 or 3 teammates';
  }

  @override
  String get nightDuelInfo => 'Night Duel';

  @override
  String get nightDuelRange => '11:00 PM — 7:00 AM';

  @override
  String get nightDuelBody =>
      'Sleep without touching your phone. Whoever lasts longest wins. Fixed 8 hours.';

  @override
  String get nightDuelAutoStart =>
      'This duel starts automatically at 11:00 PM.';

  @override
  String get mysteryMissionTitle => 'Mystery Mission';

  @override
  String get mysteryMissionSubtitle =>
      'The mission is revealed when the duel starts';

  @override
  String get mysteryMissionBody =>
      'A random mission is picked when you start the duel.';

  @override
  String get mysteryStart => 'Start Mission';

  @override
  String opponentWantsToBanApp(String app) {
    return 'Your opponent wants you to ban $app';
  }

  @override
  String opponentWantsCategory(String category) {
    return 'Your opponent wants to duel in $category';
  }

  @override
  String get proposeDifferentApp => 'I don\'t have that app, suggest another';

  @override
  String get proposeDifferentCategory =>
      'I don\'t use that category, suggest another';

  @override
  String get acceptInvite => 'Accept';

  @override
  String proposalSent(String value) {
    return 'Proposal sent: $value';
  }

  @override
  String get stepAppPicker => 'Pick app';

  @override
  String get stepCategoryPicker => 'Pick category';

  @override
  String get stepDice => 'Roll dice';

  @override
  String get stepNightInfo => 'Night duel';

  @override
  String get stepMystery => 'Mystery mission';

  @override
  String get stepTeamPicker => 'Pick teammates';
}
