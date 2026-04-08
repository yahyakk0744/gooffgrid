// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan => 'プラグを抜け。遊べ。デジタルに溺れるな。';

  @override
  String get home => 'ホーム';

  @override
  String get ranking => 'ランキング';

  @override
  String get duel => 'デュエル';

  @override
  String get profile => 'プロフィール';

  @override
  String get settings => '設定';

  @override
  String get stories => 'ストーリー';

  @override
  String get today => '今日';

  @override
  String get thisWeek => '今週';

  @override
  String get friends => '友達';

  @override
  String get friendsOf => 'の友達';

  @override
  String get allFriends => '全員';

  @override
  String get city => '都市';

  @override
  String get country => '国';

  @override
  String get global => 'グローバル';

  @override
  String minutes(int count) {
    return '$count分';
  }

  @override
  String hours(int count) {
    return '$count時間';
  }

  @override
  String hoursMinutes(int h, int m) {
    return '$h時間$m分';
  }

  @override
  String get screenTime => 'スクリーンタイム';

  @override
  String get phonePickups => 'スマホを手に取った回数';

  @override
  String pickupsToday(int count) {
    return '今日$count回手に取りました';
  }

  @override
  String get topTriggers => 'よく使うきっかけ';

  @override
  String get longestOffScreen => '最長オフライン時間';

  @override
  String get dailyGoal => '1日の目標';

  @override
  String goalHours(int count) {
    return '目標: $count時間';
  }

  @override
  String get streak => '連続記録';

  @override
  String streakDays(int count) {
    return '$count日';
  }

  @override
  String get level => 'レベル';

  @override
  String get badges => 'バッジ';

  @override
  String get duels => 'デュエル';

  @override
  String get activeDuels => '進行中';

  @override
  String get pastDuels => '過去';

  @override
  String get createDuel => 'デュエルを作成';

  @override
  String get startDuel => 'デュエルを開始';

  @override
  String get invite => '招待';

  @override
  String get accept => '承諾';

  @override
  String get decline => '断る';

  @override
  String get win => '勝利';

  @override
  String get lose => '敗北';

  @override
  String get draw => '引き分け';

  @override
  String get addFriend => '友達を追加';

  @override
  String get friendCode => 'フレンドコード';

  @override
  String get search => '検索';

  @override
  String get notifications => '通知';

  @override
  String get dailyReminder => '毎日のリマインダー';

  @override
  String get duelNotifications => 'デュエル通知';

  @override
  String get locationSharing => '位置情報の共有';

  @override
  String get subscription => 'サブスクリプション';

  @override
  String get free => '無料';

  @override
  String get pro => 'プロ';

  @override
  String get proPlus => 'プロ+';

  @override
  String get currentPlan => '現在のプラン';

  @override
  String get recommended => 'おすすめ';

  @override
  String get start => '開始';

  @override
  String get upgradeToPro => 'プロにアップグレード';

  @override
  String get upgradeToProPlus => 'プロ+にアップグレード';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String monthlyPrice(String price) {
    return '$price/月';
  }

  @override
  String get freeFeature1 => '毎日のスクリーンタイム追跡';

  @override
  String get freeFeature2 => '友達ランキング';

  @override
  String get freeFeature3 => 'アクティブなデュエル3件';

  @override
  String get freeFeature4 => '基本バッジ';

  @override
  String get proFeature1 => '全ランキング（都市・国・グローバル）';

  @override
  String get proFeature2 => '詳細な統計とフォーカスカレンダー';

  @override
  String get proFeature3 => '無制限デュエル';

  @override
  String get proFeature4 => 'Off-Gridパス付き';

  @override
  String get proFeature5 => '広告なし体験';

  @override
  String get proPlusFeature1 => 'プロの全機能';

  @override
  String get proPlusFeature2 => 'ファミリープラン（5人）';

  @override
  String get proPlusFeature3 => '優先サポート';

  @override
  String get proPlusFeature4 => '限定バッジ＆テーマ';

  @override
  String get proPlusFeature5 => 'ベータ機能への早期アクセス';

  @override
  String get paywallTitle => 'Off-Gridクラブ';

  @override
  String get paywallSubtitle => 'スクリーンを離れた分だけ報われる。';

  @override
  String get logout => 'ログアウト';

  @override
  String get shareProfile => 'プロフィールを共有';

  @override
  String get shareReportCard => '自分の記録を見せよう';

  @override
  String get appUsage => 'アプリ使用状況';

  @override
  String get whatDidYouUse => '今日は何を使いましたか？';

  @override
  String get weeklyReport => '週間レポート';

  @override
  String get weeklyTrend => '7日間のトレンド';

  @override
  String get seasons => 'シーズン';

  @override
  String get seasonPass => 'Off-Gridパス';

  @override
  String get groups => 'グループ';

  @override
  String get createGroup => 'グループを作成';

  @override
  String get stats => '統計';

  @override
  String get analytics => 'アナリティクス';

  @override
  String get detailedAnalytics => '詳細アナリティクス';

  @override
  String get categories => 'カテゴリ';

  @override
  String get weeklyUsage => '週間使用状況';

  @override
  String get appDetails => 'アプリ詳細';

  @override
  String get focusCalendar => 'フォーカスカレンダー';

  @override
  String get whatIf => 'もし〜だったら？';

  @override
  String get focusMode => '呼吸';

  @override
  String get startFocusMode => 'フォーカスモードを開始';

  @override
  String get focusing => '集中しています...';

  @override
  String focusComplete(int minutes) {
    return 'すごい！$minutes分間集中しました';
  }

  @override
  String get focusTimeout => 'セッションタイムアウト';

  @override
  String get focusTimeoutDesc => '120分の制限に達しました。\nまだそこにいますか？';

  @override
  String get end => '終了';

  @override
  String get reportCard => '通知表';

  @override
  String get antiSocialStory => 'アンチソーシャルな瞬間';

  @override
  String get storyQuestion => 'スマホから離れて何をしていますか？';

  @override
  String get postStory => '投稿';

  @override
  String get storyExpired => '期限切れ';

  @override
  String get noStories => 'まだストーリーはありません';

  @override
  String get noStoriesHint => '友達がオフグリッドの瞬間をシェアし始めましょう！';

  @override
  String get storyBlocked => 'ストーリーをシェアできません';

  @override
  String get storyBlockedHint =>
      '1日のスクリーンタイム目標を超えました。目標を守ってストーリーをシェアする権利を獲得しよう！';

  @override
  String get duration => '時間';

  @override
  String get walk => '散歩';

  @override
  String get run => 'ランニング';

  @override
  String get book => '読書';

  @override
  String get meditation => '瞑想';

  @override
  String get nature => '自然';

  @override
  String get sports => 'スポーツ';

  @override
  String get music => '音楽';

  @override
  String get cooking => '料理';

  @override
  String get friendsActivity => '友達';

  @override
  String get family => '家族';

  @override
  String get o2Balance => 'O₂ポイント';

  @override
  String o2Remaining(int count) {
    return '残り: $count';
  }

  @override
  String o2Today(int earned, int max) {
    return '今日: $earned/$max O₂';
  }

  @override
  String get o2Rules => 'O₂ルール';

  @override
  String get o2RuleTime => '08:00〜00:00の間のみ獲得可能';

  @override
  String get o2RuleDaily => '1日最大500 O₂';

  @override
  String get o2RuleFocus => 'フォーカスモード最大120分';

  @override
  String get o2RuleTransfer => '転送・賭けは禁止';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂（推定）';
  }

  @override
  String get offGridMarket => '戦利品';

  @override
  String get offGridMarketHint => 'O₂ポイントをリアルな特典に変えよう';

  @override
  String get redeem => '交換';

  @override
  String get insufficient => '不足';

  @override
  String get redeemSuccess => 'おめでとう！';

  @override
  String get couponCode => 'クーポンコード:';

  @override
  String get recentTransactions => '最近の取引';

  @override
  String get noTransactions => 'まだ取引はありません';

  @override
  String get categorySocial => 'SNS';

  @override
  String get categoryGame => 'ゲーム';

  @override
  String get categoryVideo => '動画';

  @override
  String get categoryAudio => '音楽';

  @override
  String get categoryProductivity => '生産性';

  @override
  String get categoryNews => 'ニュース';

  @override
  String get categoryGames => 'ゲーム';

  @override
  String get categoryShopping => 'ショッピング';

  @override
  String get categoryBrowser => 'ブラウザ';

  @override
  String get categoryMaps => 'マップ';

  @override
  String get categoryImage => '写真';

  @override
  String get categoryOther => 'その他';

  @override
  String hello(String name) {
    return 'こんにちは、$name';
  }

  @override
  String get goalCompleted => '目標達成！';

  @override
  String get dailyGoalShort => '本日の目標';

  @override
  String get streakDaysLabel => '日連続';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => 'ランク';

  @override
  String get offlineLabel => 'オフライン';

  @override
  String get todaysApps => '今日のアプリ';

  @override
  String get seeAll => 'すべて見る';

  @override
  String get activeDuel => '進行中のデュエル';

  @override
  String get startDuelPrompt => 'デュエルを始めよう！';

  @override
  String get you => 'あなた';

  @override
  String moreCount(int count) {
    return '+$count件';
  }

  @override
  String get removeWithPro => 'プロで削除';

  @override
  String get adLabel => '広告';

  @override
  String get focus => 'フォーカス';

  @override
  String get legal => '法的情報';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsOfService => '利用規約';

  @override
  String get kvkkText => '個人情報保護に関するお知らせ';

  @override
  String get deleteMyAccount => 'アカウントを削除する';

  @override
  String get edit => '編集';

  @override
  String get adminAddLoot => '管理者：戦利品を追加';

  @override
  String get continueConsent => '続けることで';

  @override
  String get acceptTermsSuffix => '同意します。';

  @override
  String get alreadyHaveAccount => 'すでにアカウントを持っています';

  @override
  String get screenTimePermissionTitle => 'スクリーンタイムの追跡が必要です';

  @override
  String get screenTimePermissionDesc =>
      '各アプリの使用時間を確認するために、スクリーンタイムへのアクセスが必要です。';

  @override
  String get screenTimeGranted => 'スクリーンタイムの許可が付与されました！';

  @override
  String get continueButton => '続ける';

  @override
  String get skip => 'スキップ';

  @override
  String get yourName => 'お名前';

  @override
  String get nameHint => '名前を入力してください';

  @override
  String get ageGroup => '年齢グループ';

  @override
  String get imReady => '準備完了';

  @override
  String get dailyGoalTitle => '1日の目標';

  @override
  String get goalQuestion => '1日のスクリーンタイムの目標は何時間ですか？';

  @override
  String get goalMotivational1 => 'すごい！本物のデジタルデトックス目標 💪';

  @override
  String get goalMotivational2 => 'バランスの良い目標、できますよ！ 🎯';

  @override
  String get goalMotivational3 => '良いスタート、少しずつ減らせます 📉';

  @override
  String get goalMotivational4 => '一歩一歩、1分1分が大切です ⭐';

  @override
  String get next => '次へ';

  @override
  String hourShort(int count) {
    return '$count時間';
  }

  @override
  String get welcomeSlogan => 'スマホを置いて。友達に勝とう。\n都市で#1になれ。';

  @override
  String get deleteAccount => 'アカウントを削除';

  @override
  String get deleteAccountConfirm => 'アカウントとすべてのデータが完全に削除されます。この操作は元に戻せません。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get ok => 'OK';

  @override
  String get error => 'エラー';

  @override
  String get tryAgain => 'もう一度試す';

  @override
  String get loading => '読み込み中...';

  @override
  String get loadFailed => '読み込み失敗';

  @override
  String get noDataYet => 'まだデータがありません';

  @override
  String get welcome => 'ようこそ';

  @override
  String get welcomeSubtitle => 'スマホを置いて。友達に勝とう。';

  @override
  String get continueWithGoogle => 'Googleで続ける';

  @override
  String get continueWithApple => 'Appleで続ける';

  @override
  String get continueWithEmail => 'メールで続ける';

  @override
  String get permissionsTitle => '権限';

  @override
  String get permissionsSubtitle => 'スクリーンタイムを追跡するための許可が必要です。';

  @override
  String get grantPermission => '許可を与える';

  @override
  String get setupProfile => 'プロフィールを設定';

  @override
  String get displayName => '表示名';

  @override
  String get selectCity => '都市を選択';

  @override
  String get selectGoal => '1日の目標を選択';

  @override
  String get noDuelsYet => 'まだデュエルはありません';

  @override
  String get noDuelsYetSubtitle => '最初のデュエルを始めよう！';

  @override
  String get activeDuelsTitle => '進行中のデュエル';

  @override
  String get newDuel => '新しいデュエル';

  @override
  String get selectDuelType => 'デュエルの種類を選択';

  @override
  String get selectDurationStep => '期間を選択';

  @override
  String get selectOpponent => '対戦相手を選択';

  @override
  String get duelStartButton => 'デュエル開始！ ⚔️';

  @override
  String get freePlanDuelLimit => '無料プランは最大3件のアクティブなデュエルのみ！プロにアップグレードしてください。';

  @override
  String get quickSelect => 'クイック選択';

  @override
  String get customDuration => 'カスタム期間';

  @override
  String selectedDuration(String duration) {
    return '選択中: $duration';
  }

  @override
  String get minDurationWarning => '少なくとも10分選択してください';

  @override
  String get selectPenalty => 'ペナルティを選択（任意）';

  @override
  String get searchFriend => '友達を検索...';

  @override
  String get inviteWithLink => 'リンクで招待 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '今日$count分';
  }

  @override
  String duelRemaining(int h, int m) {
    return '残り$h時間$m分';
  }

  @override
  String get remainingTime => '残り時間';

  @override
  String watchersCount(int count) {
    return '$count人が見ています 👀';
  }

  @override
  String get giveUp => 'ギブアップ';

  @override
  String get duelWon => '勝ちました！ 🎉';

  @override
  String get duelLost => '負けました 😔';

  @override
  String get greatPerformance => '素晴らしいパフォーマンス！';

  @override
  String get betterNextTime => '次回はもっとうまくいきます！';

  @override
  String get revenge => 'リベンジ 🔥';

  @override
  String get share => 'シェア';

  @override
  String get selectFriend => '友達を選択';

  @override
  String get orSendLink => 'またはリンクを送信';

  @override
  String get social => 'ソーシャル';

  @override
  String get myFriends => 'マイフレンズ';

  @override
  String get inMyCity => '私の都市';

  @override
  String get shareFirstStory => '最初にオフグリッドの瞬間をシェアしよう！';

  @override
  String get createStoryTitle => 'ストーリーをシェア';

  @override
  String get addPhoto => '写真を追加';

  @override
  String get whatAreYouDoing => '何をしていますか？';

  @override
  String get captionHint => 'スマホから離れて何をしていますか？';

  @override
  String get howLongVisible => 'どのくらいの期間表示しますか？';

  @override
  String get whoCanSee => '誰が見られますか？';

  @override
  String get onlyFriends => '友達のみ';

  @override
  String get cityPeople => '私の都市の人々';

  @override
  String get photoStoriesPro => '写真ストーリーはプロ限定！設定 > Off-Gridクラブ';

  @override
  String get camera => 'カメラ';

  @override
  String get gallery => 'ギャラリー';

  @override
  String get writeFirst => '最初に何か書いてください！';

  @override
  String get inappropriateContent => '不適切なコンテンツが検出されました';

  @override
  String viewsCount(int count) {
    return '$count回閲覧';
  }

  @override
  String get editProfile => 'プロフィールを編集';

  @override
  String get changePhoto => '写真を変更';

  @override
  String get firstName => '名前';

  @override
  String get firstNameHint => 'あなたの名前';

  @override
  String get lastName => '苗字';

  @override
  String get lastNameHint => 'あなたの苗字';

  @override
  String get usernameLabel => 'ユーザー名';

  @override
  String get updateLocation => '位置情報を更新';

  @override
  String get locationUnknown => '不明';

  @override
  String get save => '保存';

  @override
  String get usernameAvailable => '利用可能';

  @override
  String get usernameTaken => 'このユーザー名は使用されています';

  @override
  String get usernameFormatError => '3文字以上、英数字と_のみ使用可能';

  @override
  String get profileUpdated => 'プロフィールが更新されました';

  @override
  String get photoSelectedDemo => '写真が選択されました（デモモードではアップロードされません）';

  @override
  String get locationError => '位置情報を取得できませんでした';

  @override
  String get errorOccurred => 'エラーが発生しました';

  @override
  String get detailedScreenTime => '詳細スクリーンタイム';

  @override
  String get monthlyTop10 => '月間トップ10';

  @override
  String get searchHint => '検索...';

  @override
  String get noFriendsYet => 'まだ友達がいません';

  @override
  String get noFriendsHint => '友達を追加してみましょう';

  @override
  String get showQrCode => 'QRコードを表示';

  @override
  String get enterCode => 'コードを入力';

  @override
  String get inviteLinkShare => '招待リンクをシェア';

  @override
  String get startDuelAction => 'デュエルを開始';

  @override
  String get pointsLabel => 'ポイント';

  @override
  String get mostUsedLabel => '最も使用:';

  @override
  String get recentBadges => '最近のバッジ';

  @override
  String get allBadgesLabel => 'すべてのバッジ';

  @override
  String get removeFriend => '友達を削除';

  @override
  String get removeFriendConfirm => 'この人を友達リストから削除しますか？';

  @override
  String get remove => '削除';

  @override
  String get requestSent => 'リクエスト送信済み';

  @override
  String get whatCouldYouDo => '何ができたでしょうか？';

  @override
  String get back => '戻る';

  @override
  String get weekly => '週間';

  @override
  String get daily => '日別';

  @override
  String get mostUsedApps => '最も使用したアプリ';

  @override
  String get unlockSection => 'ロック解除';

  @override
  String get selectedDayLabel => '選択した日';

  @override
  String get todayLabel => '今日';

  @override
  String weeklyAvgLabel(int h, int m) {
    return '1日平均: $h時間$m分';
  }

  @override
  String get firstUnlock => '最初のロック解除';

  @override
  String get mostOpened => '最も開いた';

  @override
  String get timesPickedUp => '手に取った回数';

  @override
  String get openingCount => '回起動';

  @override
  String get notificationUnit => '件の通知';

  @override
  String get timesUnit => '回';

  @override
  String get turkey => 'トルコ';

  @override
  String get consecutiveDays => '日連続';

  @override
  String bestStreakLabel(int days) {
    return '最高記録: $days日';
  }

  @override
  String get seriFriends => '友達';

  @override
  String get oxygenTitle => '酸素 (O₂)';

  @override
  String get totalO2 => '合計';

  @override
  String get remainingShort => '残り';

  @override
  String get noOffersYet => 'まだオファーはありません';

  @override
  String o2SpentMsg(int amount) {
    return '$amount O₂ 使用';
  }

  @override
  String get mapLoadFailed => 'マップの読み込みに失敗しました';

  @override
  String confirmRedeemMsg(String reward) {
    return '$rewardを交換しますか？';
  }

  @override
  String itemReceived(String item) {
    return '$itemを交換しました！';
  }

  @override
  String get insufficientO2 => 'O₂が不足しています';

  @override
  String get season1Title => 'シーズン1';

  @override
  String get season1Subtitle => '春の目覚め';

  @override
  String get seasonPassBtn => 'シーズンパス (99TL)';

  @override
  String get seasonPassLabel => 'シーズンパス';

  @override
  String get noGroupsYet => 'まだグループはありません';

  @override
  String get noGroupsSubtitle => '友達とグループを作りましょう';

  @override
  String get newGroup => '新しいグループ';

  @override
  String memberCount(int count) {
    return '$count人のメンバー';
  }

  @override
  String get weeklyGoal => '週間目標';

  @override
  String challengeProgress(int percent) {
    return '$percent%達成';
  }

  @override
  String get membersLabel => 'メンバー';

  @override
  String get inviteLink => '招待リンク';

  @override
  String get linkCopied => 'リンクをコピーしました！';

  @override
  String get copy => 'コピー';

  @override
  String get qrCode => 'QRコード';

  @override
  String get groupNameLabel => 'グループ名';

  @override
  String get groupNameHint => 'グループ名を入力';

  @override
  String get groupNameEmpty => 'グループ名は空にできません';

  @override
  String dailyGoalHours(int hours) {
    return '1日の目標: $hours時間';
  }

  @override
  String get addMember => 'メンバーを追加';

  @override
  String selectedCount(int count) {
    return '$count件選択';
  }

  @override
  String get create => '作成';

  @override
  String groupCreated(String name) {
    return '$nameを作成しました！';
  }

  @override
  String invitedCount(int count) {
    return '$count人を招待しました';
  }

  @override
  String get screenTimeLower => 'スクリーンタイム';

  @override
  String get improvedFromLastWeek => '先週より12%改善';

  @override
  String get o2Earned => '獲得O₂';

  @override
  String get friendRank => '友達ランク';

  @override
  String cityRankLabel(String city) {
    return '$cityランク';
  }

  @override
  String get mostUsed => '最も使用';

  @override
  String get offGridClub => 'Off-Gridクラブ';

  @override
  String get clubSubtitle => 'デジタルバランスを達成して報われよう。';

  @override
  String get planStarter => 'スターター';

  @override
  String get planStarterSubtitle => '基本から始めよう';

  @override
  String get currentPlanBtn => '現在のプラン';

  @override
  String get billingMonthly => '月払い';

  @override
  String get billingYearly => '年払い';

  @override
  String get yearlySavings => '33%オフ';

  @override
  String get planComparison => 'プラン比較';

  @override
  String get breathTechniquesComp => '呼吸法';

  @override
  String get activeDuelsComp => 'アクティブなデュエル';

  @override
  String get storyPhoto => 'ストーリー写真';

  @override
  String get heatMap => 'ヒートマップ';

  @override
  String get top10Report => 'トップ10レポート';

  @override
  String get exclusiveBadges => '限定バッジ';

  @override
  String get adFree => '広告なし';

  @override
  String get familyPlanComp => 'ファミリープラン';

  @override
  String get familyReport => 'ファミリーレポート';

  @override
  String get exclusiveThemes => '限定テーマ';

  @override
  String get prioritySupport => '優先サポート';

  @override
  String get billingNote =>
      'サブスクリプションはいつでもキャンセルできます。\nApp Store/Google Play経由でお支払い。\nサブスクリプションは自動更新されます。';

  @override
  String get restoreSuccess => '購入を復元しました！';

  @override
  String get restoreFailed => '復元できる購入が見つかりませんでした。';

  @override
  String get packagesLoadFailed => 'パッケージの読み込みに失敗しました。もう一度試してください。';

  @override
  String get themesTitle => 'テーマ';

  @override
  String get themeLockedMsg => 'このテーマはプロ+限定！設定 > Off-Gridクラブ';

  @override
  String get familyPlanTitle => 'ファミリープラン';

  @override
  String get familyPlanLocked => '一緒にデジタルバランスを';

  @override
  String get familyPlanLockedDesc => '最大5人の家族を追加し、一緒に目標を設定して週間ファミリーレポートを受け取ろう。';

  @override
  String get weeklyFamilyReport => '週間ファミリーレポート';

  @override
  String get familyRanking => 'ファミリーランキング';

  @override
  String get totalOffline => '合計オフライン';

  @override
  String get average => '平均';

  @override
  String get best => '最高';

  @override
  String offlineTime(int h, int m) {
    return '$h時間$m分オフライン';
  }

  @override
  String get enterName => '名前を入力';

  @override
  String get cannotUndo => 'この操作は元に戻せません！';

  @override
  String get deleteWarningDesc => 'アカウントを削除すると、以下のデータが完全に削除されます：';

  @override
  String get deleteItem1 => 'プロフィール情報とアバター';

  @override
  String get deleteItem2 => 'すべてのスクリーンタイム統計';

  @override
  String get deleteItem3 => '友達リストとデュエル';

  @override
  String get deleteItem4 => 'ストーリーとコメント';

  @override
  String get deleteItem5 => 'O₂ポイントと戦利品';

  @override
  String get deleteItem6 => 'サブスクリプション履歴';

  @override
  String get deleteSubscriptionNote =>
      'アクティブなサブスクリプションがある場合は、Apple App StoreまたはGoogle Play Storeから先にキャンセルしてください。';

  @override
  String get deleteConfirmCheck => 'アカウントとすべてのデータが完全に削除されることを理解しました。';

  @override
  String get deleteAccountBtn => 'アカウントを完全に削除する';

  @override
  String get deleteErrorMsg => 'エラーが発生しました。もう一度試してください。';

  @override
  String get emailHint => 'メールアドレス';

  @override
  String get passwordHint => 'パスワード';

  @override
  String get forgotPassword => 'パスワードを忘れた';

  @override
  String get passwordResetSent => 'パスワードリセットメールを送信しました。';

  @override
  String get signUp => 'サインアップ';

  @override
  String get signIn => 'サインイン';

  @override
  String get orDivider => 'または';

  @override
  String get continueWithGoogleShort => 'Googleで続ける';

  @override
  String get continueWithAppleShort => 'Appleで続ける';

  @override
  String get noAccountYet => 'アカウントをお持ちでないですか？ ';

  @override
  String get adminExistingPoints => '既存ポイント';

  @override
  String get adminSearchPlace => '場所を検索...';

  @override
  String get adminRewardTitle => '報酬タイトル（例：無料コーヒー）';

  @override
  String get adminO2Cost => 'O₂コスト';

  @override
  String get adminSave => '保存';

  @override
  String get adminSaved => '保存しました！';

  @override
  String get adminDeleteTitle => '削除';

  @override
  String get adminDeleteMsg => 'このポイントを削除してもよいですか？';

  @override
  String adminDeleteError(String error) {
    return '削除エラー: $error';
  }

  @override
  String get adminFillFields => '報酬とO₂コストを入力してください';

  @override
  String breathCount(int count) {
    return '$count回呼吸';
  }

  @override
  String minutesRemaining(int count) {
    return '残り$count分';
  }

  @override
  String focusMinutes(int count) {
    return '$count分間集中しました';
  }

  @override
  String get o2TimeRestriction => 'O₂は08:00〜00:00の間のみ獲得可能';

  @override
  String get breathTechniqueProMsg => 'この呼吸法はプロ限定！設定 > Off-Gridクラブ';

  @override
  String get inhale => '吸う';

  @override
  String get holdBreath => '止める';

  @override
  String get exhale => '吐く';

  @override
  String get waitBreath => '待つ';

  @override
  String get proMostPopular => '最も人気';

  @override
  String get proFamilyBadge => 'ファミリー';

  @override
  String get comparedToLastWeek => '先週と比べて';

  @override
  String get appBlockTitle => 'アプリブロック';

  @override
  String get appBlockSchedule => 'スケジュール';

  @override
  String get appBlockEnableBlocking => 'ブロックを有効にする';

  @override
  String get appBlockActive => 'ブロック中';

  @override
  String get appBlockInactive => 'ブロック解除中';

  @override
  String get appBlockStrictMode => '厳格モード';

  @override
  String get appBlockStrictDesc => 'タイマーが終了するまで解除できません';

  @override
  String get appBlockStrictExpired => 'タイマー終了';

  @override
  String get appBlockStrictDurationTitle => '厳格モードの時間';

  @override
  String get appBlockDuration30m => '30分';

  @override
  String get appBlockDuration1h => '1時間';

  @override
  String get appBlockDuration2h => '2時間';

  @override
  String get appBlockDuration4h => '4時間';

  @override
  String get appBlockDurationAllDay => '終日（24時間）';

  @override
  String get appBlockScheduleTitle => 'ブロックスケジュール';

  @override
  String get appBlockScheduleDesc => '1日の時間帯を設定';

  @override
  String get appBlockBlockedApps => 'ブロック中のアプリ';

  @override
  String get appBlockNoApps => 'まだアプリが追加されていません';

  @override
  String get appBlockAddApp => 'アプリを追加';

  @override
  String get appBlockPickerTitle => 'アプリを選択';

  @override
  String get appBlockPresetWork => '勤務時間（09-18）';

  @override
  String get appBlockPresetSleep => '就寝時間（23-07）';

  @override
  String get appBlockPresetAllDay => '終日';

  @override
  String get appBlockInterventionTitle => 'ちょっと待って...';

  @override
  String get appBlockInterventionSubtitle => '深呼吸して自分を見つめてみよう';

  @override
  String get appBlockInterventionGiveUp => 'やめておく';

  @override
  String get appBlockInterventionOpenAnyway => 'それでも開く';

  @override
  String get appBlockStrictModeActive => '厳格モード中 — 開けません';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return '今週$appに$hours時間使いました';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return '今月$count回やめておきました';
  }

  @override
  String get pickAppToBan => '禁止するアプリを選ぶ';

  @override
  String get pickAppToBanDesc => '対戦相手は24時間このアプリを開けません';

  @override
  String get pickCategory => 'カテゴリを選ぶ';

  @override
  String get pickCategoryDesc => 'このカテゴリの使用時間のみがカウントされます';

  @override
  String get rollDiceForTarget => '目標のためにサイコロを振ろう';

  @override
  String get rollDiceDesc => 'サイコロの目 × 30分 = 目標時間';

  @override
  String get diceTapToRoll => 'タップして振る';

  @override
  String get diceRolling => '振っています...';

  @override
  String diceResult(int value) {
    return '結果: $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return '目標時間: $minutes分';
  }

  @override
  String get chooseTeammates => 'チームメイトを選ぶ';

  @override
  String teammatesSelected(int count) {
    return '$count/3 選択中  ·  2〜3人のチームメイトを選んでください';
  }

  @override
  String get nightDuelInfo => 'ナイトデュエル';

  @override
  String get nightDuelRange => '23:00 — 07:00';

  @override
  String get nightDuelBody => 'スマホを触らずに眠ろう。長く耐えた方が勝ち。固定8時間。';

  @override
  String get nightDuelAutoStart => 'このデュエルは23:00に自動的に開始します。';

  @override
  String get mysteryMissionTitle => 'ミステリーミッション';

  @override
  String get mysteryMissionSubtitle => 'ミッションはデュエル開始時に明かされます';

  @override
  String get mysteryMissionBody => 'デュエルを開始すると、ランダムなミッションが選ばれます。';

  @override
  String get mysteryStart => 'ミッション開始';

  @override
  String opponentWantsToBanApp(String app) {
    return '対戦相手はあなたに$appを禁止してほしいそうです';
  }

  @override
  String opponentWantsCategory(String category) {
    return '対戦相手は$categoryカテゴリで競いたいそうです';
  }

  @override
  String get proposeDifferentApp => 'そのアプリは持っていません、別のを提案して';

  @override
  String get proposeDifferentCategory => 'そのカテゴリは使っていません、別のを提案して';

  @override
  String get acceptInvite => '承認';

  @override
  String proposalSent(String value) {
    return '提案を送信しました: $value';
  }

  @override
  String get stepAppPicker => 'アプリを選ぶ';

  @override
  String get stepCategoryPicker => 'カテゴリを選ぶ';

  @override
  String get stepDice => 'サイコロを振る';

  @override
  String get stepNightInfo => 'ナイトデュエル';

  @override
  String get stepMystery => 'ミステリーミッション';

  @override
  String get stepTeamPicker => 'チームメイトを選ぶ';
}
