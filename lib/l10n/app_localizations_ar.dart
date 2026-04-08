// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan => 'افصل. العب. لا تضيع في الرقمي.';

  @override
  String get home => 'الرئيسية';

  @override
  String get ranking => 'التصنيف';

  @override
  String get duel => 'مبارزة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get stories => 'القصص';

  @override
  String get today => 'اليوم';

  @override
  String get thisWeek => 'هذا الأسبوع';

  @override
  String get friends => 'الأصدقاء';

  @override
  String get friendsOf => 'أصدقاء';

  @override
  String get allFriends => 'الكل';

  @override
  String get city => 'المدينة';

  @override
  String get country => 'البلد';

  @override
  String get global => 'عالمي';

  @override
  String minutes(int count) {
    return '$count دقيقة';
  }

  @override
  String hours(int count) {
    return '$count س';
  }

  @override
  String hoursMinutes(int h, int m) {
    return '$hس $mد';
  }

  @override
  String get screenTime => 'وقت الشاشة';

  @override
  String get phonePickups => 'مرات إمساك الهاتف';

  @override
  String pickupsToday(int count) {
    return 'أمسكت الهاتف $count مرة اليوم';
  }

  @override
  String get topTriggers => 'أكثر المحفزات';

  @override
  String get longestOffScreen => 'أطول وقت بدون شاشة';

  @override
  String get dailyGoal => 'الهدف اليومي';

  @override
  String goalHours(int count) {
    return 'الهدف: $count ساعات';
  }

  @override
  String get streak => 'سلسلة';

  @override
  String streakDays(int count) {
    return '$count أيام';
  }

  @override
  String get level => 'المستوى';

  @override
  String get badges => 'الشارات';

  @override
  String get duels => 'المبارزات';

  @override
  String get activeDuels => 'نشطة';

  @override
  String get pastDuels => 'سابقة';

  @override
  String get createDuel => 'إنشاء مبارزة';

  @override
  String get startDuel => 'بدء مبارزة';

  @override
  String get invite => 'دعوة';

  @override
  String get accept => 'قبول';

  @override
  String get decline => 'رفض';

  @override
  String get win => 'فوز';

  @override
  String get lose => 'خسارة';

  @override
  String get draw => 'تعادل';

  @override
  String get addFriend => 'إضافة صديق';

  @override
  String get friendCode => 'رمز الصداقة';

  @override
  String get search => 'بحث';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get dailyReminder => 'تذكير يومي';

  @override
  String get duelNotifications => 'إشعارات المبارزة';

  @override
  String get locationSharing => 'مشاركة الموقع';

  @override
  String get subscription => 'الاشتراك';

  @override
  String get free => 'مجاني';

  @override
  String get pro => 'برو';

  @override
  String get proPlus => 'برو+';

  @override
  String get currentPlan => 'الخطة الحالية';

  @override
  String get recommended => 'موصى به';

  @override
  String get start => 'ابدأ';

  @override
  String get upgradeToPro => 'الترقية إلى برو';

  @override
  String get upgradeToProPlus => 'الترقية إلى برو+';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String monthlyPrice(String price) {
    return '$price/شهر';
  }

  @override
  String get freeFeature1 => 'تتبع يومي لوقت الشاشة';

  @override
  String get freeFeature2 => 'تصنيفات الأصدقاء';

  @override
  String get freeFeature3 => '3 مبارزات نشطة';

  @override
  String get freeFeature4 => 'شارات أساسية';

  @override
  String get proFeature1 => 'جميع التصنيفات (المدينة، البلد، العالمي)';

  @override
  String get proFeature2 => 'إحصائيات تفصيلية وتقويم التركيز';

  @override
  String get proFeature3 => 'مبارزات غير محدودة';

  @override
  String get proFeature4 => 'تذاكر Off-Grid مشمولة';

  @override
  String get proFeature5 => 'تجربة بدون إعلانات';

  @override
  String get proPlusFeature1 => 'كل ما في برو';

  @override
  String get proPlusFeature2 => 'خطة عائلية (5 أشخاص)';

  @override
  String get proPlusFeature3 => 'دعم ذو أولوية';

  @override
  String get proPlusFeature4 => 'شارات وسمات حصرية';

  @override
  String get proPlusFeature5 => 'وصول مبكر لميزات بيتا';

  @override
  String get paywallTitle => 'نادي Off-Grid';

  @override
  String get paywallSubtitle => 'احصل على مكافأة لانفصالك عن الشاشة.';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get shareProfile => 'مشاركة الملف الشخصي';

  @override
  String get shareReportCard => 'اعرض إنجازك';

  @override
  String get appUsage => 'استخدام التطبيقات';

  @override
  String get whatDidYouUse => 'ما الذي استخدمته اليوم؟';

  @override
  String get weeklyReport => 'التقرير الأسبوعي';

  @override
  String get weeklyTrend => 'اتجاه 7 أيام';

  @override
  String get seasons => 'المواسم';

  @override
  String get seasonPass => 'تذاكر Off-Grid';

  @override
  String get groups => 'المجموعات';

  @override
  String get createGroup => 'إنشاء مجموعة';

  @override
  String get stats => 'الإحصائيات';

  @override
  String get analytics => 'التحليلات';

  @override
  String get detailedAnalytics => 'تحليلات مفصلة';

  @override
  String get categories => 'الفئات';

  @override
  String get weeklyUsage => 'الاستخدام الأسبوعي';

  @override
  String get appDetails => 'تفاصيل التطبيق';

  @override
  String get focusCalendar => 'تقويم التركيز';

  @override
  String get whatIf => 'ماذا لو؟';

  @override
  String get focusMode => 'تنفس';

  @override
  String get startFocusMode => 'بدء وضع التركيز';

  @override
  String get focusing => 'أنت في وضع التركيز...';

  @override
  String focusComplete(int minutes) {
    return 'رائع! ركزت لمدة $minutes دقيقة';
  }

  @override
  String get focusTimeout => 'انتهاء مهلة الجلسة';

  @override
  String get focusTimeoutDesc => 'لقد وصلت إلى حد 120 دقيقة.\nهل ما زلت هناك؟';

  @override
  String get end => 'إنهاء';

  @override
  String get reportCard => 'بطاقة التقرير';

  @override
  String get antiSocialStory => 'لحظة غير اجتماعية';

  @override
  String get storyQuestion => 'ماذا تفعل بعيداً عن هاتفك؟';

  @override
  String get postStory => 'نشر';

  @override
  String get storyExpired => 'منتهية';

  @override
  String get noStories => 'لا توجد قصص بعد';

  @override
  String get noStoriesHint =>
      'دع أصدقاءك يبدأون بمشاركة لحظاتهم بعيداً عن الشاشة!';

  @override
  String get storyBlocked => 'لا يمكنك مشاركة قصة';

  @override
  String get storyBlockedHint =>
      'لقد تجاوزت هدفك اليومي لوقت الشاشة. التزم بهدفك لتكسب حق مشاركة القصص!';

  @override
  String get duration => 'المدة';

  @override
  String get walk => 'مشي';

  @override
  String get run => 'جري';

  @override
  String get book => 'كتاب';

  @override
  String get meditation => 'تأمل';

  @override
  String get nature => 'طبيعة';

  @override
  String get sports => 'رياضة';

  @override
  String get music => 'موسيقى';

  @override
  String get cooking => 'طبخ';

  @override
  String get friendsActivity => 'الأصدقاء';

  @override
  String get family => 'العائلة';

  @override
  String get o2Balance => 'نقاط O₂';

  @override
  String o2Remaining(int count) {
    return 'المتبقي: $count';
  }

  @override
  String o2Today(int earned, int max) {
    return 'اليوم: $earned/$max O₂';
  }

  @override
  String get o2Rules => 'قواعد O₂';

  @override
  String get o2RuleTime => 'يُكتسب فقط بين 08:00 و 00:00';

  @override
  String get o2RuleDaily => 'حد أقصى 500 O₂ يومياً';

  @override
  String get o2RuleFocus => 'وضع التركيز 120 دقيقة كحد أقصى';

  @override
  String get o2RuleTransfer => 'لا تحويلات ولا رهانات';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂ (تقديري)';
  }

  @override
  String get offGridMarket => 'الغنائم';

  @override
  String get offGridMarketHint => 'حوّل نقاط O₂ إلى مكافآت حقيقية';

  @override
  String get redeem => 'استبدال';

  @override
  String get insufficient => 'غير كافٍ';

  @override
  String get redeemSuccess => 'مبروك!';

  @override
  String get couponCode => 'رمز القسيمة الخاص بك:';

  @override
  String get recentTransactions => 'المعاملات الأخيرة';

  @override
  String get noTransactions => 'لا توجد معاملات بعد';

  @override
  String get categorySocial => 'اجتماعي';

  @override
  String get categoryGame => 'ألعاب';

  @override
  String get categoryVideo => 'فيديو';

  @override
  String get categoryAudio => 'موسيقى';

  @override
  String get categoryProductivity => 'إنتاجية';

  @override
  String get categoryNews => 'أخبار';

  @override
  String get categoryGames => 'ألعاب';

  @override
  String get categoryShopping => 'تسوق';

  @override
  String get categoryBrowser => 'متصفح';

  @override
  String get categoryMaps => 'خرائط';

  @override
  String get categoryImage => 'صور';

  @override
  String get categoryOther => 'أخرى';

  @override
  String hello(String name) {
    return 'مرحباً، $name';
  }

  @override
  String get goalCompleted => 'تم إنجاز الهدف!';

  @override
  String get dailyGoalShort => 'الهدف اليومي';

  @override
  String get streakDaysLabel => 'أيام متتالية';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => 'المرتبة';

  @override
  String get offlineLabel => 'غير متصل';

  @override
  String get todaysApps => 'تطبيقات اليوم';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get activeDuel => 'مبارزة نشطة';

  @override
  String get startDuelPrompt => 'ابدأ مبارزة!';

  @override
  String get you => 'أنت';

  @override
  String moreCount(int count) {
    return '+$count أكثر';
  }

  @override
  String get removeWithPro => 'إزالة مع برو';

  @override
  String get adLabel => 'إعلان';

  @override
  String get focus => 'تركيز';

  @override
  String get legal => 'قانوني';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get kvkkText => 'إشعار خصوصية البيانات';

  @override
  String get deleteMyAccount => 'حذف حسابي';

  @override
  String get edit => 'تعديل';

  @override
  String get adminAddLoot => 'المشرف: إضافة غنائم';

  @override
  String get continueConsent => 'بالمتابعة أنت';

  @override
  String get acceptTermsSuffix => 'توافق.';

  @override
  String get alreadyHaveAccount => 'لدي حساب بالفعل';

  @override
  String get screenTimePermissionTitle => 'نحتاج لتتبع وقت شاشتك';

  @override
  String get screenTimePermissionDesc =>
      'يلزم الوصول إلى وقت الشاشة لمعرفة الوقت الذي تقضيه في كل تطبيق.';

  @override
  String get screenTimeGranted => 'تم منح إذن وقت الشاشة!';

  @override
  String get continueButton => 'متابعة';

  @override
  String get skip => 'تخطي';

  @override
  String get yourName => 'اسمك';

  @override
  String get nameHint => 'أدخل اسمك';

  @override
  String get ageGroup => 'الفئة العمرية';

  @override
  String get imReady => 'أنا مستعد';

  @override
  String get dailyGoalTitle => 'هدفك اليومي';

  @override
  String get goalQuestion => 'كم ساعة من وقت الشاشة تستهدف يومياً؟';

  @override
  String get goalMotivational1 => 'رائع! هدف حقيقي للتخلص من الإدمان الرقمي 💪';

  @override
  String get goalMotivational2 => 'هدف متوازن، بإمكانك تحقيقه! 🎯';

  @override
  String get goalMotivational3 => 'بداية جيدة، يمكنك التقليل تدريجياً 📉';

  @override
  String get goalMotivational4 => 'خطوة خطوة، كل دقيقة تهم ⭐';

  @override
  String get next => 'التالي';

  @override
  String hourShort(int count) {
    return '$countس';
  }

  @override
  String get welcomeSlogan =>
      'ضع هاتفك جانباً. تفوق على أصدقائك.\nكن الأول في مدينتك.';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountConfirm =>
      'سيتم حذف حسابك وجميع بياناتك بشكل دائم. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get ok => 'موافق';

  @override
  String get error => 'خطأ';

  @override
  String get tryAgain => 'حاول مجدداً';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get loadFailed => 'فشل التحميل';

  @override
  String get noDataYet => 'لا توجد بيانات بعد';

  @override
  String get welcome => 'مرحباً';

  @override
  String get welcomeSubtitle => 'ضع هاتفك جانباً. تفوق على أصدقائك.';

  @override
  String get continueWithGoogle => 'المتابعة مع Google';

  @override
  String get continueWithApple => 'المتابعة مع Apple';

  @override
  String get continueWithEmail => 'المتابعة بالبريد الإلكتروني';

  @override
  String get permissionsTitle => 'الأذونات';

  @override
  String get permissionsSubtitle => 'نحتاج إذناً لتتبع وقت شاشتك.';

  @override
  String get grantPermission => 'منح الإذن';

  @override
  String get setupProfile => 'إعداد الملف الشخصي';

  @override
  String get displayName => 'الاسم المعروض';

  @override
  String get selectCity => 'اختر المدينة';

  @override
  String get selectGoal => 'اختر الهدف اليومي';

  @override
  String get noDuelsYet => 'لا توجد مبارزات بعد';

  @override
  String get noDuelsYetSubtitle => 'ابدأ مبارزتك الأولى!';

  @override
  String get activeDuelsTitle => 'المبارزات النشطة';

  @override
  String get newDuel => 'مبارزة جديدة';

  @override
  String get selectDuelType => 'اختر نوع المبارزة';

  @override
  String get selectDurationStep => 'اختر المدة';

  @override
  String get selectOpponent => 'اختر الخصم';

  @override
  String get duelStartButton => 'ابدأ المبارزة! ⚔️';

  @override
  String get freePlanDuelLimit =>
      'الخطة المجانية تسمح بحد أقصى 3 مبارزات نشطة! قم بالترقية إلى برو.';

  @override
  String get quickSelect => 'اختيار سريع';

  @override
  String get customDuration => 'مدة مخصصة';

  @override
  String selectedDuration(String duration) {
    return 'المختار: $duration';
  }

  @override
  String get minDurationWarning => 'يجب عليك اختيار 10 دقائق على الأقل';

  @override
  String get selectPenalty => 'اختر العقوبة (اختياري)';

  @override
  String get searchFriend => 'ابحث عن صديق...';

  @override
  String get inviteWithLink => 'دعوة برابط 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '$countد اليوم';
  }

  @override
  String duelRemaining(int h, int m) {
    return 'متبقي $hس $mد';
  }

  @override
  String get remainingTime => 'الوقت المتبقي';

  @override
  String watchersCount(int count) {
    return '$count يشاهد 👀';
  }

  @override
  String get giveUp => 'الاستسلام';

  @override
  String get duelWon => 'لقد فزت! 🎉';

  @override
  String get duelLost => 'لقد خسرت 😔';

  @override
  String get greatPerformance => 'أداء رائع!';

  @override
  String get betterNextTime => 'حظاً أوفر في المرة القادمة!';

  @override
  String get revenge => 'الانتقام 🔥';

  @override
  String get share => 'مشاركة';

  @override
  String get selectFriend => 'اختر صديقاً';

  @override
  String get orSendLink => 'أو أرسل رابطاً';

  @override
  String get social => 'اجتماعي';

  @override
  String get myFriends => 'أصدقائي';

  @override
  String get inMyCity => 'في مدينتي';

  @override
  String get shareFirstStory => 'كن أول من يشارك لحظته بعيداً عن الشاشة!';

  @override
  String get createStoryTitle => 'مشاركة قصة';

  @override
  String get addPhoto => 'إضافة صورة';

  @override
  String get whatAreYouDoing => 'ماذا تفعل؟';

  @override
  String get captionHint => 'ماذا تفعل بعيداً عن هاتفك؟';

  @override
  String get howLongVisible => 'كم من الوقت يجب أن تظهر؟';

  @override
  String get whoCanSee => 'من يمكنه رؤيتها؟';

  @override
  String get onlyFriends => 'أصدقائي فقط';

  @override
  String get cityPeople => 'أهل مدينتي';

  @override
  String get photoStoriesPro =>
      'قصص الصور للبرو فقط! الإعدادات > نادي Off-Grid';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get writeFirst => 'اكتب شيئاً أولاً!';

  @override
  String get inappropriateContent => 'تم اكتشاف محتوى غير لائق';

  @override
  String viewsCount(int count) {
    return '$count مشاهدة';
  }

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get firstNameHint => 'اسمك الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get lastNameHint => 'اسم عائلتك';

  @override
  String get usernameLabel => 'اسم المستخدم';

  @override
  String get updateLocation => 'تحديث الموقع';

  @override
  String get locationUnknown => 'غير معروف';

  @override
  String get save => 'حفظ';

  @override
  String get usernameAvailable => 'متاح';

  @override
  String get usernameTaken => 'اسم المستخدم هذا مأخوذ';

  @override
  String get usernameFormatError => '3 أحرف على الأقل، أحرف وأرقام و _ فقط';

  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي';

  @override
  String get photoSelectedDemo =>
      'تم اختيار الصورة (لن يتم رفعها في وضع العرض التجريبي)';

  @override
  String get locationError => 'تعذّر الحصول على الموقع';

  @override
  String get errorOccurred => 'حدث خطأ';

  @override
  String get detailedScreenTime => 'وقت الشاشة التفصيلي';

  @override
  String get monthlyTop10 => 'أفضل 10 شهرياً';

  @override
  String get searchHint => 'بحث...';

  @override
  String get noFriendsYet => 'لا يوجد أصدقاء بعد';

  @override
  String get noFriendsHint => 'ابدأ بإضافة صديق';

  @override
  String get showQrCode => 'اعرض رمز QR الخاص بك';

  @override
  String get enterCode => 'أدخل الرمز';

  @override
  String get inviteLinkShare => 'مشاركة رابط الدعوة';

  @override
  String get startDuelAction => 'بدء المبارزة';

  @override
  String get pointsLabel => 'نقاط';

  @override
  String get mostUsedLabel => 'الأكثر استخداماً:';

  @override
  String get recentBadges => 'الشارات الأخيرة';

  @override
  String get allBadgesLabel => 'جميع الشارات';

  @override
  String get removeFriend => 'إزالة صديق';

  @override
  String get removeFriendConfirm =>
      'هل أنت متأكد من إزالة هذا الشخص من قائمة أصدقائك؟';

  @override
  String get remove => 'إزالة';

  @override
  String get requestSent => 'تم إرسال الطلب';

  @override
  String get whatCouldYouDo => 'ماذا كان بإمكانك أن تفعل؟';

  @override
  String get back => 'رجوع';

  @override
  String get weekly => 'أسبوعي';

  @override
  String get daily => 'يومي';

  @override
  String get mostUsedApps => 'التطبيقات الأكثر استخداماً';

  @override
  String get unlockSection => 'فتح الشاشة';

  @override
  String get selectedDayLabel => 'اليوم المحدد';

  @override
  String get todayLabel => 'اليوم';

  @override
  String weeklyAvgLabel(int h, int m) {
    return 'المتوسط اليومي: $hس $mد';
  }

  @override
  String get firstUnlock => 'أول فتح للشاشة';

  @override
  String get mostOpened => 'الأكثر فتحاً';

  @override
  String get timesPickedUp => 'مرات الإمساك';

  @override
  String get openingCount => 'فتحات';

  @override
  String get notificationUnit => 'إشعارات';

  @override
  String get timesUnit => 'مرات';

  @override
  String get turkey => 'تركيا';

  @override
  String get consecutiveDays => 'أيام متتالية';

  @override
  String bestStreakLabel(int days) {
    return 'الأفضل: $days أيام';
  }

  @override
  String get seriFriends => 'الأصدقاء';

  @override
  String get oxygenTitle => 'الأكسجين (O₂)';

  @override
  String get totalO2 => 'الإجمالي';

  @override
  String get remainingShort => 'المتبقي';

  @override
  String get noOffersYet => 'لا توجد عروض بعد';

  @override
  String o2SpentMsg(int amount) {
    return 'تم إنفاق $amount O₂';
  }

  @override
  String get mapLoadFailed => 'فشل تحميل الخريطة';

  @override
  String confirmRedeemMsg(String reward) {
    return 'هل تريد استبدال $reward؟';
  }

  @override
  String itemReceived(String item) {
    return 'تم استبدال $item!';
  }

  @override
  String get insufficientO2 => 'نقاط O₂ غير كافية';

  @override
  String get season1Title => 'الموسم 1';

  @override
  String get season1Subtitle => 'صحوة الربيع';

  @override
  String get seasonPassBtn => 'تذكرة الموسم (99TL)';

  @override
  String get seasonPassLabel => 'تذكرة الموسم';

  @override
  String get noGroupsYet => 'لا توجد مجموعات بعد';

  @override
  String get noGroupsSubtitle => 'أنشئ مجموعة مع أصدقائك';

  @override
  String get newGroup => 'مجموعة جديدة';

  @override
  String memberCount(int count) {
    return '$count أعضاء';
  }

  @override
  String get weeklyGoal => 'الهدف الأسبوعي';

  @override
  String challengeProgress(int percent) {
    return '$percent% مكتمل';
  }

  @override
  String get membersLabel => 'الأعضاء';

  @override
  String get inviteLink => 'رابط الدعوة';

  @override
  String get linkCopied => 'تم نسخ الرابط!';

  @override
  String get copy => 'نسخ';

  @override
  String get qrCode => 'رمز QR';

  @override
  String get groupNameLabel => 'اسم المجموعة';

  @override
  String get groupNameHint => 'أدخل اسم المجموعة';

  @override
  String get groupNameEmpty => 'لا يمكن أن يكون اسم المجموعة فارغاً';

  @override
  String dailyGoalHours(int hours) {
    return 'الهدف اليومي: $hours ساعات';
  }

  @override
  String get addMember => 'إضافة عضو';

  @override
  String selectedCount(int count) {
    return '$count محدد';
  }

  @override
  String get create => 'إنشاء';

  @override
  String groupCreated(String name) {
    return 'تم إنشاء $name!';
  }

  @override
  String invitedCount(int count) {
    return 'تمت دعوة $count أشخاص';
  }

  @override
  String get screenTimeLower => 'وقت الشاشة';

  @override
  String get improvedFromLastWeek => 'أفضل بنسبة 12٪ من الأسبوع الماضي';

  @override
  String get o2Earned => 'O₂ المكتسب';

  @override
  String get friendRank => 'ترتيب الأصدقاء';

  @override
  String cityRankLabel(String city) {
    return 'ترتيب $city';
  }

  @override
  String get mostUsed => 'الأكثر استخداماً';

  @override
  String get offGridClub => 'نادي Off-Grid';

  @override
  String get clubSubtitle => 'حقق التوازن الرقمي واحصل على مكافآت.';

  @override
  String get planStarter => 'المبتدئ';

  @override
  String get planStarterSubtitle => 'ابدأ بالأساسيات';

  @override
  String get currentPlanBtn => 'الخطة الحالية';

  @override
  String get billingMonthly => 'شهري';

  @override
  String get billingYearly => 'سنوي';

  @override
  String get yearlySavings => 'خصم 33٪';

  @override
  String get planComparison => 'مقارنة الخطط';

  @override
  String get breathTechniquesComp => 'تقنيات التنفس';

  @override
  String get activeDuelsComp => 'المبارزات النشطة';

  @override
  String get storyPhoto => 'صورة القصة';

  @override
  String get heatMap => 'خريطة الحرارة';

  @override
  String get top10Report => 'تقرير أفضل 10';

  @override
  String get exclusiveBadges => 'شارات حصرية';

  @override
  String get adFree => 'بدون إعلانات';

  @override
  String get familyPlanComp => 'الخطة العائلية';

  @override
  String get familyReport => 'التقرير العائلي';

  @override
  String get exclusiveThemes => 'سمات حصرية';

  @override
  String get prioritySupport => 'دعم ذو أولوية';

  @override
  String get billingNote =>
      'يمكن إلغاء الاشتراك في أي وقت.\nتتم معالجة الدفع عبر App Store/Google Play.\nيتجدد الاشتراك تلقائياً.';

  @override
  String get restoreSuccess => 'تم استعادة المشتريات!';

  @override
  String get restoreFailed => 'لم يتم العثور على مشتريات لاستعادتها.';

  @override
  String get packagesLoadFailed => 'فشل تحميل الباقات. يرجى المحاولة مجدداً.';

  @override
  String get themesTitle => 'السمات';

  @override
  String get themeLockedMsg => 'هذه السمة للبرو+! الإعدادات > نادي Off-Grid';

  @override
  String get familyPlanTitle => 'الخطة العائلية';

  @override
  String get familyPlanLocked => 'التوازن الرقمي معاً';

  @override
  String get familyPlanLockedDesc =>
      'أضف ما يصل إلى 5 أفراد من العائلة، حددوا أهدافاً معاً واحصلوا على تقارير عائلية أسبوعية.';

  @override
  String get weeklyFamilyReport => 'التقرير العائلي الأسبوعي';

  @override
  String get familyRanking => 'التصنيف العائلي';

  @override
  String get totalOffline => 'إجمالي وقت الانفصال';

  @override
  String get average => 'المتوسط';

  @override
  String get best => 'الأفضل';

  @override
  String offlineTime(int h, int m) {
    return '$hس $mد غير متصل';
  }

  @override
  String get enterName => 'أدخل الاسم';

  @override
  String get cannotUndo => 'لا يمكن التراجع عن هذا الإجراء!';

  @override
  String get deleteWarningDesc =>
      'عند حذف حسابك، سيتم حذف البيانات التالية بشكل دائم:';

  @override
  String get deleteItem1 => 'معلومات الملف الشخصي والصورة الرمزية';

  @override
  String get deleteItem2 => 'جميع إحصائيات وقت الشاشة';

  @override
  String get deleteItem3 => 'قائمة الأصدقاء والمبارزات';

  @override
  String get deleteItem4 => 'القصص والتعليقات';

  @override
  String get deleteItem5 => 'نقاط O₂ والغنائم';

  @override
  String get deleteItem6 => 'سجل الاشتراك';

  @override
  String get deleteSubscriptionNote =>
      'إذا كان لديك اشتراك نشط، يجب عليك إلغاؤه أولاً عبر Apple App Store أو Google Play Store.';

  @override
  String get deleteConfirmCheck =>
      'أفهم أن حسابي وجميع بياناتي سيتم حذفها بشكل دائم.';

  @override
  String get deleteAccountBtn => 'حذف حسابي نهائياً';

  @override
  String get deleteErrorMsg => 'حدث خطأ. يرجى المحاولة مجدداً.';

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get passwordHint => 'كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور';

  @override
  String get passwordResetSent => 'تم إرسال بريد إعادة تعيين كلمة المرور.';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get orDivider => 'أو';

  @override
  String get continueWithGoogleShort => 'المتابعة مع Google';

  @override
  String get continueWithAppleShort => 'المتابعة مع Apple';

  @override
  String get noAccountYet => 'ليس لديك حساب؟ ';

  @override
  String get adminExistingPoints => 'النقاط الموجودة';

  @override
  String get adminSearchPlace => 'ابحث عن مكان...';

  @override
  String get adminRewardTitle => 'عنوان المكافأة (مثل قهوة مجانية)';

  @override
  String get adminO2Cost => 'تكلفة O₂';

  @override
  String get adminSave => 'حفظ';

  @override
  String get adminSaved => 'تم الحفظ!';

  @override
  String get adminDeleteTitle => 'حذف';

  @override
  String get adminDeleteMsg => 'هل أنت متأكد من حذف هذه النقطة؟';

  @override
  String adminDeleteError(String error) {
    return 'خطأ في الحذف: $error';
  }

  @override
  String get adminFillFields => 'أدخل المكافأة وتكلفة O₂';

  @override
  String breathCount(int count) {
    return '$count أنفاس';
  }

  @override
  String minutesRemaining(int count) {
    return 'متبقي $countد';
  }

  @override
  String focusMinutes(int count) {
    return 'ركزت لمدة $count دقيقة';
  }

  @override
  String get o2TimeRestriction => 'يُكتسب O₂ فقط بين 08:00 و 00:00';

  @override
  String get breathTechniqueProMsg =>
      'هذه التقنية للبرو فقط! الإعدادات > نادي Off-Grid';

  @override
  String get inhale => 'شهيق';

  @override
  String get holdBreath => 'حبس';

  @override
  String get exhale => 'زفير';

  @override
  String get waitBreath => 'انتظار';

  @override
  String get proMostPopular => 'الأكثر شعبية';

  @override
  String get proFamilyBadge => 'عائلي';

  @override
  String get comparedToLastWeek => 'مقارنة بالأسبوع الماضي';

  @override
  String get appBlockTitle => 'حظر التطبيقات';

  @override
  String get appBlockSchedule => 'الجدول';

  @override
  String get appBlockEnableBlocking => 'تفعيل الحظر';

  @override
  String get appBlockActive => 'الحظر مفعّل';

  @override
  String get appBlockInactive => 'الحظر معطّل';

  @override
  String get appBlockStrictMode => 'الوضع الصارم';

  @override
  String get appBlockStrictDesc => 'لا يمكن إلغاء التفعيل حتى ينتهي المؤقت';

  @override
  String get appBlockStrictExpired => 'انتهى المؤقت';

  @override
  String get appBlockStrictDurationTitle => 'مدة الوضع الصارم';

  @override
  String get appBlockDuration30m => '30 دقيقة';

  @override
  String get appBlockDuration1h => 'ساعة واحدة';

  @override
  String get appBlockDuration2h => 'ساعتان';

  @override
  String get appBlockDuration4h => '4 ساعات';

  @override
  String get appBlockDurationAllDay => 'طوال اليوم (24 ساعة)';

  @override
  String get appBlockScheduleTitle => 'جدول الحظر';

  @override
  String get appBlockScheduleDesc => 'تعيين فترات زمنية يومية';

  @override
  String get appBlockBlockedApps => 'التطبيقات المحظورة';

  @override
  String get appBlockNoApps => 'لم تتم إضافة تطبيقات بعد';

  @override
  String get appBlockAddApp => 'إضافة تطبيق';

  @override
  String get appBlockPickerTitle => 'اختر تطبيقاً';

  @override
  String get appBlockPresetWork => 'ساعات العمل (09-18)';

  @override
  String get appBlockPresetSleep => 'وقت النوم (23-07)';

  @override
  String get appBlockPresetAllDay => 'طوال اليوم';

  @override
  String get appBlockInterventionTitle => 'انتظر لحظة...';

  @override
  String get appBlockInterventionSubtitle => 'خذ نفساً وراقب نفسك';

  @override
  String get appBlockInterventionGiveUp => 'سأمتنع';

  @override
  String get appBlockInterventionOpenAnyway => 'فتح على أي حال';

  @override
  String get appBlockStrictModeActive => 'الوضع الصارم — لا يمكن الفتح';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return 'قضيت $hours ساعات على $app هذا الأسبوع';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return 'امتنعت $count مرات هذا الشهر';
  }

  @override
  String get pickAppToBan => 'اختر التطبيق المراد حظره';

  @override
  String get pickAppToBanDesc =>
      'لن يتمكن خصمك من فتح هذا التطبيق لمدة 24 ساعة';

  @override
  String get pickCategory => 'اختر الفئة';

  @override
  String get pickCategoryDesc => 'الاستخدام في هذه الفئة فقط هو ما يُحتسب';

  @override
  String get rollDiceForTarget => 'ارمِ النرد لتحديد هدفك';

  @override
  String get rollDiceDesc => 'قيمة النرد × 30 دقيقة = المدة المستهدفة';

  @override
  String get diceTapToRoll => 'اضغط للرمي';

  @override
  String get diceRolling => 'جارٍ الرمي...';

  @override
  String diceResult(int value) {
    return 'النتيجة: $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return 'المدة المستهدفة: $minutes دقيقة';
  }

  @override
  String get chooseTeammates => 'اختر زملاء الفريق';

  @override
  String teammatesSelected(int count) {
    return '$count/3 تم اختيارهم  ·  اختر 2 أو 3 زملاء';
  }

  @override
  String get nightDuelInfo => 'مبارزة ليلية';

  @override
  String get nightDuelRange => '23:00 — 07:00';

  @override
  String get nightDuelBody =>
      'نَم دون لمس هاتفك. من يصمد أطول يفوز. 8 ساعات ثابتة.';

  @override
  String get nightDuelAutoStart =>
      'تبدأ هذه المبارزة تلقائيًا في الساعة 23:00.';

  @override
  String get mysteryMissionTitle => 'مهمة غامضة';

  @override
  String get mysteryMissionSubtitle => 'تُكشف مهمتك عند بدء المبارزة';

  @override
  String get mysteryMissionBody => 'عند بدء المبارزة، يتم اختيار مهمة عشوائية.';

  @override
  String get mysteryStart => 'بدء المهمة';

  @override
  String opponentWantsToBanApp(String app) {
    return 'يريد خصمك منك حظر $app';
  }

  @override
  String opponentWantsCategory(String category) {
    return 'يريد خصمك التنافس في فئة $category';
  }

  @override
  String get proposeDifferentApp => 'ليس لدي هذا التطبيق، اقترح آخر';

  @override
  String get proposeDifferentCategory => 'لا أستخدم هذه الفئة، اقترح أخرى';

  @override
  String get acceptInvite => 'قبول';

  @override
  String proposalSent(String value) {
    return 'تم إرسال الاقتراح: $value';
  }

  @override
  String get stepAppPicker => 'اختر التطبيق';

  @override
  String get stepCategoryPicker => 'اختر الفئة';

  @override
  String get stepDice => 'رمي النرد';

  @override
  String get stepNightInfo => 'مبارزة ليلية';

  @override
  String get stepMystery => 'مهمة غامضة';

  @override
  String get stepTeamPicker => 'اختر زملاء الفريق';
}
