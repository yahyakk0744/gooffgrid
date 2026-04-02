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
  String get longestOffScreen => 'أطول وقت بدون شاشة';

  @override
  String get dailyGoal => 'الهدف اليومي';

  @override
  String get streak => 'سلسلة';

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
  String get logout => 'تسجيل الخروج';

  @override
  String get shareProfile => 'مشاركة الملف الشخصي';

  @override
  String get shareReportCard => 'Drop the Air';

  @override
  String get o2Balance => 'O₂ Points';

  @override
  String get offGridMarket => 'Loot';

  @override
  String get offGridMarketHint => 'Turn O₂ points into real-world loot';

  @override
  String get appUsage => 'استخدام التطبيقات';

  @override
  String get weeklyReport => 'التقرير الأسبوعي';

  @override
  String get seasons => 'المواسم';

  @override
  String get groups => 'المجموعات';

  @override
  String get createGroup => 'إنشاء مجموعة';

  @override
  String get stats => 'الإحصائيات';

  @override
  String get whatIf => 'ماذا لو؟';

  @override
  String get focusMode => 'تنفس';

  @override
  String get reportCard => 'بطاقة التقرير';

  @override
  String get antiSocialStory => 'لحظة غير اجتماعية';

  @override
  String get postStory => 'نشر';

  @override
  String get storyExpired => 'منتهية';

  @override
  String get noStories => 'لا توجد قصص بعد';

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
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountConfirm =>
      'سيتم حذف حسابك وجميع بياناتك بشكل دائم. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get error => 'خطأ';

  @override
  String get tryAgain => 'حاول مجدداً';

  @override
  String get loading => 'جارٍ التحميل...';

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
}
