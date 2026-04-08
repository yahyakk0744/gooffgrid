import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'gooffgrid'**
  String get appTitle;

  /// No description provided for @appSlogan.
  ///
  /// In en, this message translates to:
  /// **'Unplug. Play. Don\'t get lost in the digital.'**
  String get appSlogan;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @ranking.
  ///
  /// In en, this message translates to:
  /// **'Ranking'**
  String get ranking;

  /// No description provided for @duel.
  ///
  /// In en, this message translates to:
  /// **'Duel'**
  String get duel;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @stories.
  ///
  /// In en, this message translates to:
  /// **'Stories'**
  String get stories;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @friends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friends;

  /// No description provided for @friendsOf.
  ///
  /// In en, this message translates to:
  /// **'Friends of'**
  String get friendsOf;

  /// No description provided for @allFriends.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allFriends;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @global.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get global;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String minutes(int count);

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'{count} h'**
  String hours(int count);

  /// No description provided for @hoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{h}h {m}m'**
  String hoursMinutes(int h, int m);

  /// No description provided for @screenTime.
  ///
  /// In en, this message translates to:
  /// **'Screen Time'**
  String get screenTime;

  /// No description provided for @phonePickups.
  ///
  /// In en, this message translates to:
  /// **'Phone Pickups'**
  String get phonePickups;

  /// No description provided for @pickupsToday.
  ///
  /// In en, this message translates to:
  /// **'Picked up {count} times today'**
  String pickupsToday(int count);

  /// No description provided for @topTriggers.
  ///
  /// In en, this message translates to:
  /// **'Top Triggers'**
  String get topTriggers;

  /// No description provided for @longestOffScreen.
  ///
  /// In en, this message translates to:
  /// **'Longest Offline'**
  String get longestOffScreen;

  /// No description provided for @dailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily Goal'**
  String get dailyGoal;

  /// No description provided for @goalHours.
  ///
  /// In en, this message translates to:
  /// **'Goal: {count} hours'**
  String goalHours(int count);

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String streakDays(int count);

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @badges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badges;

  /// No description provided for @duels.
  ///
  /// In en, this message translates to:
  /// **'Duels'**
  String get duels;

  /// No description provided for @activeDuels.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeDuels;

  /// No description provided for @pastDuels.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get pastDuels;

  /// No description provided for @createDuel.
  ///
  /// In en, this message translates to:
  /// **'Create Duel'**
  String get createDuel;

  /// No description provided for @startDuel.
  ///
  /// In en, this message translates to:
  /// **'Start Duel'**
  String get startDuel;

  /// No description provided for @invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get invite;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @win.
  ///
  /// In en, this message translates to:
  /// **'Won'**
  String get win;

  /// No description provided for @lose.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get lose;

  /// No description provided for @draw.
  ///
  /// In en, this message translates to:
  /// **'Draw'**
  String get draw;

  /// No description provided for @addFriend.
  ///
  /// In en, this message translates to:
  /// **'Add Friend'**
  String get addFriend;

  /// No description provided for @friendCode.
  ///
  /// In en, this message translates to:
  /// **'Friend Code'**
  String get friendCode;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @dailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminder'**
  String get dailyReminder;

  /// No description provided for @duelNotifications.
  ///
  /// In en, this message translates to:
  /// **'Duel Notifications'**
  String get duelNotifications;

  /// No description provided for @locationSharing.
  ///
  /// In en, this message translates to:
  /// **'Location Sharing'**
  String get locationSharing;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @pro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get pro;

  /// No description provided for @proPlus.
  ///
  /// In en, this message translates to:
  /// **'Pro+'**
  String get proPlus;

  /// No description provided for @currentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @upgradeToPro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// No description provided for @upgradeToProPlus.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro+'**
  String get upgradeToProPlus;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @monthlyPrice.
  ///
  /// In en, this message translates to:
  /// **'{price}/mo'**
  String monthlyPrice(String price);

  /// No description provided for @freeFeature1.
  ///
  /// In en, this message translates to:
  /// **'Daily screen time tracking'**
  String get freeFeature1;

  /// No description provided for @freeFeature2.
  ///
  /// In en, this message translates to:
  /// **'Friend leaderboards'**
  String get freeFeature2;

  /// No description provided for @freeFeature3.
  ///
  /// In en, this message translates to:
  /// **'3 active duels'**
  String get freeFeature3;

  /// No description provided for @freeFeature4.
  ///
  /// In en, this message translates to:
  /// **'Basic badges'**
  String get freeFeature4;

  /// No description provided for @proFeature1.
  ///
  /// In en, this message translates to:
  /// **'All leaderboards (city, country, global)'**
  String get proFeature1;

  /// No description provided for @proFeature2.
  ///
  /// In en, this message translates to:
  /// **'Detailed stats & focus calendar'**
  String get proFeature2;

  /// No description provided for @proFeature3.
  ///
  /// In en, this message translates to:
  /// **'Unlimited duels'**
  String get proFeature3;

  /// No description provided for @proFeature4.
  ///
  /// In en, this message translates to:
  /// **'Off-Grid Passes included'**
  String get proFeature4;

  /// No description provided for @proFeature5.
  ///
  /// In en, this message translates to:
  /// **'Ad-free experience'**
  String get proFeature5;

  /// No description provided for @proPlusFeature1.
  ///
  /// In en, this message translates to:
  /// **'Everything in Pro'**
  String get proPlusFeature1;

  /// No description provided for @proPlusFeature2.
  ///
  /// In en, this message translates to:
  /// **'Family plan (5 people)'**
  String get proPlusFeature2;

  /// No description provided for @proPlusFeature3.
  ///
  /// In en, this message translates to:
  /// **'Priority support'**
  String get proPlusFeature3;

  /// No description provided for @proPlusFeature4.
  ///
  /// In en, this message translates to:
  /// **'Exclusive badges & themes'**
  String get proPlusFeature4;

  /// No description provided for @proPlusFeature5.
  ///
  /// In en, this message translates to:
  /// **'Early access to beta features'**
  String get proPlusFeature5;

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Off-Grid Club'**
  String get paywallTitle;

  /// No description provided for @paywallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get rewarded for disconnecting.'**
  String get paywallSubtitle;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @shareProfile.
  ///
  /// In en, this message translates to:
  /// **'Share Profile'**
  String get shareProfile;

  /// No description provided for @shareReportCard.
  ///
  /// In en, this message translates to:
  /// **'Drop the Air'**
  String get shareReportCard;

  /// No description provided for @appUsage.
  ///
  /// In en, this message translates to:
  /// **'App Usage'**
  String get appUsage;

  /// No description provided for @whatDidYouUse.
  ///
  /// In en, this message translates to:
  /// **'What did you use today?'**
  String get whatDidYouUse;

  /// No description provided for @weeklyReport.
  ///
  /// In en, this message translates to:
  /// **'Weekly Report'**
  String get weeklyReport;

  /// No description provided for @weeklyTrend.
  ///
  /// In en, this message translates to:
  /// **'7-Day Trend'**
  String get weeklyTrend;

  /// No description provided for @seasons.
  ///
  /// In en, this message translates to:
  /// **'Seasons'**
  String get seasons;

  /// No description provided for @seasonPass.
  ///
  /// In en, this message translates to:
  /// **'Off-Grid Passes'**
  String get seasonPass;

  /// No description provided for @groups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groups;

  /// No description provided for @createGroup.
  ///
  /// In en, this message translates to:
  /// **'Create Group'**
  String get createGroup;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @detailedAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Detailed Analytics'**
  String get detailedAnalytics;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @weeklyUsage.
  ///
  /// In en, this message translates to:
  /// **'Weekly Usage'**
  String get weeklyUsage;

  /// No description provided for @appDetails.
  ///
  /// In en, this message translates to:
  /// **'App Details'**
  String get appDetails;

  /// No description provided for @focusCalendar.
  ///
  /// In en, this message translates to:
  /// **'Focus Calendar'**
  String get focusCalendar;

  /// No description provided for @whatIf.
  ///
  /// In en, this message translates to:
  /// **'What If?'**
  String get whatIf;

  /// No description provided for @focusMode.
  ///
  /// In en, this message translates to:
  /// **'Breathe'**
  String get focusMode;

  /// No description provided for @startFocusMode.
  ///
  /// In en, this message translates to:
  /// **'Start Focus Mode'**
  String get startFocusMode;

  /// No description provided for @focusing.
  ///
  /// In en, this message translates to:
  /// **'You\'re focusing...'**
  String get focusing;

  /// No description provided for @focusComplete.
  ///
  /// In en, this message translates to:
  /// **'Great! You focused for {minutes} min'**
  String focusComplete(int minutes);

  /// No description provided for @focusTimeout.
  ///
  /// In en, this message translates to:
  /// **'Session Timeout'**
  String get focusTimeout;

  /// No description provided for @focusTimeoutDesc.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the 120-minute limit.\nStill there?'**
  String get focusTimeoutDesc;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @reportCard.
  ///
  /// In en, this message translates to:
  /// **'Report Card'**
  String get reportCard;

  /// No description provided for @antiSocialStory.
  ///
  /// In en, this message translates to:
  /// **'Anti-Social Moment'**
  String get antiSocialStory;

  /// No description provided for @storyQuestion.
  ///
  /// In en, this message translates to:
  /// **'What are you doing away from your phone?'**
  String get storyQuestion;

  /// No description provided for @postStory.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get postStory;

  /// No description provided for @storyExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get storyExpired;

  /// No description provided for @noStories.
  ///
  /// In en, this message translates to:
  /// **'No stories yet'**
  String get noStories;

  /// No description provided for @noStoriesHint.
  ///
  /// In en, this message translates to:
  /// **'Let your friends start sharing their off-grid moments!'**
  String get noStoriesHint;

  /// No description provided for @storyBlocked.
  ///
  /// In en, this message translates to:
  /// **'Can\'t Share a Story'**
  String get storyBlocked;

  /// No description provided for @storyBlockedHint.
  ///
  /// In en, this message translates to:
  /// **'You\'ve exceeded your daily screen time goal. Stay on track to earn the right to share stories!'**
  String get storyBlockedHint;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @walk.
  ///
  /// In en, this message translates to:
  /// **'Walk'**
  String get walk;

  /// No description provided for @run.
  ///
  /// In en, this message translates to:
  /// **'Run'**
  String get run;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @meditation.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get meditation;

  /// No description provided for @nature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get nature;

  /// No description provided for @sports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sports;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @cooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking'**
  String get cooking;

  /// No description provided for @friendsActivity.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friendsActivity;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @o2Balance.
  ///
  /// In en, this message translates to:
  /// **'O₂ Points'**
  String get o2Balance;

  /// No description provided for @o2Remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining: {count}'**
  String o2Remaining(int count);

  /// No description provided for @o2Today.
  ///
  /// In en, this message translates to:
  /// **'Today: {earned}/{max} O₂'**
  String o2Today(int earned, int max);

  /// No description provided for @o2Rules.
  ///
  /// In en, this message translates to:
  /// **'O₂ Rules'**
  String get o2Rules;

  /// No description provided for @o2RuleTime.
  ///
  /// In en, this message translates to:
  /// **'Earned only between 08:00–00:00'**
  String get o2RuleTime;

  /// No description provided for @o2RuleDaily.
  ///
  /// In en, this message translates to:
  /// **'Max 500 O₂ per day'**
  String get o2RuleDaily;

  /// No description provided for @o2RuleFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus mode max 120 min'**
  String get o2RuleFocus;

  /// No description provided for @o2RuleTransfer.
  ///
  /// In en, this message translates to:
  /// **'No transfers or wagering'**
  String get o2RuleTransfer;

  /// No description provided for @o2Estimated.
  ///
  /// In en, this message translates to:
  /// **'+{amount} O₂ (estimated)'**
  String o2Estimated(int amount);

  /// No description provided for @offGridMarket.
  ///
  /// In en, this message translates to:
  /// **'Loot'**
  String get offGridMarket;

  /// No description provided for @offGridMarketHint.
  ///
  /// In en, this message translates to:
  /// **'Turn O₂ points into real-world loot'**
  String get offGridMarketHint;

  /// No description provided for @redeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get redeem;

  /// No description provided for @insufficient.
  ///
  /// In en, this message translates to:
  /// **'Insufficient'**
  String get insufficient;

  /// No description provided for @redeemSuccess.
  ///
  /// In en, this message translates to:
  /// **'Congrats!'**
  String get redeemSuccess;

  /// No description provided for @couponCode.
  ///
  /// In en, this message translates to:
  /// **'Your coupon code:'**
  String get couponCode;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactions;

  /// No description provided for @categorySocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get categorySocial;

  /// No description provided for @categoryGame.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get categoryGame;

  /// No description provided for @categoryVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get categoryVideo;

  /// No description provided for @categoryAudio.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get categoryAudio;

  /// No description provided for @categoryProductivity.
  ///
  /// In en, this message translates to:
  /// **'Productivity'**
  String get categoryProductivity;

  /// No description provided for @categoryNews.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get categoryNews;

  /// No description provided for @categoryGames.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get categoryGames;

  /// No description provided for @categoryShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get categoryShopping;

  /// No description provided for @categoryBrowser.
  ///
  /// In en, this message translates to:
  /// **'Browser'**
  String get categoryBrowser;

  /// No description provided for @categoryMaps.
  ///
  /// In en, this message translates to:
  /// **'Maps'**
  String get categoryMaps;

  /// No description provided for @categoryImage.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get categoryImage;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String hello(String name);

  /// No description provided for @goalCompleted.
  ///
  /// In en, this message translates to:
  /// **'Goal completed!'**
  String get goalCompleted;

  /// No description provided for @dailyGoalShort.
  ///
  /// In en, this message translates to:
  /// **'Daily goal'**
  String get dailyGoalShort;

  /// No description provided for @streakDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get streakDaysLabel;

  /// No description provided for @o2Label.
  ///
  /// In en, this message translates to:
  /// **'O₂'**
  String get o2Label;

  /// No description provided for @rankLabel.
  ///
  /// In en, this message translates to:
  /// **'rank'**
  String get rankLabel;

  /// No description provided for @offlineLabel.
  ///
  /// In en, this message translates to:
  /// **'offline'**
  String get offlineLabel;

  /// No description provided for @todaysApps.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Apps'**
  String get todaysApps;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @activeDuel.
  ///
  /// In en, this message translates to:
  /// **'Active Duel'**
  String get activeDuel;

  /// No description provided for @startDuelPrompt.
  ///
  /// In en, this message translates to:
  /// **'Start a duel!'**
  String get startDuelPrompt;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @moreCount.
  ///
  /// In en, this message translates to:
  /// **'+{count} more'**
  String moreCount(int count);

  /// No description provided for @removeWithPro.
  ///
  /// In en, this message translates to:
  /// **'Remove with Pro'**
  String get removeWithPro;

  /// No description provided for @adLabel.
  ///
  /// In en, this message translates to:
  /// **'Ad'**
  String get adLabel;

  /// No description provided for @focus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get focus;

  /// No description provided for @legal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legal;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @kvkkText.
  ///
  /// In en, this message translates to:
  /// **'KVKK Privacy Notice'**
  String get kvkkText;

  /// No description provided for @deleteMyAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete My Account'**
  String get deleteMyAccount;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @adminAddLoot.
  ///
  /// In en, this message translates to:
  /// **'Admin: Add Loot'**
  String get adminAddLoot;

  /// No description provided for @continueConsent.
  ///
  /// In en, this message translates to:
  /// **'By continuing you'**
  String get continueConsent;

  /// No description provided for @acceptTermsSuffix.
  ///
  /// In en, this message translates to:
  /// **'accept.'**
  String get acceptTermsSuffix;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get alreadyHaveAccount;

  /// No description provided for @screenTimePermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'We need to track your screen time'**
  String get screenTimePermissionTitle;

  /// No description provided for @screenTimePermissionDesc.
  ///
  /// In en, this message translates to:
  /// **'Screen time access is required to see how much time you spend on each app.'**
  String get screenTimePermissionDesc;

  /// No description provided for @screenTimeGranted.
  ///
  /// In en, this message translates to:
  /// **'Screen time permission granted!'**
  String get screenTimeGranted;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get nameHint;

  /// No description provided for @ageGroup.
  ///
  /// In en, this message translates to:
  /// **'Age Group'**
  String get ageGroup;

  /// No description provided for @imReady.
  ///
  /// In en, this message translates to:
  /// **'I\'m Ready'**
  String get imReady;

  /// No description provided for @dailyGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Daily Goal'**
  String get dailyGoalTitle;

  /// No description provided for @goalQuestion.
  ///
  /// In en, this message translates to:
  /// **'How many hours of screen time do you aim for daily?'**
  String get goalQuestion;

  /// No description provided for @goalMotivational1.
  ///
  /// In en, this message translates to:
  /// **'Amazing! A real digital detox goal 💪'**
  String get goalMotivational1;

  /// No description provided for @goalMotivational2.
  ///
  /// In en, this message translates to:
  /// **'A balanced goal, you can do it! 🎯'**
  String get goalMotivational2;

  /// No description provided for @goalMotivational3.
  ///
  /// In en, this message translates to:
  /// **'A good start, you can reduce over time 📉'**
  String get goalMotivational3;

  /// No description provided for @goalMotivational4.
  ///
  /// In en, this message translates to:
  /// **'Step by step, every minute counts ⭐'**
  String get goalMotivational4;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @hourShort.
  ///
  /// In en, this message translates to:
  /// **'{count}h'**
  String hourShort(int count);

  /// No description provided for @welcomeSlogan.
  ///
  /// In en, this message translates to:
  /// **'Put down your phone. Beat your friends.\nBe #1 in your city.'**
  String get welcomeSlogan;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Your account and all data will be permanently deleted. This action cannot be undone.'**
  String get deleteAccountConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load'**
  String get loadFailed;

  /// No description provided for @noDataYet.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get noDataYet;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Put down your phone. Beat your friends.'**
  String get welcomeSubtitle;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @continueWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue with Email'**
  String get continueWithEmail;

  /// No description provided for @permissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissionsTitle;

  /// No description provided for @permissionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We need permission to track your screen time.'**
  String get permissionsSubtitle;

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get grantPermission;

  /// No description provided for @setupProfile.
  ///
  /// In en, this message translates to:
  /// **'Setup Profile'**
  String get setupProfile;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @selectCity.
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get selectCity;

  /// No description provided for @selectGoal.
  ///
  /// In en, this message translates to:
  /// **'Select Daily Goal'**
  String get selectGoal;

  /// No description provided for @noDuelsYet.
  ///
  /// In en, this message translates to:
  /// **'No duels yet'**
  String get noDuelsYet;

  /// No description provided for @noDuelsYetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start your first duel!'**
  String get noDuelsYetSubtitle;

  /// No description provided for @activeDuelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Active Duels'**
  String get activeDuelsTitle;

  /// No description provided for @newDuel.
  ///
  /// In en, this message translates to:
  /// **'New Duel'**
  String get newDuel;

  /// No description provided for @selectDuelType.
  ///
  /// In en, this message translates to:
  /// **'Select Duel Type'**
  String get selectDuelType;

  /// No description provided for @selectDurationStep.
  ///
  /// In en, this message translates to:
  /// **'Select Duration'**
  String get selectDurationStep;

  /// No description provided for @selectOpponent.
  ///
  /// In en, this message translates to:
  /// **'Select Opponent'**
  String get selectOpponent;

  /// No description provided for @duelStartButton.
  ///
  /// In en, this message translates to:
  /// **'Start Duel! ⚔️'**
  String get duelStartButton;

  /// No description provided for @freePlanDuelLimit.
  ///
  /// In en, this message translates to:
  /// **'Free plan allows max 3 active duels! Upgrade to Pro.'**
  String get freePlanDuelLimit;

  /// No description provided for @quickSelect.
  ///
  /// In en, this message translates to:
  /// **'Quick Select'**
  String get quickSelect;

  /// No description provided for @customDuration.
  ///
  /// In en, this message translates to:
  /// **'Custom Duration'**
  String get customDuration;

  /// No description provided for @selectedDuration.
  ///
  /// In en, this message translates to:
  /// **'Selected: {duration}'**
  String selectedDuration(String duration);

  /// No description provided for @minDurationWarning.
  ///
  /// In en, this message translates to:
  /// **'You must select at least 10 minutes'**
  String get minDurationWarning;

  /// No description provided for @selectPenalty.
  ///
  /// In en, this message translates to:
  /// **'Select Penalty (optional)'**
  String get selectPenalty;

  /// No description provided for @searchFriend.
  ///
  /// In en, this message translates to:
  /// **'Search friend...'**
  String get searchFriend;

  /// No description provided for @inviteWithLink.
  ///
  /// In en, this message translates to:
  /// **'Invite with Link 🔗'**
  String get inviteWithLink;

  /// No description provided for @todayMinutesLabel.
  ///
  /// In en, this message translates to:
  /// **'{count}min today'**
  String todayMinutesLabel(int count);

  /// No description provided for @duelRemaining.
  ///
  /// In en, this message translates to:
  /// **'{h}h {m}m left'**
  String duelRemaining(int h, int m);

  /// No description provided for @remainingTime.
  ///
  /// In en, this message translates to:
  /// **'Time Remaining'**
  String get remainingTime;

  /// No description provided for @watchersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} watching 👀'**
  String watchersCount(int count);

  /// No description provided for @giveUp.
  ///
  /// In en, this message translates to:
  /// **'Give Up'**
  String get giveUp;

  /// No description provided for @duelWon.
  ///
  /// In en, this message translates to:
  /// **'You Won! 🎉'**
  String get duelWon;

  /// No description provided for @duelLost.
  ///
  /// In en, this message translates to:
  /// **'You Lost 😔'**
  String get duelLost;

  /// No description provided for @greatPerformance.
  ///
  /// In en, this message translates to:
  /// **'Great performance!'**
  String get greatPerformance;

  /// No description provided for @betterNextTime.
  ///
  /// In en, this message translates to:
  /// **'Better luck next time!'**
  String get betterNextTime;

  /// No description provided for @revenge.
  ///
  /// In en, this message translates to:
  /// **'Get Revenge 🔥'**
  String get revenge;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @selectFriend.
  ///
  /// In en, this message translates to:
  /// **'Select Friend'**
  String get selectFriend;

  /// No description provided for @orSendLink.
  ///
  /// In en, this message translates to:
  /// **'or Send Link'**
  String get orSendLink;

  /// No description provided for @social.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get social;

  /// No description provided for @myFriends.
  ///
  /// In en, this message translates to:
  /// **'My Friends'**
  String get myFriends;

  /// No description provided for @inMyCity.
  ///
  /// In en, this message translates to:
  /// **'In My City'**
  String get inMyCity;

  /// No description provided for @shareFirstStory.
  ///
  /// In en, this message translates to:
  /// **'Be the first to share your off-grid moment!'**
  String get shareFirstStory;

  /// No description provided for @createStoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Story'**
  String get createStoryTitle;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @whatAreYouDoing.
  ///
  /// In en, this message translates to:
  /// **'What are you doing?'**
  String get whatAreYouDoing;

  /// No description provided for @captionHint.
  ///
  /// In en, this message translates to:
  /// **'What are you doing away from your phone?'**
  String get captionHint;

  /// No description provided for @howLongVisible.
  ///
  /// In en, this message translates to:
  /// **'How long should it be visible?'**
  String get howLongVisible;

  /// No description provided for @whoCanSee.
  ///
  /// In en, this message translates to:
  /// **'Who can see it?'**
  String get whoCanSee;

  /// No description provided for @onlyFriends.
  ///
  /// In en, this message translates to:
  /// **'Only My Friends'**
  String get onlyFriends;

  /// No description provided for @cityPeople.
  ///
  /// In en, this message translates to:
  /// **'People in My City'**
  String get cityPeople;

  /// No description provided for @photoStoriesPro.
  ///
  /// In en, this message translates to:
  /// **'Photo stories are Pro! Settings > Off-Grid Club'**
  String get photoStoriesPro;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @writeFirst.
  ///
  /// In en, this message translates to:
  /// **'Write something first!'**
  String get writeFirst;

  /// No description provided for @inappropriateContent.
  ///
  /// In en, this message translates to:
  /// **'Inappropriate content detected'**
  String get inappropriateContent;

  /// No description provided for @viewsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} views'**
  String viewsCount(int count);

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your first name'**
  String get firstNameHint;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your last name'**
  String get lastNameHint;

  /// No description provided for @usernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// No description provided for @updateLocation.
  ///
  /// In en, this message translates to:
  /// **'Update Location'**
  String get updateLocation;

  /// No description provided for @locationUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get locationUnknown;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @usernameAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get usernameAvailable;

  /// No description provided for @usernameTaken.
  ///
  /// In en, this message translates to:
  /// **'This username is taken'**
  String get usernameTaken;

  /// No description provided for @usernameFormatError.
  ///
  /// In en, this message translates to:
  /// **'At least 3 characters, only letters, numbers and _'**
  String get usernameFormatError;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileUpdated;

  /// No description provided for @photoSelectedDemo.
  ///
  /// In en, this message translates to:
  /// **'Photo selected (won\'t upload in demo mode)'**
  String get photoSelectedDemo;

  /// No description provided for @locationError.
  ///
  /// In en, this message translates to:
  /// **'Could not get location'**
  String get locationError;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @detailedScreenTime.
  ///
  /// In en, this message translates to:
  /// **'Detailed Screen Time'**
  String get detailedScreenTime;

  /// No description provided for @monthlyTop10.
  ///
  /// In en, this message translates to:
  /// **'Monthly Top 10'**
  String get monthlyTop10;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @noFriendsYet.
  ///
  /// In en, this message translates to:
  /// **'No friends yet'**
  String get noFriendsYet;

  /// No description provided for @noFriendsHint.
  ///
  /// In en, this message translates to:
  /// **'Start by adding a friend'**
  String get noFriendsHint;

  /// No description provided for @showQrCode.
  ///
  /// In en, this message translates to:
  /// **'Show your QR code'**
  String get showQrCode;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Code'**
  String get enterCode;

  /// No description provided for @inviteLinkShare.
  ///
  /// In en, this message translates to:
  /// **'Share Invite Link'**
  String get inviteLinkShare;

  /// No description provided for @startDuelAction.
  ///
  /// In en, this message translates to:
  /// **'Start Duel'**
  String get startDuelAction;

  /// No description provided for @pointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get pointsLabel;

  /// No description provided for @mostUsedLabel.
  ///
  /// In en, this message translates to:
  /// **'Most used:'**
  String get mostUsedLabel;

  /// No description provided for @recentBadges.
  ///
  /// In en, this message translates to:
  /// **'Recent Badges'**
  String get recentBadges;

  /// No description provided for @allBadgesLabel.
  ///
  /// In en, this message translates to:
  /// **'All Badges'**
  String get allBadgesLabel;

  /// No description provided for @removeFriend.
  ///
  /// In en, this message translates to:
  /// **'Remove Friend'**
  String get removeFriend;

  /// No description provided for @removeFriendConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this person from your friends list?'**
  String get removeFriendConfirm;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Request Sent'**
  String get requestSent;

  /// No description provided for @whatCouldYouDo.
  ///
  /// In en, this message translates to:
  /// **'What Could You Have Done?'**
  String get whatCouldYouDo;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @mostUsedApps.
  ///
  /// In en, this message translates to:
  /// **'Most Used Apps'**
  String get mostUsedApps;

  /// No description provided for @unlockSection.
  ///
  /// In en, this message translates to:
  /// **'Unlocks'**
  String get unlockSection;

  /// No description provided for @selectedDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected Day'**
  String get selectedDayLabel;

  /// No description provided for @todayLabel.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayLabel;

  /// No description provided for @weeklyAvgLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily avg: {h}h {m}m'**
  String weeklyAvgLabel(int h, int m);

  /// No description provided for @firstUnlock.
  ///
  /// In en, this message translates to:
  /// **'First Unlock'**
  String get firstUnlock;

  /// No description provided for @mostOpened.
  ///
  /// In en, this message translates to:
  /// **'Most Opened'**
  String get mostOpened;

  /// No description provided for @timesPickedUp.
  ///
  /// In en, this message translates to:
  /// **'Times Picked Up'**
  String get timesPickedUp;

  /// No description provided for @openingCount.
  ///
  /// In en, this message translates to:
  /// **'opens'**
  String get openingCount;

  /// No description provided for @notificationUnit.
  ///
  /// In en, this message translates to:
  /// **'notifications'**
  String get notificationUnit;

  /// No description provided for @timesUnit.
  ///
  /// In en, this message translates to:
  /// **'times'**
  String get timesUnit;

  /// No description provided for @turkey.
  ///
  /// In en, this message translates to:
  /// **'Türkiye'**
  String get turkey;

  /// No description provided for @consecutiveDays.
  ///
  /// In en, this message translates to:
  /// **'days in a row'**
  String get consecutiveDays;

  /// No description provided for @bestStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Best: {days} days'**
  String bestStreakLabel(int days);

  /// No description provided for @seriFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get seriFriends;

  /// No description provided for @oxygenTitle.
  ///
  /// In en, this message translates to:
  /// **'Oxygen (O₂)'**
  String get oxygenTitle;

  /// No description provided for @totalO2.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalO2;

  /// No description provided for @remainingShort.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remainingShort;

  /// No description provided for @noOffersYet.
  ///
  /// In en, this message translates to:
  /// **'No offers yet'**
  String get noOffersYet;

  /// No description provided for @o2SpentMsg.
  ///
  /// In en, this message translates to:
  /// **'{amount} O₂ spent'**
  String o2SpentMsg(int amount);

  /// No description provided for @mapLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load map'**
  String get mapLoadFailed;

  /// No description provided for @confirmRedeemMsg.
  ///
  /// In en, this message translates to:
  /// **'Do you want to redeem {reward}?'**
  String confirmRedeemMsg(String reward);

  /// No description provided for @itemReceived.
  ///
  /// In en, this message translates to:
  /// **'{item} redeemed!'**
  String itemReceived(String item);

  /// No description provided for @insufficientO2.
  ///
  /// In en, this message translates to:
  /// **'Insufficient O₂'**
  String get insufficientO2;

  /// No description provided for @season1Title.
  ///
  /// In en, this message translates to:
  /// **'Season 1'**
  String get season1Title;

  /// No description provided for @season1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Spring Awakening'**
  String get season1Subtitle;

  /// No description provided for @seasonPassBtn.
  ///
  /// In en, this message translates to:
  /// **'Season Pass (99TL)'**
  String get seasonPassBtn;

  /// No description provided for @seasonPassLabel.
  ///
  /// In en, this message translates to:
  /// **'Season Pass'**
  String get seasonPassLabel;

  /// No description provided for @noGroupsYet.
  ///
  /// In en, this message translates to:
  /// **'No groups yet'**
  String get noGroupsYet;

  /// No description provided for @noGroupsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a group with your friends'**
  String get noGroupsSubtitle;

  /// No description provided for @newGroup.
  ///
  /// In en, this message translates to:
  /// **'New Group'**
  String get newGroup;

  /// No description provided for @memberCount.
  ///
  /// In en, this message translates to:
  /// **'{count} members'**
  String memberCount(int count);

  /// No description provided for @weeklyGoal.
  ///
  /// In en, this message translates to:
  /// **'Weekly Goal'**
  String get weeklyGoal;

  /// No description provided for @challengeProgress.
  ///
  /// In en, this message translates to:
  /// **'{percent}% completed'**
  String challengeProgress(int percent);

  /// No description provided for @membersLabel.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get membersLabel;

  /// No description provided for @inviteLink.
  ///
  /// In en, this message translates to:
  /// **'Invite Link'**
  String get inviteLink;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied!'**
  String get linkCopied;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qrCode;

  /// No description provided for @groupNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Group Name'**
  String get groupNameLabel;

  /// No description provided for @groupNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter group name'**
  String get groupNameHint;

  /// No description provided for @groupNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Group name cannot be empty'**
  String get groupNameEmpty;

  /// No description provided for @dailyGoalHours.
  ///
  /// In en, this message translates to:
  /// **'Daily Goal: {hours} hours'**
  String dailyGoalHours(int hours);

  /// No description provided for @addMember.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get addMember;

  /// No description provided for @selectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedCount(int count);

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @groupCreated.
  ///
  /// In en, this message translates to:
  /// **'{name} created!'**
  String groupCreated(String name);

  /// No description provided for @invitedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} people invited'**
  String invitedCount(int count);

  /// No description provided for @screenTimeLower.
  ///
  /// In en, this message translates to:
  /// **'screen time'**
  String get screenTimeLower;

  /// No description provided for @improvedFromLastWeek.
  ///
  /// In en, this message translates to:
  /// **'12% better than last week'**
  String get improvedFromLastWeek;

  /// No description provided for @o2Earned.
  ///
  /// In en, this message translates to:
  /// **'O₂ Earned'**
  String get o2Earned;

  /// No description provided for @friendRank.
  ///
  /// In en, this message translates to:
  /// **'Friend Rank'**
  String get friendRank;

  /// No description provided for @cityRankLabel.
  ///
  /// In en, this message translates to:
  /// **'{city} Rank'**
  String cityRankLabel(String city);

  /// No description provided for @mostUsed.
  ///
  /// In en, this message translates to:
  /// **'Most used'**
  String get mostUsed;

  /// No description provided for @offGridClub.
  ///
  /// In en, this message translates to:
  /// **'Off-Grid Club'**
  String get offGridClub;

  /// No description provided for @clubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Achieve digital balance, get rewarded.'**
  String get clubSubtitle;

  /// No description provided for @planStarter.
  ///
  /// In en, this message translates to:
  /// **'Starter'**
  String get planStarter;

  /// No description provided for @planStarterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start with the basics'**
  String get planStarterSubtitle;

  /// No description provided for @currentPlanBtn.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlanBtn;

  /// No description provided for @billingMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get billingMonthly;

  /// No description provided for @billingYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get billingYearly;

  /// No description provided for @yearlySavings.
  ///
  /// In en, this message translates to:
  /// **'33% off'**
  String get yearlySavings;

  /// No description provided for @planComparison.
  ///
  /// In en, this message translates to:
  /// **'Plan Comparison'**
  String get planComparison;

  /// No description provided for @breathTechniquesComp.
  ///
  /// In en, this message translates to:
  /// **'Breath techniques'**
  String get breathTechniquesComp;

  /// No description provided for @activeDuelsComp.
  ///
  /// In en, this message translates to:
  /// **'Active duels'**
  String get activeDuelsComp;

  /// No description provided for @storyPhoto.
  ///
  /// In en, this message translates to:
  /// **'Story photo'**
  String get storyPhoto;

  /// No description provided for @heatMap.
  ///
  /// In en, this message translates to:
  /// **'Heat map'**
  String get heatMap;

  /// No description provided for @top10Report.
  ///
  /// In en, this message translates to:
  /// **'Top 10 report'**
  String get top10Report;

  /// No description provided for @exclusiveBadges.
  ///
  /// In en, this message translates to:
  /// **'Exclusive badges'**
  String get exclusiveBadges;

  /// No description provided for @adFree.
  ///
  /// In en, this message translates to:
  /// **'Ad-free'**
  String get adFree;

  /// No description provided for @familyPlanComp.
  ///
  /// In en, this message translates to:
  /// **'Family plan'**
  String get familyPlanComp;

  /// No description provided for @familyReport.
  ///
  /// In en, this message translates to:
  /// **'Family report'**
  String get familyReport;

  /// No description provided for @exclusiveThemes.
  ///
  /// In en, this message translates to:
  /// **'Exclusive themes'**
  String get exclusiveThemes;

  /// No description provided for @prioritySupport.
  ///
  /// In en, this message translates to:
  /// **'Priority support'**
  String get prioritySupport;

  /// No description provided for @billingNote.
  ///
  /// In en, this message translates to:
  /// **'Subscription can be cancelled anytime.\nPayment processed via App Store/Google Play.\nSubscription auto-renews at end of period.'**
  String get billingNote;

  /// No description provided for @restoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored!'**
  String get restoreSuccess;

  /// No description provided for @restoreFailed.
  ///
  /// In en, this message translates to:
  /// **'No purchases found to restore.'**
  String get restoreFailed;

  /// No description provided for @packagesLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load packages. Please try again.'**
  String get packagesLoadFailed;

  /// No description provided for @themesTitle.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get themesTitle;

  /// No description provided for @themeLockedMsg.
  ///
  /// In en, this message translates to:
  /// **'This theme is Pro+! Settings > Off-Grid Club'**
  String get themeLockedMsg;

  /// No description provided for @familyPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Plan'**
  String get familyPlanTitle;

  /// No description provided for @familyPlanLocked.
  ///
  /// In en, this message translates to:
  /// **'Digital Balance Together'**
  String get familyPlanLocked;

  /// No description provided for @familyPlanLockedDesc.
  ///
  /// In en, this message translates to:
  /// **'Add up to 5 family members, set goals together and get weekly family reports.'**
  String get familyPlanLockedDesc;

  /// No description provided for @weeklyFamilyReport.
  ///
  /// In en, this message translates to:
  /// **'Weekly Family Report'**
  String get weeklyFamilyReport;

  /// No description provided for @familyRanking.
  ///
  /// In en, this message translates to:
  /// **'Family Ranking'**
  String get familyRanking;

  /// No description provided for @totalOffline.
  ///
  /// In en, this message translates to:
  /// **'Total Offline'**
  String get totalOffline;

  /// No description provided for @average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get average;

  /// No description provided for @best.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get best;

  /// No description provided for @offlineTime.
  ///
  /// In en, this message translates to:
  /// **'{h}h {m}m offline'**
  String offlineTime(int h, int m);

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter name'**
  String get enterName;

  /// No description provided for @cannotUndo.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone!'**
  String get cannotUndo;

  /// No description provided for @deleteWarningDesc.
  ///
  /// In en, this message translates to:
  /// **'When you delete your account, the following data will be permanently deleted:'**
  String get deleteWarningDesc;

  /// No description provided for @deleteItem1.
  ///
  /// In en, this message translates to:
  /// **'Profile info and avatar'**
  String get deleteItem1;

  /// No description provided for @deleteItem2.
  ///
  /// In en, this message translates to:
  /// **'All screen time statistics'**
  String get deleteItem2;

  /// No description provided for @deleteItem3.
  ///
  /// In en, this message translates to:
  /// **'Friend list and duels'**
  String get deleteItem3;

  /// No description provided for @deleteItem4.
  ///
  /// In en, this message translates to:
  /// **'Stories and comments'**
  String get deleteItem4;

  /// No description provided for @deleteItem5.
  ///
  /// In en, this message translates to:
  /// **'O₂ points and loot'**
  String get deleteItem5;

  /// No description provided for @deleteItem6.
  ///
  /// In en, this message translates to:
  /// **'Subscription history'**
  String get deleteItem6;

  /// No description provided for @deleteSubscriptionNote.
  ///
  /// In en, this message translates to:
  /// **'If you have an active subscription, you must cancel it first via Apple App Store or Google Play Store.'**
  String get deleteSubscriptionNote;

  /// No description provided for @deleteConfirmCheck.
  ///
  /// In en, this message translates to:
  /// **'I understand that my account and all data will be permanently deleted.'**
  String get deleteConfirmCheck;

  /// No description provided for @deleteAccountBtn.
  ///
  /// In en, this message translates to:
  /// **'Permanently Delete My Account'**
  String get deleteAccountBtn;

  /// No description provided for @deleteErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get deleteErrorMsg;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent.'**
  String get passwordResetSent;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @orDivider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get orDivider;

  /// No description provided for @continueWithGoogleShort.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogleShort;

  /// No description provided for @continueWithAppleShort.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithAppleShort;

  /// No description provided for @noAccountYet.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccountYet;

  /// No description provided for @adminExistingPoints.
  ///
  /// In en, this message translates to:
  /// **'Existing Points'**
  String get adminExistingPoints;

  /// No description provided for @adminSearchPlace.
  ///
  /// In en, this message translates to:
  /// **'Search place...'**
  String get adminSearchPlace;

  /// No description provided for @adminRewardTitle.
  ///
  /// In en, this message translates to:
  /// **'Reward Title (e.g. Free Coffee)'**
  String get adminRewardTitle;

  /// No description provided for @adminO2Cost.
  ///
  /// In en, this message translates to:
  /// **'O₂ Cost'**
  String get adminO2Cost;

  /// No description provided for @adminSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get adminSave;

  /// No description provided for @adminSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved!'**
  String get adminSaved;

  /// No description provided for @adminDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminDeleteTitle;

  /// No description provided for @adminDeleteMsg.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this point?'**
  String get adminDeleteMsg;

  /// No description provided for @adminDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Delete error: {error}'**
  String adminDeleteError(String error);

  /// No description provided for @adminFillFields.
  ///
  /// In en, this message translates to:
  /// **'Fill in reward and O₂ cost'**
  String get adminFillFields;

  /// No description provided for @breathCount.
  ///
  /// In en, this message translates to:
  /// **'{count} breaths'**
  String breathCount(int count);

  /// No description provided for @minutesRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count}min left'**
  String minutesRemaining(int count);

  /// No description provided for @focusMinutes.
  ///
  /// In en, this message translates to:
  /// **'You focused for {count} minutes'**
  String focusMinutes(int count);

  /// No description provided for @o2TimeRestriction.
  ///
  /// In en, this message translates to:
  /// **'O₂ earned only between 08:00–00:00'**
  String get o2TimeRestriction;

  /// No description provided for @breathTechniqueProMsg.
  ///
  /// In en, this message translates to:
  /// **'This technique is Pro! Settings > Off-Grid Club'**
  String get breathTechniqueProMsg;

  /// No description provided for @inhale.
  ///
  /// In en, this message translates to:
  /// **'In'**
  String get inhale;

  /// No description provided for @holdBreath.
  ///
  /// In en, this message translates to:
  /// **'Hold'**
  String get holdBreath;

  /// No description provided for @exhale.
  ///
  /// In en, this message translates to:
  /// **'Out'**
  String get exhale;

  /// No description provided for @waitBreath.
  ///
  /// In en, this message translates to:
  /// **'Wait'**
  String get waitBreath;

  /// No description provided for @proMostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get proMostPopular;

  /// No description provided for @proFamilyBadge.
  ///
  /// In en, this message translates to:
  /// **'FAMILY'**
  String get proFamilyBadge;

  /// No description provided for @comparedToLastWeek.
  ///
  /// In en, this message translates to:
  /// **'compared to last week'**
  String get comparedToLastWeek;

  /// No description provided for @appBlockTitle.
  ///
  /// In en, this message translates to:
  /// **'App Blocking'**
  String get appBlockTitle;

  /// No description provided for @appBlockSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get appBlockSchedule;

  /// No description provided for @appBlockEnableBlocking.
  ///
  /// In en, this message translates to:
  /// **'Enable Blocking'**
  String get appBlockEnableBlocking;

  /// No description provided for @appBlockActive.
  ///
  /// In en, this message translates to:
  /// **'Blocking is on'**
  String get appBlockActive;

  /// No description provided for @appBlockInactive.
  ///
  /// In en, this message translates to:
  /// **'Blocking is off'**
  String get appBlockInactive;

  /// No description provided for @appBlockStrictMode.
  ///
  /// In en, this message translates to:
  /// **'Strict Mode'**
  String get appBlockStrictMode;

  /// No description provided for @appBlockStrictDesc.
  ///
  /// In en, this message translates to:
  /// **'Cannot be disabled until timer ends'**
  String get appBlockStrictDesc;

  /// No description provided for @appBlockStrictExpired.
  ///
  /// In en, this message translates to:
  /// **'Timer expired'**
  String get appBlockStrictExpired;

  /// No description provided for @appBlockStrictDurationTitle.
  ///
  /// In en, this message translates to:
  /// **'Strict Mode Duration'**
  String get appBlockStrictDurationTitle;

  /// No description provided for @appBlockDuration30m.
  ///
  /// In en, this message translates to:
  /// **'30 minutes'**
  String get appBlockDuration30m;

  /// No description provided for @appBlockDuration1h.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get appBlockDuration1h;

  /// No description provided for @appBlockDuration2h.
  ///
  /// In en, this message translates to:
  /// **'2 hours'**
  String get appBlockDuration2h;

  /// No description provided for @appBlockDuration4h.
  ///
  /// In en, this message translates to:
  /// **'4 hours'**
  String get appBlockDuration4h;

  /// No description provided for @appBlockDurationAllDay.
  ///
  /// In en, this message translates to:
  /// **'All Day (24 hours)'**
  String get appBlockDurationAllDay;

  /// No description provided for @appBlockScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Block Schedule'**
  String get appBlockScheduleTitle;

  /// No description provided for @appBlockScheduleDesc.
  ///
  /// In en, this message translates to:
  /// **'Set daily time ranges'**
  String get appBlockScheduleDesc;

  /// No description provided for @appBlockBlockedApps.
  ///
  /// In en, this message translates to:
  /// **'Blocked Apps'**
  String get appBlockBlockedApps;

  /// No description provided for @appBlockNoApps.
  ///
  /// In en, this message translates to:
  /// **'No apps added yet'**
  String get appBlockNoApps;

  /// No description provided for @appBlockAddApp.
  ///
  /// In en, this message translates to:
  /// **'Add App'**
  String get appBlockAddApp;

  /// No description provided for @appBlockPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick App'**
  String get appBlockPickerTitle;

  /// No description provided for @appBlockPresetWork.
  ///
  /// In en, this message translates to:
  /// **'Work Hours (09-18)'**
  String get appBlockPresetWork;

  /// No description provided for @appBlockPresetSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep Time (23-07)'**
  String get appBlockPresetSleep;

  /// No description provided for @appBlockPresetAllDay.
  ///
  /// In en, this message translates to:
  /// **'All Day'**
  String get appBlockPresetAllDay;

  /// No description provided for @appBlockInterventionTitle.
  ///
  /// In en, this message translates to:
  /// **'Wait a second...'**
  String get appBlockInterventionTitle;

  /// No description provided for @appBlockInterventionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Take a breath and observe yourself'**
  String get appBlockInterventionSubtitle;

  /// No description provided for @appBlockInterventionGiveUp.
  ///
  /// In en, this message translates to:
  /// **'I\'ll pass'**
  String get appBlockInterventionGiveUp;

  /// No description provided for @appBlockInterventionOpenAnyway.
  ///
  /// In en, this message translates to:
  /// **'Open anyway'**
  String get appBlockInterventionOpenAnyway;

  /// No description provided for @appBlockStrictModeActive.
  ///
  /// In en, this message translates to:
  /// **'Strict mode — can\'t open'**
  String get appBlockStrictModeActive;

  /// No description provided for @appBlockStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'You spent {hours} hours on {app} this week'**
  String appBlockStatsTitle(String app, int hours);

  /// No description provided for @appBlockGaveUpCount.
  ///
  /// In en, this message translates to:
  /// **'You\'ve passed {count} times this month'**
  String appBlockGaveUpCount(int count);

  /// No description provided for @pickAppToBan.
  ///
  /// In en, this message translates to:
  /// **'Pick an app to ban'**
  String get pickAppToBan;

  /// No description provided for @pickAppToBanDesc.
  ///
  /// In en, this message translates to:
  /// **'Your opponent won\'t be able to open this app for 24 hours'**
  String get pickAppToBanDesc;

  /// No description provided for @pickCategory.
  ///
  /// In en, this message translates to:
  /// **'Pick a category'**
  String get pickCategory;

  /// No description provided for @pickCategoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Only time in this category will count'**
  String get pickCategoryDesc;

  /// No description provided for @rollDiceForTarget.
  ///
  /// In en, this message translates to:
  /// **'Roll the dice, set your target'**
  String get rollDiceForTarget;

  /// No description provided for @rollDiceDesc.
  ///
  /// In en, this message translates to:
  /// **'Dice value × 30 minutes = target duration'**
  String get rollDiceDesc;

  /// No description provided for @diceTapToRoll.
  ///
  /// In en, this message translates to:
  /// **'Tap to roll'**
  String get diceTapToRoll;

  /// No description provided for @diceRolling.
  ///
  /// In en, this message translates to:
  /// **'Rolling...'**
  String get diceRolling;

  /// No description provided for @diceResult.
  ///
  /// In en, this message translates to:
  /// **'Result: {value}'**
  String diceResult(int value);

  /// No description provided for @diceTargetDuration.
  ///
  /// In en, this message translates to:
  /// **'Target duration: {minutes} min'**
  String diceTargetDuration(int minutes);

  /// No description provided for @chooseTeammates.
  ///
  /// In en, this message translates to:
  /// **'Choose teammates'**
  String get chooseTeammates;

  /// No description provided for @teammatesSelected.
  ///
  /// In en, this message translates to:
  /// **'{count}/3 selected  ·  pick 2 or 3 teammates'**
  String teammatesSelected(int count);

  /// No description provided for @nightDuelInfo.
  ///
  /// In en, this message translates to:
  /// **'Night Duel'**
  String get nightDuelInfo;

  /// No description provided for @nightDuelRange.
  ///
  /// In en, this message translates to:
  /// **'11:00 PM — 7:00 AM'**
  String get nightDuelRange;

  /// No description provided for @nightDuelBody.
  ///
  /// In en, this message translates to:
  /// **'Sleep without touching your phone. Whoever lasts longest wins. Fixed 8 hours.'**
  String get nightDuelBody;

  /// No description provided for @nightDuelAutoStart.
  ///
  /// In en, this message translates to:
  /// **'This duel starts automatically at 11:00 PM.'**
  String get nightDuelAutoStart;

  /// No description provided for @mysteryMissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Mystery Mission'**
  String get mysteryMissionTitle;

  /// No description provided for @mysteryMissionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The mission is revealed when the duel starts'**
  String get mysteryMissionSubtitle;

  /// No description provided for @mysteryMissionBody.
  ///
  /// In en, this message translates to:
  /// **'A random mission is picked when you start the duel.'**
  String get mysteryMissionBody;

  /// No description provided for @mysteryStart.
  ///
  /// In en, this message translates to:
  /// **'Start Mission'**
  String get mysteryStart;

  /// No description provided for @opponentWantsToBanApp.
  ///
  /// In en, this message translates to:
  /// **'Your opponent wants you to ban {app}'**
  String opponentWantsToBanApp(String app);

  /// No description provided for @opponentWantsCategory.
  ///
  /// In en, this message translates to:
  /// **'Your opponent wants to duel in {category}'**
  String opponentWantsCategory(String category);

  /// No description provided for @proposeDifferentApp.
  ///
  /// In en, this message translates to:
  /// **'I don\'t have that app, suggest another'**
  String get proposeDifferentApp;

  /// No description provided for @proposeDifferentCategory.
  ///
  /// In en, this message translates to:
  /// **'I don\'t use that category, suggest another'**
  String get proposeDifferentCategory;

  /// No description provided for @acceptInvite.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptInvite;

  /// No description provided for @proposalSent.
  ///
  /// In en, this message translates to:
  /// **'Proposal sent: {value}'**
  String proposalSent(String value);

  /// No description provided for @stepAppPicker.
  ///
  /// In en, this message translates to:
  /// **'Pick app'**
  String get stepAppPicker;

  /// No description provided for @stepCategoryPicker.
  ///
  /// In en, this message translates to:
  /// **'Pick category'**
  String get stepCategoryPicker;

  /// No description provided for @stepDice.
  ///
  /// In en, this message translates to:
  /// **'Roll dice'**
  String get stepDice;

  /// No description provided for @stepNightInfo.
  ///
  /// In en, this message translates to:
  /// **'Night duel'**
  String get stepNightInfo;

  /// No description provided for @stepMystery.
  ///
  /// In en, this message translates to:
  /// **'Mystery mission'**
  String get stepMystery;

  /// No description provided for @stepTeamPicker.
  ///
  /// In en, this message translates to:
  /// **'Pick teammates'**
  String get stepTeamPicker;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
