// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan => '断网。开玩。别迷失在数字世界里。';

  @override
  String get home => '首页';

  @override
  String get ranking => '排名';

  @override
  String get duel => '对决';

  @override
  String get profile => '个人资料';

  @override
  String get settings => '设置';

  @override
  String get stories => '动态';

  @override
  String get today => '今天';

  @override
  String get thisWeek => '本周';

  @override
  String get friends => '好友';

  @override
  String get friendsOf => '的好友';

  @override
  String get allFriends => '全部';

  @override
  String get city => '城市';

  @override
  String get country => '国家';

  @override
  String get global => '全球';

  @override
  String minutes(int count) {
    return '$count分钟';
  }

  @override
  String hours(int count) {
    return '$count小时';
  }

  @override
  String hoursMinutes(int h, int m) {
    return '$h小时$m分钟';
  }

  @override
  String get screenTime => '屏幕时间';

  @override
  String get phonePickups => '拿起手机次数';

  @override
  String pickupsToday(int count) {
    return '今天拿起了$count次';
  }

  @override
  String get topTriggers => '最常触发的应用';

  @override
  String get longestOffScreen => '最长离线时间';

  @override
  String get dailyGoal => '每日目标';

  @override
  String goalHours(int count) {
    return '目标：$count小时';
  }

  @override
  String get streak => '连续记录';

  @override
  String streakDays(int count) {
    return '$count天';
  }

  @override
  String get level => '等级';

  @override
  String get badges => '徽章';

  @override
  String get duels => '对决';

  @override
  String get activeDuels => '进行中';

  @override
  String get pastDuels => '历史';

  @override
  String get createDuel => '创建对决';

  @override
  String get startDuel => '开始对决';

  @override
  String get invite => '邀请';

  @override
  String get accept => '接受';

  @override
  String get decline => '拒绝';

  @override
  String get win => '胜利';

  @override
  String get lose => '失败';

  @override
  String get draw => '平局';

  @override
  String get addFriend => '添加好友';

  @override
  String get friendCode => '好友码';

  @override
  String get search => '搜索';

  @override
  String get notifications => '通知';

  @override
  String get dailyReminder => '每日提醒';

  @override
  String get duelNotifications => '对决通知';

  @override
  String get locationSharing => '位置共享';

  @override
  String get subscription => '订阅';

  @override
  String get free => '免费';

  @override
  String get pro => '专业版';

  @override
  String get proPlus => '专业版+';

  @override
  String get currentPlan => '当前方案';

  @override
  String get recommended => '推荐';

  @override
  String get start => '开始';

  @override
  String get upgradeToPro => '升级到专业版';

  @override
  String get upgradeToProPlus => '升级到专业版+';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String monthlyPrice(String price) {
    return '$price/月';
  }

  @override
  String get freeFeature1 => '每日屏幕时间追踪';

  @override
  String get freeFeature2 => '好友排名';

  @override
  String get freeFeature3 => '3场活跃对决';

  @override
  String get freeFeature4 => '基础徽章';

  @override
  String get proFeature1 => '全部排名（城市、国家、全球）';

  @override
  String get proFeature2 => '详细统计和专注日历';

  @override
  String get proFeature3 => '无限对决';

  @override
  String get proFeature4 => '含Off-Grid通行证';

  @override
  String get proFeature5 => '无广告体验';

  @override
  String get proPlusFeature1 => '专业版全部内容';

  @override
  String get proPlusFeature2 => '家庭计划（5人）';

  @override
  String get proPlusFeature3 => '优先支持';

  @override
  String get proPlusFeature4 => '专属徽章和主题';

  @override
  String get proPlusFeature5 => '抢先体验测试版功能';

  @override
  String get paywallTitle => 'Off-Grid 俱乐部';

  @override
  String get paywallSubtitle => '远离屏幕，收获奖励。';

  @override
  String get logout => '退出登录';

  @override
  String get shareProfile => '分享个人资料';

  @override
  String get shareReportCard => '晒出我的成绩';

  @override
  String get appUsage => '应用使用情况';

  @override
  String get whatDidYouUse => '今天你用了什么？';

  @override
  String get weeklyReport => '每周报告';

  @override
  String get weeklyTrend => '7天趋势';

  @override
  String get seasons => '赛季';

  @override
  String get seasonPass => 'Off-Grid 通行证';

  @override
  String get groups => '群组';

  @override
  String get createGroup => '创建群组';

  @override
  String get stats => '统计';

  @override
  String get analytics => '分析';

  @override
  String get detailedAnalytics => '详细分析';

  @override
  String get categories => '分类';

  @override
  String get weeklyUsage => '每周使用情况';

  @override
  String get appDetails => '应用详情';

  @override
  String get focusCalendar => '专注日历';

  @override
  String get whatIf => '如果…？';

  @override
  String get focusMode => '呼吸';

  @override
  String get startFocusMode => '开始专注模式';

  @override
  String get focusing => '专注中...';

  @override
  String focusComplete(int minutes) {
    return '太棒了！专注了$minutes分钟';
  }

  @override
  String get focusTimeout => '会话超时';

  @override
  String get focusTimeoutDesc => '已达到120分钟上限。\n还在吗？';

  @override
  String get end => '结束';

  @override
  String get reportCard => '成绩单';

  @override
  String get antiSocialStory => '反社交时刻';

  @override
  String get storyQuestion => '你离开手机在做什么？';

  @override
  String get postStory => '发布';

  @override
  String get storyExpired => '已过期';

  @override
  String get noStories => '暂无动态';

  @override
  String get noStoriesHint => '让你的好友开始分享他们的离线时刻吧！';

  @override
  String get storyBlocked => '无法分享动态';

  @override
  String get storyBlockedHint => '你已超出每日屏幕时间目标。坚守目标，赢得分享动态的权利！';

  @override
  String get duration => '时长';

  @override
  String get walk => '散步';

  @override
  String get run => '跑步';

  @override
  String get book => '读书';

  @override
  String get meditation => '冥想';

  @override
  String get nature => '大自然';

  @override
  String get sports => '运动';

  @override
  String get music => '音乐';

  @override
  String get cooking => '烹饪';

  @override
  String get friendsActivity => '好友';

  @override
  String get family => '家人';

  @override
  String get o2Balance => 'O₂积分';

  @override
  String o2Remaining(int count) {
    return '剩余：$count';
  }

  @override
  String o2Today(int earned, int max) {
    return '今天：$earned/$max O₂';
  }

  @override
  String get o2Rules => 'O₂规则';

  @override
  String get o2RuleTime => '仅在08:00至00:00之间获得';

  @override
  String get o2RuleDaily => '每天最多500 O₂';

  @override
  String get o2RuleFocus => '专注模式最多120分钟';

  @override
  String get o2RuleTransfer => '禁止转让和下注';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂（预估）';
  }

  @override
  String get offGridMarket => '战利品';

  @override
  String get offGridMarketHint => '将O₂积分兑换成真实奖励';

  @override
  String get redeem => '兑换';

  @override
  String get insufficient => '积分不足';

  @override
  String get redeemSuccess => '恭喜！';

  @override
  String get couponCode => '你的优惠码：';

  @override
  String get recentTransactions => '最近交易';

  @override
  String get noTransactions => '暂无交易记录';

  @override
  String get categorySocial => '社交';

  @override
  String get categoryGame => '游戏';

  @override
  String get categoryVideo => '视频';

  @override
  String get categoryAudio => '音乐';

  @override
  String get categoryProductivity => '效率';

  @override
  String get categoryNews => '新闻';

  @override
  String get categoryGames => '游戏';

  @override
  String get categoryShopping => '购物';

  @override
  String get categoryBrowser => '浏览器';

  @override
  String get categoryMaps => '地图';

  @override
  String get categoryImage => '照片';

  @override
  String get categoryOther => '其他';

  @override
  String hello(String name) {
    return '你好，$name';
  }

  @override
  String get goalCompleted => '目标完成！';

  @override
  String get dailyGoalShort => '每日目标';

  @override
  String get streakDaysLabel => '天连续';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => '排名';

  @override
  String get offlineLabel => '离线';

  @override
  String get todaysApps => '今日应用';

  @override
  String get seeAll => '查看全部';

  @override
  String get activeDuel => '进行中的对决';

  @override
  String get startDuelPrompt => '开始一场对决！';

  @override
  String get you => '你';

  @override
  String moreCount(int count) {
    return '+$count个';
  }

  @override
  String get removeWithPro => '专业版去除';

  @override
  String get adLabel => '广告';

  @override
  String get focus => '专注';

  @override
  String get legal => '法律信息';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get termsOfService => '服务条款';

  @override
  String get kvkkText => '个人信息保护声明';

  @override
  String get deleteMyAccount => '删除我的账户';

  @override
  String get edit => '编辑';

  @override
  String get adminAddLoot => '管理员：添加战利品';

  @override
  String get continueConsent => '继续即代表你';

  @override
  String get acceptTermsSuffix => '同意。';

  @override
  String get alreadyHaveAccount => '我已有账户';

  @override
  String get screenTimePermissionTitle => '我们需要追踪你的屏幕时间';

  @override
  String get screenTimePermissionDesc => '需要屏幕时间访问权限才能查看你在每个应用上花费的时间。';

  @override
  String get screenTimeGranted => '屏幕时间权限已授予！';

  @override
  String get continueButton => '继续';

  @override
  String get skip => '跳过';

  @override
  String get yourName => '你的名字';

  @override
  String get nameHint => '输入你的名字';

  @override
  String get ageGroup => '年龄段';

  @override
  String get imReady => '我准备好了';

  @override
  String get dailyGoalTitle => '你的每日目标';

  @override
  String get goalQuestion => '你每天的屏幕时间目标是多少小时？';

  @override
  String get goalMotivational1 => '太棒了！真正的数字排毒目标 💪';

  @override
  String get goalMotivational2 => '均衡的目标，你能做到！ 🎯';

  @override
  String get goalMotivational3 => '良好的开始，可以逐步减少 📉';

  @override
  String get goalMotivational4 => '一步一步来，每分钟都有意义 ⭐';

  @override
  String get next => '下一步';

  @override
  String hourShort(int count) {
    return '$count小时';
  }

  @override
  String get welcomeSlogan => '放下手机。超越好友。\n成为城市第一。';

  @override
  String get deleteAccount => '删除账户';

  @override
  String get deleteAccountConfirm => '您的账户和所有数据将被永久删除。此操作无法撤销。';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get ok => '好的';

  @override
  String get error => '错误';

  @override
  String get tryAgain => '重试';

  @override
  String get loading => '加载中...';

  @override
  String get loadFailed => '加载失败';

  @override
  String get noDataYet => '暂无数据';

  @override
  String get welcome => '欢迎';

  @override
  String get welcomeSubtitle => '放下手机，超越好友。';

  @override
  String get continueWithGoogle => '使用 Google 继续';

  @override
  String get continueWithApple => '使用 Apple 继续';

  @override
  String get continueWithEmail => '使用邮箱继续';

  @override
  String get permissionsTitle => '权限';

  @override
  String get permissionsSubtitle => '我们需要权限来跟踪您的屏幕时间。';

  @override
  String get grantPermission => '授予权限';

  @override
  String get setupProfile => '设置个人资料';

  @override
  String get displayName => '显示名称';

  @override
  String get selectCity => '选择城市';

  @override
  String get selectGoal => '选择每日目标';

  @override
  String get noDuelsYet => '暂无对决';

  @override
  String get noDuelsYetSubtitle => '开始你的第一场对决！';

  @override
  String get activeDuelsTitle => '进行中的对决';

  @override
  String get newDuel => '新对决';

  @override
  String get selectDuelType => '选择对决类型';

  @override
  String get selectDurationStep => '选择时长';

  @override
  String get selectOpponent => '选择对手';

  @override
  String get duelStartButton => '开始对决！ ⚔️';

  @override
  String get freePlanDuelLimit => '免费版最多3场活跃对决！升级到专业版。';

  @override
  String get quickSelect => '快速选择';

  @override
  String get customDuration => '自定义时长';

  @override
  String selectedDuration(String duration) {
    return '已选：$duration';
  }

  @override
  String get minDurationWarning => '至少需要选择10分钟';

  @override
  String get selectPenalty => '选择惩罚（可选）';

  @override
  String get searchFriend => '搜索好友...';

  @override
  String get inviteWithLink => '链接邀请 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '今日$count分钟';
  }

  @override
  String duelRemaining(int h, int m) {
    return '剩余$h小时$m分钟';
  }

  @override
  String get remainingTime => '剩余时间';

  @override
  String watchersCount(int count) {
    return '$count人正在观看 👀';
  }

  @override
  String get giveUp => '放弃';

  @override
  String get duelWon => '你赢了！ 🎉';

  @override
  String get duelLost => '你输了 😔';

  @override
  String get greatPerformance => '表现出色！';

  @override
  String get betterNextTime => '下次会更好！';

  @override
  String get revenge => '复仇 🔥';

  @override
  String get share => '分享';

  @override
  String get selectFriend => '选择好友';

  @override
  String get orSendLink => '或发送链接';

  @override
  String get social => '社交';

  @override
  String get myFriends => '我的好友';

  @override
  String get inMyCity => '我的城市';

  @override
  String get shareFirstStory => '第一个分享你的离线时刻！';

  @override
  String get createStoryTitle => '分享动态';

  @override
  String get addPhoto => '添加照片';

  @override
  String get whatAreYouDoing => '你在做什么？';

  @override
  String get captionHint => '你离开手机在做什么？';

  @override
  String get howLongVisible => '显示多长时间？';

  @override
  String get whoCanSee => '谁能看到？';

  @override
  String get onlyFriends => '仅好友';

  @override
  String get cityPeople => '我城市的人';

  @override
  String get photoStoriesPro => '照片动态是专业版功能！设置 > Off-Grid 俱乐部';

  @override
  String get camera => '相机';

  @override
  String get gallery => '相册';

  @override
  String get writeFirst => '请先写点什么！';

  @override
  String get inappropriateContent => '检测到不当内容';

  @override
  String viewsCount(int count) {
    return '$count次查看';
  }

  @override
  String get editProfile => '编辑个人资料';

  @override
  String get changePhoto => '更换照片';

  @override
  String get firstName => '名字';

  @override
  String get firstNameHint => '你的名字';

  @override
  String get lastName => '姓氏';

  @override
  String get lastNameHint => '你的姓氏';

  @override
  String get usernameLabel => '用户名';

  @override
  String get updateLocation => '更新位置';

  @override
  String get locationUnknown => '未知';

  @override
  String get save => '保存';

  @override
  String get usernameAvailable => '可用';

  @override
  String get usernameTaken => '该用户名已被使用';

  @override
  String get usernameFormatError => '至少3个字符，只能使用字母、数字和_';

  @override
  String get profileUpdated => '个人资料已更新';

  @override
  String get photoSelectedDemo => '照片已选择（演示模式下不会上传）';

  @override
  String get locationError => '无法获取位置';

  @override
  String get errorOccurred => '发生错误';

  @override
  String get detailedScreenTime => '详细屏幕时间';

  @override
  String get monthlyTop10 => '月度 TOP 10';

  @override
  String get searchHint => '搜索...';

  @override
  String get noFriendsYet => '暂无好友';

  @override
  String get noFriendsHint => '先添加一个好友吧';

  @override
  String get showQrCode => '展示你的二维码';

  @override
  String get enterCode => '输入代码';

  @override
  String get inviteLinkShare => '分享邀请链接';

  @override
  String get startDuelAction => '开始对决';

  @override
  String get pointsLabel => '积分';

  @override
  String get mostUsedLabel => '使用最多：';

  @override
  String get recentBadges => '最近徽章';

  @override
  String get allBadgesLabel => '全部徽章';

  @override
  String get removeFriend => '删除好友';

  @override
  String get removeFriendConfirm => '确定要将此人从好友列表中删除吗？';

  @override
  String get remove => '删除';

  @override
  String get requestSent => '请求已发送';

  @override
  String get whatCouldYouDo => '你本可以做什么？';

  @override
  String get back => '返回';

  @override
  String get weekly => '每周';

  @override
  String get daily => '每日';

  @override
  String get mostUsedApps => '使用最多的应用';

  @override
  String get unlockSection => '解锁次数';

  @override
  String get selectedDayLabel => '所选日期';

  @override
  String get todayLabel => '今天';

  @override
  String weeklyAvgLabel(int h, int m) {
    return '日均：$h小时$m分钟';
  }

  @override
  String get firstUnlock => '首次解锁';

  @override
  String get mostOpened => '打开最多';

  @override
  String get timesPickedUp => '拿起次数';

  @override
  String get openingCount => '次打开';

  @override
  String get notificationUnit => '条通知';

  @override
  String get timesUnit => '次';

  @override
  String get turkey => '土耳其';

  @override
  String get consecutiveDays => '天连续';

  @override
  String bestStreakLabel(int days) {
    return '最佳：$days天';
  }

  @override
  String get seriFriends => '好友';

  @override
  String get oxygenTitle => '氧气 (O₂)';

  @override
  String get totalO2 => '总计';

  @override
  String get remainingShort => '剩余';

  @override
  String get noOffersYet => '暂无优惠';

  @override
  String o2SpentMsg(int amount) {
    return '已花费$amount O₂';
  }

  @override
  String get mapLoadFailed => '地图加载失败';

  @override
  String confirmRedeemMsg(String reward) {
    return '你想兑换$reward吗？';
  }

  @override
  String itemReceived(String item) {
    return '$item已兑换！';
  }

  @override
  String get insufficientO2 => 'O₂积分不足';

  @override
  String get season1Title => '第1赛季';

  @override
  String get season1Subtitle => '春日觉醒';

  @override
  String get seasonPassBtn => '赛季通行证 (99TL)';

  @override
  String get seasonPassLabel => '赛季通行证';

  @override
  String get noGroupsYet => '暂无群组';

  @override
  String get noGroupsSubtitle => '和好友创建一个群组';

  @override
  String get newGroup => '新群组';

  @override
  String memberCount(int count) {
    return '$count位成员';
  }

  @override
  String get weeklyGoal => '每周目标';

  @override
  String challengeProgress(int percent) {
    return '已完成$percent%';
  }

  @override
  String get membersLabel => '成员';

  @override
  String get inviteLink => '邀请链接';

  @override
  String get linkCopied => '链接已复制！';

  @override
  String get copy => '复制';

  @override
  String get qrCode => '二维码';

  @override
  String get groupNameLabel => '群组名称';

  @override
  String get groupNameHint => '输入群组名称';

  @override
  String get groupNameEmpty => '群组名称不能为空';

  @override
  String dailyGoalHours(int hours) {
    return '每日目标：$hours小时';
  }

  @override
  String get addMember => '添加成员';

  @override
  String selectedCount(int count) {
    return '已选$count个';
  }

  @override
  String get create => '创建';

  @override
  String groupCreated(String name) {
    return '$name已创建！';
  }

  @override
  String invitedCount(int count) {
    return '已邀请$count人';
  }

  @override
  String get screenTimeLower => '屏幕时间';

  @override
  String get improvedFromLastWeek => '比上周改善12%';

  @override
  String get o2Earned => '获得O₂';

  @override
  String get friendRank => '好友排名';

  @override
  String cityRankLabel(String city) {
    return '$city排名';
  }

  @override
  String get mostUsed => '使用最多';

  @override
  String get offGridClub => 'Off-Grid 俱乐部';

  @override
  String get clubSubtitle => '实现数字平衡，获得奖励。';

  @override
  String get planStarter => '入门版';

  @override
  String get planStarterSubtitle => '从基础开始';

  @override
  String get currentPlanBtn => '当前方案';

  @override
  String get billingMonthly => '按月';

  @override
  String get billingYearly => '按年';

  @override
  String get yearlySavings => '节省33%';

  @override
  String get planComparison => '方案对比';

  @override
  String get breathTechniquesComp => '呼吸技巧';

  @override
  String get activeDuelsComp => '活跃对决';

  @override
  String get storyPhoto => '动态照片';

  @override
  String get heatMap => '热力图';

  @override
  String get top10Report => 'TOP 10报告';

  @override
  String get exclusiveBadges => '专属徽章';

  @override
  String get adFree => '无广告';

  @override
  String get familyPlanComp => '家庭计划';

  @override
  String get familyReport => '家庭报告';

  @override
  String get exclusiveThemes => '专属主题';

  @override
  String get prioritySupport => '优先支持';

  @override
  String get billingNote => '订阅可随时取消。\n通过 App Store/Google Play 付款。\n订阅到期自动续订。';

  @override
  String get restoreSuccess => '购买已恢复！';

  @override
  String get restoreFailed => '未找到可恢复的购买记录。';

  @override
  String get packagesLoadFailed => '加载套餐失败，请重试。';

  @override
  String get themesTitle => '主题';

  @override
  String get themeLockedMsg => '此主题是专业版+专属！设置 > Off-Grid 俱乐部';

  @override
  String get familyPlanTitle => '家庭计划';

  @override
  String get familyPlanLocked => '一起数字平衡';

  @override
  String get familyPlanLockedDesc => '最多添加5位家庭成员，共同设定目标，获取每周家庭报告。';

  @override
  String get weeklyFamilyReport => '每周家庭报告';

  @override
  String get familyRanking => '家庭排名';

  @override
  String get totalOffline => '总离线时间';

  @override
  String get average => '平均';

  @override
  String get best => '最佳';

  @override
  String offlineTime(int h, int m) {
    return '$h小时$m分钟离线';
  }

  @override
  String get enterName => '输入名字';

  @override
  String get cannotUndo => '此操作无法撤销！';

  @override
  String get deleteWarningDesc => '删除账户后，以下数据将被永久删除：';

  @override
  String get deleteItem1 => '个人资料信息和头像';

  @override
  String get deleteItem2 => '所有屏幕时间统计';

  @override
  String get deleteItem3 => '好友列表和对决';

  @override
  String get deleteItem4 => '动态和评论';

  @override
  String get deleteItem5 => 'O₂积分和战利品';

  @override
  String get deleteItem6 => '订阅记录';

  @override
  String get deleteSubscriptionNote =>
      '如有有效订阅，请先通过 Apple App Store 或 Google Play Store 取消。';

  @override
  String get deleteConfirmCheck => '我了解我的账户和所有数据将被永久删除。';

  @override
  String get deleteAccountBtn => '永久删除我的账户';

  @override
  String get deleteErrorMsg => '发生错误，请重试。';

  @override
  String get emailHint => '邮箱';

  @override
  String get passwordHint => '密码';

  @override
  String get forgotPassword => '忘记密码';

  @override
  String get passwordResetSent => '密码重置邮件已发送。';

  @override
  String get signUp => '注册';

  @override
  String get signIn => '登录';

  @override
  String get orDivider => '或';

  @override
  String get continueWithGoogleShort => '使用 Google 继续';

  @override
  String get continueWithAppleShort => '使用 Apple 继续';

  @override
  String get noAccountYet => '还没有账户？ ';

  @override
  String get adminExistingPoints => '现有积分';

  @override
  String get adminSearchPlace => '搜索地点...';

  @override
  String get adminRewardTitle => '奖励标题（例如：免费咖啡）';

  @override
  String get adminO2Cost => 'O₂花费';

  @override
  String get adminSave => '保存';

  @override
  String get adminSaved => '已保存！';

  @override
  String get adminDeleteTitle => '删除';

  @override
  String get adminDeleteMsg => '确定要删除这个点吗？';

  @override
  String adminDeleteError(String error) {
    return '删除错误：$error';
  }

  @override
  String get adminFillFields => '请填写奖励和O₂花费';

  @override
  String breathCount(int count) {
    return '$count次呼吸';
  }

  @override
  String minutesRemaining(int count) {
    return '剩余$count分钟';
  }

  @override
  String focusMinutes(int count) {
    return '你专注了$count分钟';
  }

  @override
  String get o2TimeRestriction => 'O₂仅在08:00至00:00之间获得';

  @override
  String get breathTechniqueProMsg => '此技巧是专业版专属！设置 > Off-Grid 俱乐部';

  @override
  String get inhale => '吸气';

  @override
  String get holdBreath => '屏息';

  @override
  String get exhale => '呼气';

  @override
  String get waitBreath => '等待';

  @override
  String get proMostPopular => '最受欢迎';

  @override
  String get proFamilyBadge => '家庭';

  @override
  String get comparedToLastWeek => '与上周相比';

  @override
  String get appBlockTitle => '应用拦截';

  @override
  String get appBlockSchedule => '时间表';

  @override
  String get appBlockEnableBlocking => '启用拦截';

  @override
  String get appBlockActive => '拦截已开启';

  @override
  String get appBlockInactive => '拦截已关闭';

  @override
  String get appBlockStrictMode => '严格模式';

  @override
  String get appBlockStrictDesc => '计时器结束前无法关闭';

  @override
  String get appBlockStrictExpired => '计时器已到期';

  @override
  String get appBlockStrictDurationTitle => '严格模式时长';

  @override
  String get appBlockDuration30m => '30分钟';

  @override
  String get appBlockDuration1h => '1小时';

  @override
  String get appBlockDuration2h => '2小时';

  @override
  String get appBlockDuration4h => '4小时';

  @override
  String get appBlockDurationAllDay => '全天（24小时）';

  @override
  String get appBlockScheduleTitle => '拦截时间表';

  @override
  String get appBlockScheduleDesc => '设置每日时间段';

  @override
  String get appBlockBlockedApps => '已拦截的应用';

  @override
  String get appBlockNoApps => '尚未添加任何应用';

  @override
  String get appBlockAddApp => '添加应用';

  @override
  String get appBlockPickerTitle => '选择应用';

  @override
  String get appBlockPresetWork => '工作时间（09-18）';

  @override
  String get appBlockPresetSleep => '睡眠时间（23-07）';

  @override
  String get appBlockPresetAllDay => '全天';

  @override
  String get appBlockInterventionTitle => '等一下...';

  @override
  String get appBlockInterventionSubtitle => '深呼吸，观察一下自己';

  @override
  String get appBlockInterventionGiveUp => '算了';

  @override
  String get appBlockInterventionOpenAnyway => '仍然打开';

  @override
  String get appBlockStrictModeActive => '严格模式 — 无法打开';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return '本周你在$app上花了$hours小时';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return '本月你放弃了$count次';
  }

  @override
  String get pickAppToBan => '选择要禁用的应用';

  @override
  String get pickAppToBanDesc => '你的对手将在24小时内无法打开此应用';

  @override
  String get pickCategory => '选择类别';

  @override
  String get pickCategoryDesc => '只计算此类别的使用时间';

  @override
  String get rollDiceForTarget => '掷骰子确定你的目标';

  @override
  String get rollDiceDesc => '骰子点数 × 30分钟 = 目标时长';

  @override
  String get diceTapToRoll => '点击掷骰';

  @override
  String get diceRolling => '掷骰中...';

  @override
  String diceResult(int value) {
    return '结果:$value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return '目标时长:$minutes分钟';
  }

  @override
  String get chooseTeammates => '选择队友';

  @override
  String teammatesSelected(int count) {
    return '已选$count/3  ·  请选择2或3名队友';
  }

  @override
  String get nightDuelInfo => '夜间决斗';

  @override
  String get nightDuelRange => '23:00 — 07:00';

  @override
  String get nightDuelBody => '不碰手机入睡。坚持更久者获胜。固定8小时。';

  @override
  String get nightDuelAutoStart => '此决斗将在23:00自动开始。';

  @override
  String get mysteryMissionTitle => '神秘任务';

  @override
  String get mysteryMissionSubtitle => '任务将在决斗开始时揭晓';

  @override
  String get mysteryMissionBody => '开始决斗时,将随机选择一个任务。';

  @override
  String get mysteryStart => '开始任务';

  @override
  String opponentWantsToBanApp(String app) {
    return '你的对手希望你禁用 $app';
  }

  @override
  String opponentWantsCategory(String category) {
    return '你的对手想在 $category 类别中比赛';
  }

  @override
  String get proposeDifferentApp => '我没有那个应用,建议其他的';

  @override
  String get proposeDifferentCategory => '我不使用那个类别,建议其他的';

  @override
  String get acceptInvite => '接受';

  @override
  String proposalSent(String value) {
    return '提议已发送:$value';
  }

  @override
  String get stepAppPicker => '选择应用';

  @override
  String get stepCategoryPicker => '选择类别';

  @override
  String get stepDice => '掷骰子';

  @override
  String get stepNightInfo => '夜间决斗';

  @override
  String get stepMystery => '神秘任务';

  @override
  String get stepTeamPicker => '选择队友';
}
