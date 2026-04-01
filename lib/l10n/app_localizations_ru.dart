// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get home => 'Главная';

  @override
  String get ranking => 'Рейтинг';

  @override
  String get duel => 'Дуэль';

  @override
  String get profile => 'Профиль';

  @override
  String get settings => 'Настройки';

  @override
  String get stories => 'Истории';

  @override
  String get today => 'Сегодня';

  @override
  String get thisWeek => 'На этой неделе';

  @override
  String get friends => 'Друзья';

  @override
  String get city => 'Город';

  @override
  String get country => 'Страна';

  @override
  String get global => 'Глобально';

  @override
  String minutes(int count) {
    return '$count мин';
  }

  @override
  String hours(int count) {
    return '$count ч';
  }

  @override
  String hoursMinutes(int h, int m) {
    return '$hч $mм';
  }

  @override
  String get screenTime => 'Время экрана';

  @override
  String get phonePickups => 'Разблокировки телефона';

  @override
  String get longestOffScreen => 'Наибольшее время без экрана';

  @override
  String get dailyGoal => 'Дневная цель';

  @override
  String get streak => 'Серия';

  @override
  String get level => 'Уровень';

  @override
  String get badges => 'Значки';

  @override
  String get duels => 'Дуэли';

  @override
  String get activeDuels => 'Активные';

  @override
  String get pastDuels => 'Прошедшие';

  @override
  String get createDuel => 'Создать дуэль';

  @override
  String get invite => 'Пригласить';

  @override
  String get accept => 'Принять';

  @override
  String get decline => 'Отклонить';

  @override
  String get win => 'Победа';

  @override
  String get lose => 'Поражение';

  @override
  String get draw => 'Ничья';

  @override
  String get addFriend => 'Добавить друга';

  @override
  String get friendCode => 'Код друга';

  @override
  String get search => 'Поиск';

  @override
  String get notifications => 'Уведомления';

  @override
  String get dailyReminder => 'Ежедневное напоминание';

  @override
  String get duelNotifications => 'Уведомления о дуэлях';

  @override
  String get locationSharing => 'Передача местоположения';

  @override
  String get subscription => 'Подписка';

  @override
  String get free => 'Бесплатно';

  @override
  String get pro => 'Про';

  @override
  String get proPlus => 'Про+';

  @override
  String get currentPlan => 'Текущий план';

  @override
  String get recommended => 'Рекомендуется';

  @override
  String get start => 'Начать';

  @override
  String get logout => 'Выйти';

  @override
  String get shareProfile => 'Поделиться профилем';

  @override
  String get appUsage => 'Использование приложений';

  @override
  String get weeklyReport => 'Еженедельный отчёт';

  @override
  String get seasons => 'Сезоны';

  @override
  String get groups => 'Группы';

  @override
  String get createGroup => 'Создать группу';

  @override
  String get stats => 'Статистика';

  @override
  String get whatIf => 'А что если?';

  @override
  String get focusMode => 'Дыхание';

  @override
  String get reportCard => 'Табель';

  @override
  String get antiSocialStory => 'Антисоциальный момент';

  @override
  String get postStory => 'Опубликовать';

  @override
  String get storyExpired => 'Истекла';

  @override
  String get noStories => 'Историй пока нет';

  @override
  String get walk => 'Прогулка';

  @override
  String get run => 'Бег';

  @override
  String get book => 'Книга';

  @override
  String get meditation => 'Медитация';

  @override
  String get nature => 'Природа';

  @override
  String get sports => 'Спорт';

  @override
  String get music => 'Музыка';

  @override
  String get cooking => 'Готовка';

  @override
  String get friendsActivity => 'Друзья';

  @override
  String get family => 'Семья';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get deleteAccountConfirm =>
      'Ваш аккаунт и все данные будут удалены навсегда. Это действие нельзя отменить.';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get error => 'Ошибка';

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get loading => 'Загрузка...';

  @override
  String get welcome => 'Добро пожаловать';

  @override
  String get welcomeSubtitle => 'Отложи телефон. Обгони друзей.';

  @override
  String get continueWithGoogle => 'Продолжить с Google';

  @override
  String get continueWithApple => 'Продолжить с Apple';

  @override
  String get continueWithEmail => 'Продолжить с email';

  @override
  String get permissionsTitle => 'Разрешения';

  @override
  String get permissionsSubtitle =>
      'Нам нужно разрешение для отслеживания времени экрана.';

  @override
  String get grantPermission => 'Предоставить разрешение';

  @override
  String get setupProfile => 'Настроить профиль';

  @override
  String get displayName => 'Отображаемое имя';

  @override
  String get selectCity => 'Выбрать город';

  @override
  String get selectGoal => 'Выбрать дневную цель';
}
