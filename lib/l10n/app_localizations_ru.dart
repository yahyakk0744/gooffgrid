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
  String get appSlogan => 'Отключись. Играй. Не теряйся в цифровом.';

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
  String get friendsOf => 'Друзья';

  @override
  String get allFriends => 'Все';

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
  String pickupsToday(int count) {
    return 'Сегодня взял телефон $count раз';
  }

  @override
  String get topTriggers => 'Главные раздражители';

  @override
  String get longestOffScreen => 'Наибольшее время без экрана';

  @override
  String get dailyGoal => 'Дневная цель';

  @override
  String goalHours(int count) {
    return 'Цель: $count ч';
  }

  @override
  String get streak => 'Серия';

  @override
  String streakDays(int count) {
    return '$count дней';
  }

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
  String get startDuel => 'Начать дуэль';

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
  String get upgradeToPro => 'Перейти на Про';

  @override
  String get upgradeToProPlus => 'Перейти на Про+';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String monthlyPrice(String price) {
    return '$price/мес';
  }

  @override
  String get freeFeature1 => 'Ежедневное отслеживание времени экрана';

  @override
  String get freeFeature2 => 'Рейтинги друзей';

  @override
  String get freeFeature3 => '3 активные дуэли';

  @override
  String get freeFeature4 => 'Базовые значки';

  @override
  String get proFeature1 => 'Все рейтинги (город, страна, глобальный)';

  @override
  String get proFeature2 => 'Подробная статистика и календарь фокуса';

  @override
  String get proFeature3 => 'Безлимитные дуэли';

  @override
  String get proFeature4 => 'Пропуски Off-Grid включены';

  @override
  String get proFeature5 => 'Без рекламы';

  @override
  String get proPlusFeature1 => 'Всё из Про';

  @override
  String get proPlusFeature2 => 'Семейный план (5 человек)';

  @override
  String get proPlusFeature3 => 'Приоритетная поддержка';

  @override
  String get proPlusFeature4 => 'Эксклюзивные значки и темы';

  @override
  String get proPlusFeature5 => 'Ранний доступ к бета-функциям';

  @override
  String get paywallTitle => 'Off-Grid Клуб';

  @override
  String get paywallSubtitle => 'Получай награду за отдых от экрана.';

  @override
  String get logout => 'Выйти';

  @override
  String get shareProfile => 'Поделиться профилем';

  @override
  String get shareReportCard => 'Похвастайся результатом';

  @override
  String get appUsage => 'Использование приложений';

  @override
  String get whatDidYouUse => 'Что ты использовал сегодня?';

  @override
  String get weeklyReport => 'Еженедельный отчёт';

  @override
  String get weeklyTrend => 'Тренд за 7 дней';

  @override
  String get seasons => 'Сезоны';

  @override
  String get seasonPass => 'Пропуски Off-Grid';

  @override
  String get groups => 'Группы';

  @override
  String get createGroup => 'Создать группу';

  @override
  String get stats => 'Статистика';

  @override
  String get analytics => 'Аналитика';

  @override
  String get detailedAnalytics => 'Подробная аналитика';

  @override
  String get categories => 'Категории';

  @override
  String get weeklyUsage => 'Недельное использование';

  @override
  String get appDetails => 'Детали приложения';

  @override
  String get focusCalendar => 'Календарь фокуса';

  @override
  String get whatIf => 'А что если?';

  @override
  String get focusMode => 'Дыхание';

  @override
  String get startFocusMode => 'Начать режим фокуса';

  @override
  String get focusing => 'Ты фокусируешься...';

  @override
  String focusComplete(int minutes) {
    return 'Отлично! Ты сфокусировался на $minutes мин';
  }

  @override
  String get focusTimeout => 'Время сессии истекло';

  @override
  String get focusTimeoutDesc => 'Ты достиг лимита в 120 минут.\nЕщё здесь?';

  @override
  String get end => 'Завершить';

  @override
  String get reportCard => 'Табель';

  @override
  String get antiSocialStory => 'Антисоциальный момент';

  @override
  String get storyQuestion => 'Что ты делаешь вдали от телефона?';

  @override
  String get postStory => 'Опубликовать';

  @override
  String get storyExpired => 'Истекла';

  @override
  String get noStories => 'Историй пока нет';

  @override
  String get noStoriesHint =>
      'Пусть друзья начнут делиться своими офлайн-моментами!';

  @override
  String get storyBlocked => 'Нельзя поделиться историей';

  @override
  String get storyBlockedHint =>
      'Ты превысил дневную цель по времени экрана. Придерживайся цели, чтобы получить право публиковать истории!';

  @override
  String get duration => 'Продолжительность';

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
  String get o2Balance => 'Баллы O₂';

  @override
  String o2Remaining(int count) {
    return 'Осталось: $count';
  }

  @override
  String o2Today(int earned, int max) {
    return 'Сегодня: $earned/$max O₂';
  }

  @override
  String get o2Rules => 'Правила O₂';

  @override
  String get o2RuleTime => 'Зарабатываются только с 08:00 до 00:00';

  @override
  String get o2RuleDaily => 'Макс. 500 O₂ в день';

  @override
  String get o2RuleFocus => 'Режим фокуса макс. 120 мин';

  @override
  String get o2RuleTransfer => 'Переводы и ставки запрещены';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂ (оценка)';
  }

  @override
  String get offGridMarket => 'Добыча';

  @override
  String get offGridMarketHint => 'Превращай баллы O₂ в реальные награды';

  @override
  String get redeem => 'Получить';

  @override
  String get insufficient => 'Недостаточно';

  @override
  String get redeemSuccess => 'Поздравляем!';

  @override
  String get couponCode => 'Твой код купона:';

  @override
  String get recentTransactions => 'Последние транзакции';

  @override
  String get noTransactions => 'Пока нет транзакций';

  @override
  String get categorySocial => 'Социальные';

  @override
  String get categoryGame => 'Игры';

  @override
  String get categoryVideo => 'Видео';

  @override
  String get categoryAudio => 'Музыка';

  @override
  String get categoryProductivity => 'Продуктивность';

  @override
  String get categoryNews => 'Новости';

  @override
  String get categoryGames => 'Игры';

  @override
  String get categoryShopping => 'Покупки';

  @override
  String get categoryBrowser => 'Браузер';

  @override
  String get categoryMaps => 'Карты';

  @override
  String get categoryImage => 'Фото';

  @override
  String get categoryOther => 'Прочее';

  @override
  String hello(String name) {
    return 'Привет, $name';
  }

  @override
  String get goalCompleted => 'Цель достигнута!';

  @override
  String get dailyGoalShort => 'Дневная цель';

  @override
  String get streakDaysLabel => 'дней подряд';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => 'ранг';

  @override
  String get offlineLabel => 'офлайн';

  @override
  String get todaysApps => 'Приложения сегодня';

  @override
  String get seeAll => 'Смотреть всё';

  @override
  String get activeDuel => 'Активная дуэль';

  @override
  String get startDuelPrompt => 'Начни дуэль!';

  @override
  String get you => 'Ты';

  @override
  String moreCount(int count) {
    return '+$count ещё';
  }

  @override
  String get removeWithPro => 'Убрать с Про';

  @override
  String get adLabel => 'Реклама';

  @override
  String get focus => 'Фокус';

  @override
  String get legal => 'Правовая информация';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get termsOfService => 'Условия использования';

  @override
  String get kvkkText => 'Уведомление о защите данных';

  @override
  String get deleteMyAccount => 'Удалить мой аккаунт';

  @override
  String get edit => 'Изменить';

  @override
  String get adminAddLoot => 'Администратор: Добавить добычу';

  @override
  String get continueConsent => 'Продолжая, ты';

  @override
  String get acceptTermsSuffix => 'соглашаешься.';

  @override
  String get alreadyHaveAccount => 'У меня уже есть аккаунт';

  @override
  String get screenTimePermissionTitle =>
      'Нам нужно отслеживать твоё время экрана';

  @override
  String get screenTimePermissionDesc =>
      'Для просмотра времени, проведённого в каждом приложении, требуется доступ к времени экрана.';

  @override
  String get screenTimeGranted => 'Разрешение на время экрана получено!';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get skip => 'Пропустить';

  @override
  String get yourName => 'Твоё имя';

  @override
  String get nameHint => 'Введи своё имя';

  @override
  String get ageGroup => 'Возрастная группа';

  @override
  String get imReady => 'Я готов';

  @override
  String get dailyGoalTitle => 'Твоя дневная цель';

  @override
  String get goalQuestion =>
      'Сколько часов экранного времени ты хочешь достигать в день?';

  @override
  String get goalMotivational1 =>
      'Потрясающе! Настоящая цель цифрового детокса 💪';

  @override
  String get goalMotivational2 => 'Сбалансированная цель, у тебя получится! 🎯';

  @override
  String get goalMotivational3 => 'Хорошее начало, можно снижать постепенно 📉';

  @override
  String get goalMotivational4 => 'Шаг за шагом, каждая минута важна ⭐';

  @override
  String get next => 'Далее';

  @override
  String hourShort(int count) {
    return '$countч';
  }

  @override
  String get welcomeSlogan =>
      'Отложи телефон. Обгони друзей.\nСтань #1 в своём городе.';

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
  String get ok => 'ОК';

  @override
  String get error => 'Ошибка';

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get loading => 'Загрузка...';

  @override
  String get loadFailed => 'Не удалось загрузить';

  @override
  String get noDataYet => 'Данных пока нет';

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

  @override
  String get noDuelsYet => 'Дуэлей пока нет';

  @override
  String get noDuelsYetSubtitle => 'Начни свою первую дуэль!';

  @override
  String get activeDuelsTitle => 'Активные дуэли';

  @override
  String get newDuel => 'Новая дуэль';

  @override
  String get selectDuelType => 'Выбрать тип дуэли';

  @override
  String get selectDurationStep => 'Выбрать продолжительность';

  @override
  String get selectOpponent => 'Выбрать соперника';

  @override
  String get duelStartButton => 'Начать дуэль! ⚔️';

  @override
  String get freePlanDuelLimit =>
      'Бесплатный план допускает не более 3 активных дуэлей! Перейди на Про.';

  @override
  String get quickSelect => 'Быстрый выбор';

  @override
  String get customDuration => 'Произвольная длительность';

  @override
  String selectedDuration(String duration) {
    return 'Выбрано: $duration';
  }

  @override
  String get minDurationWarning => 'Нужно выбрать не менее 10 минут';

  @override
  String get selectPenalty => 'Выбрать штраф (необязательно)';

  @override
  String get searchFriend => 'Найти друга...';

  @override
  String get inviteWithLink => 'Пригласить по ссылке 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '$countмин сегодня';
  }

  @override
  String duelRemaining(int h, int m) {
    return 'Осталось $hч $mм';
  }

  @override
  String get remainingTime => 'Оставшееся время';

  @override
  String watchersCount(int count) {
    return 'Смотрят $count 👀';
  }

  @override
  String get giveUp => 'Сдаться';

  @override
  String get duelWon => 'Ты победил! 🎉';

  @override
  String get duelLost => 'Ты проиграл 😔';

  @override
  String get greatPerformance => 'Отличный результат!';

  @override
  String get betterNextTime => 'В следующий раз повезёт!';

  @override
  String get revenge => 'Реванш 🔥';

  @override
  String get share => 'Поделиться';

  @override
  String get selectFriend => 'Выбрать друга';

  @override
  String get orSendLink => 'или отправить ссылку';

  @override
  String get social => 'Социальные';

  @override
  String get myFriends => 'Мои друзья';

  @override
  String get inMyCity => 'В моём городе';

  @override
  String get shareFirstStory => 'Будь первым, кто поделится офлайн-моментом!';

  @override
  String get createStoryTitle => 'Поделиться историей';

  @override
  String get addPhoto => 'Добавить фото';

  @override
  String get whatAreYouDoing => 'Что ты делаешь?';

  @override
  String get captionHint => 'Что ты делаешь вдали от телефона?';

  @override
  String get howLongVisible => 'Как долго она будет видна?';

  @override
  String get whoCanSee => 'Кто может видеть?';

  @override
  String get onlyFriends => 'Только мои друзья';

  @override
  String get cityPeople => 'Жители моего города';

  @override
  String get photoStoriesPro =>
      'Истории с фото — только для Про! Настройки > Off-Grid Клуб';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерея';

  @override
  String get writeFirst => 'Сначала напиши что-нибудь!';

  @override
  String get inappropriateContent => 'Обнаружен неприемлемый контент';

  @override
  String viewsCount(int count) {
    return '$count просмотров';
  }

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get changePhoto => 'Сменить фото';

  @override
  String get firstName => 'Имя';

  @override
  String get firstNameHint => 'Твоё имя';

  @override
  String get lastName => 'Фамилия';

  @override
  String get lastNameHint => 'Твоя фамилия';

  @override
  String get usernameLabel => 'Имя пользователя';

  @override
  String get updateLocation => 'Обновить местоположение';

  @override
  String get locationUnknown => 'Неизвестно';

  @override
  String get save => 'Сохранить';

  @override
  String get usernameAvailable => 'Доступно';

  @override
  String get usernameTaken => 'Это имя пользователя занято';

  @override
  String get usernameFormatError =>
      'Не менее 3 символов, только буквы, цифры и _';

  @override
  String get profileUpdated => 'Профиль обновлён';

  @override
  String get photoSelectedDemo =>
      'Фото выбрано (не будет загружено в демо-режиме)';

  @override
  String get locationError => 'Не удалось получить местоположение';

  @override
  String get errorOccurred => 'Произошла ошибка';

  @override
  String get detailedScreenTime => 'Подробное время экрана';

  @override
  String get monthlyTop10 => 'Топ-10 за месяц';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get noFriendsYet => 'Друзей пока нет';

  @override
  String get noFriendsHint => 'Начни с добавления друга';

  @override
  String get showQrCode => 'Показать свой QR-код';

  @override
  String get enterCode => 'Ввести код';

  @override
  String get inviteLinkShare => 'Поделиться ссылкой-приглашением';

  @override
  String get startDuelAction => 'Начать дуэль';

  @override
  String get pointsLabel => 'Очки';

  @override
  String get mostUsedLabel => 'Чаще всего:';

  @override
  String get recentBadges => 'Последние значки';

  @override
  String get allBadgesLabel => 'Все значки';

  @override
  String get removeFriend => 'Удалить из друзей';

  @override
  String get removeFriendConfirm =>
      'Ты уверен, что хочешь удалить этого человека из списка друзей?';

  @override
  String get remove => 'Удалить';

  @override
  String get requestSent => 'Запрос отправлен';

  @override
  String get whatCouldYouDo => 'Что ты мог бы сделать?';

  @override
  String get back => 'Назад';

  @override
  String get weekly => 'Недельный';

  @override
  String get daily => 'Дневной';

  @override
  String get mostUsedApps => 'Самые используемые приложения';

  @override
  String get unlockSection => 'Разблокировки';

  @override
  String get selectedDayLabel => 'Выбранный день';

  @override
  String get todayLabel => 'Сегодня';

  @override
  String weeklyAvgLabel(int h, int m) {
    return 'Дневное среднее: $hч $mм';
  }

  @override
  String get firstUnlock => 'Первая разблокировка';

  @override
  String get mostOpened => 'Открывали чаще всего';

  @override
  String get timesPickedUp => 'Количество подъёмов';

  @override
  String get openingCount => 'открытий';

  @override
  String get notificationUnit => 'уведомлений';

  @override
  String get timesUnit => 'раз';

  @override
  String get turkey => 'Турция';

  @override
  String get consecutiveDays => 'дней подряд';

  @override
  String bestStreakLabel(int days) {
    return 'Лучший результат: $days дней';
  }

  @override
  String get seriFriends => 'Друзья';

  @override
  String get oxygenTitle => 'Кислород (O₂)';

  @override
  String get totalO2 => 'Всего';

  @override
  String get remainingShort => 'Осталось';

  @override
  String get noOffersYet => 'Предложений пока нет';

  @override
  String o2SpentMsg(int amount) {
    return 'Потрачено $amount O₂';
  }

  @override
  String get mapLoadFailed => 'Не удалось загрузить карту';

  @override
  String confirmRedeemMsg(String reward) {
    return 'Хочешь получить $reward?';
  }

  @override
  String itemReceived(String item) {
    return '$item получено!';
  }

  @override
  String get insufficientO2 => 'Недостаточно O₂';

  @override
  String get season1Title => 'Сезон 1';

  @override
  String get season1Subtitle => 'Весеннее пробуждение';

  @override
  String get seasonPassBtn => 'Сезонный пропуск (99TL)';

  @override
  String get seasonPassLabel => 'Сезонный пропуск';

  @override
  String get noGroupsYet => 'Групп пока нет';

  @override
  String get noGroupsSubtitle => 'Создай группу с друзьями';

  @override
  String get newGroup => 'Новая группа';

  @override
  String memberCount(int count) {
    return '$count участников';
  }

  @override
  String get weeklyGoal => 'Недельная цель';

  @override
  String challengeProgress(int percent) {
    return '$percent% выполнено';
  }

  @override
  String get membersLabel => 'Участники';

  @override
  String get inviteLink => 'Ссылка-приглашение';

  @override
  String get linkCopied => 'Ссылка скопирована!';

  @override
  String get copy => 'Копировать';

  @override
  String get qrCode => 'QR-код';

  @override
  String get groupNameLabel => 'Название группы';

  @override
  String get groupNameHint => 'Введи название группы';

  @override
  String get groupNameEmpty => 'Название группы не может быть пустым';

  @override
  String dailyGoalHours(int hours) {
    return 'Дневная цель: $hours ч';
  }

  @override
  String get addMember => 'Добавить участника';

  @override
  String selectedCount(int count) {
    return 'Выбрано: $count';
  }

  @override
  String get create => 'Создать';

  @override
  String groupCreated(String name) {
    return '$name создана!';
  }

  @override
  String invitedCount(int count) {
    return 'Приглашено $count человек';
  }

  @override
  String get screenTimeLower => 'время экрана';

  @override
  String get improvedFromLastWeek => 'На 12% лучше, чем на прошлой неделе';

  @override
  String get o2Earned => 'Заработано O₂';

  @override
  String get friendRank => 'Рейтинг среди друзей';

  @override
  String cityRankLabel(String city) {
    return 'Рейтинг в $city';
  }

  @override
  String get mostUsed => 'Используется чаще всего';

  @override
  String get offGridClub => 'Off-Grid Клуб';

  @override
  String get clubSubtitle => 'Достигни цифрового баланса и получай награды.';

  @override
  String get planStarter => 'Стартовый';

  @override
  String get planStarterSubtitle => 'Начни с основ';

  @override
  String get currentPlanBtn => 'Текущий план';

  @override
  String get billingMonthly => 'Ежемесячно';

  @override
  String get billingYearly => 'Ежегодно';

  @override
  String get yearlySavings => 'Скидка 33%';

  @override
  String get planComparison => 'Сравнение планов';

  @override
  String get breathTechniquesComp => 'Техники дыхания';

  @override
  String get activeDuelsComp => 'Активные дуэли';

  @override
  String get storyPhoto => 'Фото в истории';

  @override
  String get heatMap => 'Тепловая карта';

  @override
  String get top10Report => 'Отчёт Топ-10';

  @override
  String get exclusiveBadges => 'Эксклюзивные значки';

  @override
  String get adFree => 'Без рекламы';

  @override
  String get familyPlanComp => 'Семейный план';

  @override
  String get familyReport => 'Семейный отчёт';

  @override
  String get exclusiveThemes => 'Эксклюзивные темы';

  @override
  String get prioritySupport => 'Приоритетная поддержка';

  @override
  String get billingNote =>
      'Подписку можно отменить в любое время.\nОплата через App Store/Google Play.\nПодписка автоматически продлевается.';

  @override
  String get restoreSuccess => 'Покупки восстановлены!';

  @override
  String get restoreFailed => 'Покупок для восстановления не найдено.';

  @override
  String get packagesLoadFailed =>
      'Не удалось загрузить пакеты. Попробуй ещё раз.';

  @override
  String get themesTitle => 'Темы';

  @override
  String get themeLockedMsg =>
      'Эта тема только для Про+! Настройки > Off-Grid Клуб';

  @override
  String get familyPlanTitle => 'Семейный план';

  @override
  String get familyPlanLocked => 'Цифровой баланс вместе';

  @override
  String get familyPlanLockedDesc =>
      'Добавь до 5 членов семьи, ставьте цели вместе и получайте еженедельные семейные отчёты.';

  @override
  String get weeklyFamilyReport => 'Еженедельный семейный отчёт';

  @override
  String get familyRanking => 'Семейный рейтинг';

  @override
  String get totalOffline => 'Всего офлайн';

  @override
  String get average => 'Среднее';

  @override
  String get best => 'Лучший';

  @override
  String offlineTime(int h, int m) {
    return '$hч $mм офлайн';
  }

  @override
  String get enterName => 'Введи имя';

  @override
  String get cannotUndo => 'Это действие нельзя отменить!';

  @override
  String get deleteWarningDesc =>
      'При удалении аккаунта следующие данные будут удалены навсегда:';

  @override
  String get deleteItem1 => 'Информация профиля и аватар';

  @override
  String get deleteItem2 => 'Вся статистика времени экрана';

  @override
  String get deleteItem3 => 'Список друзей и дуэли';

  @override
  String get deleteItem4 => 'Истории и комментарии';

  @override
  String get deleteItem5 => 'Баллы O₂ и добыча';

  @override
  String get deleteItem6 => 'История подписки';

  @override
  String get deleteSubscriptionNote =>
      'Если у тебя есть активная подписка, сначала отмени её через Apple App Store или Google Play Store.';

  @override
  String get deleteConfirmCheck =>
      'Я понимаю, что мой аккаунт и все данные будут удалены навсегда.';

  @override
  String get deleteAccountBtn => 'Удалить мой аккаунт навсегда';

  @override
  String get deleteErrorMsg => 'Произошла ошибка. Попробуй ещё раз.';

  @override
  String get emailHint => 'Электронная почта';

  @override
  String get passwordHint => 'Пароль';

  @override
  String get forgotPassword => 'Забыл пароль';

  @override
  String get passwordResetSent => 'Письмо для сброса пароля отправлено.';

  @override
  String get signUp => 'Регистрация';

  @override
  String get signIn => 'Войти';

  @override
  String get orDivider => 'или';

  @override
  String get continueWithGoogleShort => 'Продолжить с Google';

  @override
  String get continueWithAppleShort => 'Продолжить с Apple';

  @override
  String get noAccountYet => 'Ещё нет аккаунта? ';

  @override
  String get adminExistingPoints => 'Существующие точки';

  @override
  String get adminSearchPlace => 'Найти место...';

  @override
  String get adminRewardTitle => 'Название награды (напр., Бесплатный кофе)';

  @override
  String get adminO2Cost => 'Стоимость O₂';

  @override
  String get adminSave => 'Сохранить';

  @override
  String get adminSaved => 'Сохранено!';

  @override
  String get adminDeleteTitle => 'Удалить';

  @override
  String get adminDeleteMsg => 'Ты уверен, что хочешь удалить эту точку?';

  @override
  String adminDeleteError(String error) {
    return 'Ошибка удаления: $error';
  }

  @override
  String get adminFillFields => 'Заполни награду и стоимость O₂';

  @override
  String breathCount(int count) {
    return '$count вдохов';
  }

  @override
  String minutesRemaining(int count) {
    return 'Осталось $countмин';
  }

  @override
  String focusMinutes(int count) {
    return 'Ты сфокусировался на $count минут';
  }

  @override
  String get o2TimeRestriction => 'O₂ зарабатываются только с 08:00 до 00:00';

  @override
  String get breathTechniqueProMsg =>
      'Эта техника только для Про! Настройки > Off-Grid Клуб';

  @override
  String get inhale => 'Вдох';

  @override
  String get holdBreath => 'Задержка';

  @override
  String get exhale => 'Выдох';

  @override
  String get waitBreath => 'Ожидание';

  @override
  String get proMostPopular => 'Самый популярный';

  @override
  String get proFamilyBadge => 'СЕМЬЯ';

  @override
  String get comparedToLastWeek => 'по сравнению с прошлой неделей';

  @override
  String get appBlockTitle => 'Блокировка приложений';

  @override
  String get appBlockSchedule => 'Расписание';

  @override
  String get appBlockEnableBlocking => 'Включить блокировку';

  @override
  String get appBlockActive => 'Блокировка включена';

  @override
  String get appBlockInactive => 'Блокировка выключена';

  @override
  String get appBlockStrictMode => 'Строгий режим';

  @override
  String get appBlockStrictDesc => 'Нельзя отключить до окончания таймера';

  @override
  String get appBlockStrictExpired => 'Таймер истёк';

  @override
  String get appBlockStrictDurationTitle => 'Длительность строгого режима';

  @override
  String get appBlockDuration30m => '30 минут';

  @override
  String get appBlockDuration1h => '1 час';

  @override
  String get appBlockDuration2h => '2 часа';

  @override
  String get appBlockDuration4h => '4 часа';

  @override
  String get appBlockDurationAllDay => 'Весь день (24 часа)';

  @override
  String get appBlockScheduleTitle => 'Расписание блокировки';

  @override
  String get appBlockScheduleDesc =>
      'Установить ежедневные временные диапазоны';

  @override
  String get appBlockBlockedApps => 'Заблокированные приложения';

  @override
  String get appBlockNoApps => 'Приложения ещё не добавлены';

  @override
  String get appBlockAddApp => 'Добавить приложение';

  @override
  String get appBlockPickerTitle => 'Выбрать приложение';

  @override
  String get appBlockPresetWork => 'Рабочие часы (09-18)';

  @override
  String get appBlockPresetSleep => 'Время сна (23-07)';

  @override
  String get appBlockPresetAllDay => 'Весь день';

  @override
  String get appBlockInterventionTitle => 'Подожди секунду...';

  @override
  String get appBlockInterventionSubtitle =>
      'Сделай вдох и понаблюдай за собой';

  @override
  String get appBlockInterventionGiveUp => 'Не буду';

  @override
  String get appBlockInterventionOpenAnyway => 'Всё равно открыть';

  @override
  String get appBlockStrictModeActive => 'Строгий режим — нельзя открыть';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return 'На этой неделе вы провели $hours часов в $app';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return 'Вы отказались $count раз в этом месяце';
  }

  @override
  String get pickAppToBan => 'Выбрать приложение для блокировки';

  @override
  String get pickAppToBanDesc =>
      'Ваш оппонент не сможет открыть это приложение 24 часа';

  @override
  String get pickCategory => 'Выбрать категорию';

  @override
  String get pickCategoryDesc =>
      'Учитывается только использование в этой категории';

  @override
  String get rollDiceForTarget => 'Бросьте кубик для вашей цели';

  @override
  String get rollDiceDesc =>
      'Значение кубика × 30 минут = целевая длительность';

  @override
  String get diceTapToRoll => 'Нажмите, чтобы бросить';

  @override
  String get diceRolling => 'Бросаем...';

  @override
  String diceResult(int value) {
    return 'Результат: $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return 'Целевая длительность: $minutes мин';
  }

  @override
  String get chooseTeammates => 'Выбрать напарников';

  @override
  String teammatesSelected(int count) {
    return '$count/3 выбрано  ·  Выберите 2 или 3 напарников';
  }

  @override
  String get nightDuelInfo => 'Ночная дуэль';

  @override
  String get nightDuelRange => '23:00 — 07:00';

  @override
  String get nightDuelBody =>
      'Спите, не касаясь телефона. Кто продержится дольше — побеждает. Фиксированные 8 часов.';

  @override
  String get nightDuelAutoStart => 'Эта дуэль начнётся автоматически в 23:00.';

  @override
  String get mysteryMissionTitle => 'Загадочная миссия';

  @override
  String get mysteryMissionSubtitle =>
      'Ваша миссия раскрывается при старте дуэли';

  @override
  String get mysteryMissionBody =>
      'Когда вы начнёте дуэль, будет выбрана случайная миссия.';

  @override
  String get mysteryStart => 'Начать миссию';

  @override
  String opponentWantsToBanApp(String app) {
    return 'Ваш оппонент хочет, чтобы вы заблокировали $app';
  }

  @override
  String opponentWantsCategory(String category) {
    return 'Ваш оппонент хочет соревноваться в категории $category';
  }

  @override
  String get proposeDifferentApp =>
      'У меня нет этого приложения, предложите другое';

  @override
  String get proposeDifferentCategory =>
      'Я не использую эту категорию, предложите другую';

  @override
  String get acceptInvite => 'Принять';

  @override
  String proposalSent(String value) {
    return 'Предложение отправлено: $value';
  }

  @override
  String get stepAppPicker => 'Выбрать приложение';

  @override
  String get stepCategoryPicker => 'Выбрать категорию';

  @override
  String get stepDice => 'Бросить кубик';

  @override
  String get stepNightInfo => 'Ночная дуэль';

  @override
  String get stepMystery => 'Загадочная миссия';

  @override
  String get stepTeamPicker => 'Выбрать напарников';
}
