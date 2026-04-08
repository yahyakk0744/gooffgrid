// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan => '플러그를 뽑아라. 게임을 시작해. 디지털에 빠지지 마.';

  @override
  String get home => '홈';

  @override
  String get ranking => '랭킹';

  @override
  String get duel => '대결';

  @override
  String get profile => '프로필';

  @override
  String get settings => '설정';

  @override
  String get stories => '스토리';

  @override
  String get today => '오늘';

  @override
  String get thisWeek => '이번 주';

  @override
  String get friends => '친구';

  @override
  String get friendsOf => '의 친구';

  @override
  String get allFriends => '전체';

  @override
  String get city => '도시';

  @override
  String get country => '국가';

  @override
  String get global => '글로벌';

  @override
  String minutes(int count) {
    return '$count분';
  }

  @override
  String hours(int count) {
    return '$count시간';
  }

  @override
  String hoursMinutes(int h, int m) {
    return '$h시간 $m분';
  }

  @override
  String get screenTime => '스크린 타임';

  @override
  String get phonePickups => '폰을 집어든 횟수';

  @override
  String pickupsToday(int count) {
    return '오늘 $count번 집어들었어요';
  }

  @override
  String get topTriggers => '주요 유발 앱';

  @override
  String get longestOffScreen => '최장 오프라인 시간';

  @override
  String get dailyGoal => '일일 목표';

  @override
  String goalHours(int count) {
    return '목표: $count시간';
  }

  @override
  String get streak => '연속 기록';

  @override
  String streakDays(int count) {
    return '$count일';
  }

  @override
  String get level => '레벨';

  @override
  String get badges => '배지';

  @override
  String get duels => '대결';

  @override
  String get activeDuels => '진행 중';

  @override
  String get pastDuels => '과거';

  @override
  String get createDuel => '대결 만들기';

  @override
  String get startDuel => '대결 시작';

  @override
  String get invite => '초대';

  @override
  String get accept => '수락';

  @override
  String get decline => '거절';

  @override
  String get win => '승리';

  @override
  String get lose => '패배';

  @override
  String get draw => '무승부';

  @override
  String get addFriend => '친구 추가';

  @override
  String get friendCode => '친구 코드';

  @override
  String get search => '검색';

  @override
  String get notifications => '알림';

  @override
  String get dailyReminder => '일일 알림';

  @override
  String get duelNotifications => '대결 알림';

  @override
  String get locationSharing => '위치 공유';

  @override
  String get subscription => '구독';

  @override
  String get free => '무료';

  @override
  String get pro => '프로';

  @override
  String get proPlus => '프로+';

  @override
  String get currentPlan => '현재 플랜';

  @override
  String get recommended => '추천';

  @override
  String get start => '시작';

  @override
  String get upgradeToPro => '프로로 업그레이드';

  @override
  String get upgradeToProPlus => '프로+로 업그레이드';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String monthlyPrice(String price) {
    return '$price/월';
  }

  @override
  String get freeFeature1 => '매일 스크린 타임 추적';

  @override
  String get freeFeature2 => '친구 랭킹';

  @override
  String get freeFeature3 => '활성 대결 3개';

  @override
  String get freeFeature4 => '기본 배지';

  @override
  String get proFeature1 => '모든 랭킹 (도시, 국가, 글로벌)';

  @override
  String get proFeature2 => '상세 통계 및 집중 캘린더';

  @override
  String get proFeature3 => '무제한 대결';

  @override
  String get proFeature4 => 'Off-Grid 패스 포함';

  @override
  String get proFeature5 => '광고 없는 경험';

  @override
  String get proPlusFeature1 => '프로의 모든 기능';

  @override
  String get proPlusFeature2 => '가족 플랜 (5명)';

  @override
  String get proPlusFeature3 => '우선 지원';

  @override
  String get proPlusFeature4 => '전용 배지 및 테마';

  @override
  String get proPlusFeature5 => '베타 기능 조기 이용';

  @override
  String get paywallTitle => 'Off-Grid 클럽';

  @override
  String get paywallSubtitle => '화면에서 멀어질수록 보상받아요.';

  @override
  String get logout => '로그아웃';

  @override
  String get shareProfile => '프로필 공유';

  @override
  String get shareReportCard => '내 기록 자랑하기';

  @override
  String get appUsage => '앱 사용량';

  @override
  String get whatDidYouUse => '오늘 뭘 사용했나요?';

  @override
  String get weeklyReport => '주간 리포트';

  @override
  String get weeklyTrend => '7일 트렌드';

  @override
  String get seasons => '시즌';

  @override
  String get seasonPass => 'Off-Grid 패스';

  @override
  String get groups => '그룹';

  @override
  String get createGroup => '그룹 만들기';

  @override
  String get stats => '통계';

  @override
  String get analytics => '애널리틱스';

  @override
  String get detailedAnalytics => '상세 애널리틱스';

  @override
  String get categories => '카테고리';

  @override
  String get weeklyUsage => '주간 사용량';

  @override
  String get appDetails => '앱 상세';

  @override
  String get focusCalendar => '집중 캘린더';

  @override
  String get whatIf => '만약에?';

  @override
  String get focusMode => '호흡';

  @override
  String get startFocusMode => '집중 모드 시작';

  @override
  String get focusing => '집중 중...';

  @override
  String focusComplete(int minutes) {
    return '훌륭해요! $minutes분 집중했어요';
  }

  @override
  String get focusTimeout => '세션 시간 초과';

  @override
  String get focusTimeoutDesc => '120분 제한에 도달했습니다.\n아직 거기 있나요?';

  @override
  String get end => '종료';

  @override
  String get reportCard => '성적표';

  @override
  String get antiSocialStory => '반사회적 순간';

  @override
  String get storyQuestion => '폰 없이 뭐하고 있나요?';

  @override
  String get postStory => '게시';

  @override
  String get storyExpired => '만료됨';

  @override
  String get noStories => '아직 스토리가 없습니다';

  @override
  String get noStoriesHint => '친구들이 오프그리드 순간을 공유하기 시작하게 해보세요!';

  @override
  String get storyBlocked => '스토리를 공유할 수 없어요';

  @override
  String get storyBlockedHint => '오늘 스크린 타임 목표를 초과했어요. 목표를 지켜 스토리 공유 권한을 얻으세요!';

  @override
  String get duration => '시간';

  @override
  String get walk => '걷기';

  @override
  String get run => '달리기';

  @override
  String get book => '독서';

  @override
  String get meditation => '명상';

  @override
  String get nature => '자연';

  @override
  String get sports => '스포츠';

  @override
  String get music => '음악';

  @override
  String get cooking => '요리';

  @override
  String get friendsActivity => '친구';

  @override
  String get family => '가족';

  @override
  String get o2Balance => 'O₂ 포인트';

  @override
  String o2Remaining(int count) {
    return '남은: $count';
  }

  @override
  String o2Today(int earned, int max) {
    return '오늘: $earned/$max O₂';
  }

  @override
  String get o2Rules => 'O₂ 규칙';

  @override
  String get o2RuleTime => '08:00~00:00 사이에만 획득 가능';

  @override
  String get o2RuleDaily => '하루 최대 500 O₂';

  @override
  String get o2RuleFocus => '집중 모드 최대 120분';

  @override
  String get o2RuleTransfer => '전송 및 베팅 금지';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂ (예상)';
  }

  @override
  String get offGridMarket => '전리품';

  @override
  String get offGridMarketHint => 'O₂ 포인트를 실제 보상으로 바꿔요';

  @override
  String get redeem => '교환';

  @override
  String get insufficient => '부족';

  @override
  String get redeemSuccess => '축하해요!';

  @override
  String get couponCode => '쿠폰 코드:';

  @override
  String get recentTransactions => '최근 거래';

  @override
  String get noTransactions => '아직 거래가 없습니다';

  @override
  String get categorySocial => '소셜';

  @override
  String get categoryGame => '게임';

  @override
  String get categoryVideo => '동영상';

  @override
  String get categoryAudio => '음악';

  @override
  String get categoryProductivity => '생산성';

  @override
  String get categoryNews => '뉴스';

  @override
  String get categoryGames => '게임';

  @override
  String get categoryShopping => '쇼핑';

  @override
  String get categoryBrowser => '브라우저';

  @override
  String get categoryMaps => '지도';

  @override
  String get categoryImage => '사진';

  @override
  String get categoryOther => '기타';

  @override
  String hello(String name) {
    return '안녕하세요, $name';
  }

  @override
  String get goalCompleted => '목표 달성!';

  @override
  String get dailyGoalShort => '일일 목표';

  @override
  String get streakDaysLabel => '일 연속';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => '랭크';

  @override
  String get offlineLabel => '오프라인';

  @override
  String get todaysApps => '오늘의 앱';

  @override
  String get seeAll => '전체 보기';

  @override
  String get activeDuel => '진행 중인 대결';

  @override
  String get startDuelPrompt => '대결을 시작하세요!';

  @override
  String get you => '나';

  @override
  String moreCount(int count) {
    return '+$count개 더';
  }

  @override
  String get removeWithPro => '프로로 제거';

  @override
  String get adLabel => '광고';

  @override
  String get focus => '집중';

  @override
  String get legal => '법적 정보';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get termsOfService => '이용약관';

  @override
  String get kvkkText => '개인정보 보호 안내';

  @override
  String get deleteMyAccount => '내 계정 삭제';

  @override
  String get edit => '편집';

  @override
  String get adminAddLoot => '관리자: 전리품 추가';

  @override
  String get continueConsent => '계속하면';

  @override
  String get acceptTermsSuffix => '동의합니다.';

  @override
  String get alreadyHaveAccount => '이미 계정이 있어요';

  @override
  String get screenTimePermissionTitle => '스크린 타임을 추적해야 해요';

  @override
  String get screenTimePermissionDesc =>
      '각 앱에서 얼마나 시간을 쓰는지 보려면 스크린 타임 접근이 필요해요.';

  @override
  String get screenTimeGranted => '스크린 타임 권한이 허용됐어요!';

  @override
  String get continueButton => '계속';

  @override
  String get skip => '건너뛰기';

  @override
  String get yourName => '이름';

  @override
  String get nameHint => '이름을 입력하세요';

  @override
  String get ageGroup => '연령대';

  @override
  String get imReady => '준비됐어요';

  @override
  String get dailyGoalTitle => '일일 목표';

  @override
  String get goalQuestion => '하루에 몇 시간의 스크린 타임을 목표로 하나요?';

  @override
  String get goalMotivational1 => '대단해요! 진짜 디지털 디톡스 목표 💪';

  @override
  String get goalMotivational2 => '균형 잡힌 목표, 할 수 있어요! 🎯';

  @override
  String get goalMotivational3 => '좋은 시작, 시간이 지나면 줄일 수 있어요 📉';

  @override
  String get goalMotivational4 => '한 걸음씩, 1분 1분이 소중해요 ⭐';

  @override
  String get next => '다음';

  @override
  String hourShort(int count) {
    return '$count시간';
  }

  @override
  String get welcomeSlogan => '폰을 내려놓으세요. 친구들을 이기세요.\n내 도시에서 #1이 되세요.';

  @override
  String get deleteAccount => '계정 삭제';

  @override
  String get deleteAccountConfirm =>
      '계정과 모든 데이터가 영구적으로 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get ok => '확인';

  @override
  String get error => '오류';

  @override
  String get tryAgain => '다시 시도';

  @override
  String get loading => '로딩 중...';

  @override
  String get loadFailed => '로드 실패';

  @override
  String get noDataYet => '아직 데이터가 없습니다';

  @override
  String get welcome => '환영합니다';

  @override
  String get welcomeSubtitle => '폰을 내려놓으세요. 친구들을 이기세요.';

  @override
  String get continueWithGoogle => 'Google로 계속하기';

  @override
  String get continueWithApple => 'Apple로 계속하기';

  @override
  String get continueWithEmail => '이메일로 계속하기';

  @override
  String get permissionsTitle => '권한';

  @override
  String get permissionsSubtitle => '스크린 타임을 추적하기 위해 권한이 필요합니다.';

  @override
  String get grantPermission => '권한 허용';

  @override
  String get setupProfile => '프로필 설정';

  @override
  String get displayName => '표시 이름';

  @override
  String get selectCity => '도시 선택';

  @override
  String get selectGoal => '일일 목표 선택';

  @override
  String get noDuelsYet => '아직 대결이 없어요';

  @override
  String get noDuelsYetSubtitle => '첫 번째 대결을 시작하세요!';

  @override
  String get activeDuelsTitle => '진행 중인 대결';

  @override
  String get newDuel => '새 대결';

  @override
  String get selectDuelType => '대결 유형 선택';

  @override
  String get selectDurationStep => '기간 선택';

  @override
  String get selectOpponent => '상대방 선택';

  @override
  String get duelStartButton => '대결 시작! ⚔️';

  @override
  String get freePlanDuelLimit => '무료 플랜은 최대 3개의 활성 대결만 가능해요! 프로로 업그레이드하세요.';

  @override
  String get quickSelect => '빠른 선택';

  @override
  String get customDuration => '직접 설정';

  @override
  String selectedDuration(String duration) {
    return '선택됨: $duration';
  }

  @override
  String get minDurationWarning => '최소 10분을 선택해야 해요';

  @override
  String get selectPenalty => '패널티 선택 (선택 사항)';

  @override
  String get searchFriend => '친구 검색...';

  @override
  String get inviteWithLink => '링크로 초대 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '오늘 $count분';
  }

  @override
  String duelRemaining(int h, int m) {
    return '$h시간 $m분 남음';
  }

  @override
  String get remainingTime => '남은 시간';

  @override
  String watchersCount(int count) {
    return '$count명 보는 중 👀';
  }

  @override
  String get giveUp => '포기';

  @override
  String get duelWon => '이겼어요! 🎉';

  @override
  String get duelLost => '졌어요 😔';

  @override
  String get greatPerformance => '훌륭한 성과예요!';

  @override
  String get betterNextTime => '다음엔 더 잘할 거예요!';

  @override
  String get revenge => '복수전 🔥';

  @override
  String get share => '공유';

  @override
  String get selectFriend => '친구 선택';

  @override
  String get orSendLink => '또는 링크 보내기';

  @override
  String get social => '소셜';

  @override
  String get myFriends => '내 친구';

  @override
  String get inMyCity => '내 도시에서';

  @override
  String get shareFirstStory => '첫 번째로 오프그리드 순간을 공유하세요!';

  @override
  String get createStoryTitle => '스토리 공유';

  @override
  String get addPhoto => '사진 추가';

  @override
  String get whatAreYouDoing => '뭐하고 있나요?';

  @override
  String get captionHint => '폰 없이 뭐하고 있나요?';

  @override
  String get howLongVisible => '얼마나 보여줄까요?';

  @override
  String get whoCanSee => '누가 볼 수 있나요?';

  @override
  String get onlyFriends => '내 친구만';

  @override
  String get cityPeople => '내 도시 사람들';

  @override
  String get photoStoriesPro => '사진 스토리는 프로 전용이에요! 설정 > Off-Grid 클럽';

  @override
  String get camera => '카메라';

  @override
  String get gallery => '갤러리';

  @override
  String get writeFirst => '먼저 무언가를 써주세요!';

  @override
  String get inappropriateContent => '부적절한 콘텐츠가 감지됐어요';

  @override
  String viewsCount(int count) {
    return '$count명이 봤어요';
  }

  @override
  String get editProfile => '프로필 편집';

  @override
  String get changePhoto => '사진 변경';

  @override
  String get firstName => '이름';

  @override
  String get firstNameHint => '이름';

  @override
  String get lastName => '성';

  @override
  String get lastNameHint => '성';

  @override
  String get usernameLabel => '사용자 이름';

  @override
  String get updateLocation => '위치 업데이트';

  @override
  String get locationUnknown => '알 수 없음';

  @override
  String get save => '저장';

  @override
  String get usernameAvailable => '사용 가능';

  @override
  String get usernameTaken => '이미 사용 중인 이름이에요';

  @override
  String get usernameFormatError => '3자 이상, 영문자, 숫자 및 _만 가능';

  @override
  String get profileUpdated => '프로필이 업데이트됐어요';

  @override
  String get photoSelectedDemo => '사진 선택됨 (데모 모드에서는 업로드 안 됨)';

  @override
  String get locationError => '위치를 가져올 수 없어요';

  @override
  String get errorOccurred => '오류가 발생했어요';

  @override
  String get detailedScreenTime => '상세 스크린 타임';

  @override
  String get monthlyTop10 => '월간 TOP 10';

  @override
  String get searchHint => '검색...';

  @override
  String get noFriendsYet => '아직 친구가 없어요';

  @override
  String get noFriendsHint => '친구를 추가해보세요';

  @override
  String get showQrCode => '내 QR 코드 보여주기';

  @override
  String get enterCode => '코드 입력';

  @override
  String get inviteLinkShare => '초대 링크 공유';

  @override
  String get startDuelAction => '대결 시작';

  @override
  String get pointsLabel => '포인트';

  @override
  String get mostUsedLabel => '가장 많이 사용:';

  @override
  String get recentBadges => '최근 배지';

  @override
  String get allBadgesLabel => '모든 배지';

  @override
  String get removeFriend => '친구 삭제';

  @override
  String get removeFriendConfirm => '이 사람을 친구 목록에서 삭제할까요?';

  @override
  String get remove => '삭제';

  @override
  String get requestSent => '요청 보냄';

  @override
  String get whatCouldYouDo => '어떻게 했을 수 있을까요?';

  @override
  String get back => '뒤로';

  @override
  String get weekly => '주간';

  @override
  String get daily => '일별';

  @override
  String get mostUsedApps => '가장 많이 쓴 앱';

  @override
  String get unlockSection => '잠금 해제';

  @override
  String get selectedDayLabel => '선택한 날';

  @override
  String get todayLabel => '오늘';

  @override
  String weeklyAvgLabel(int h, int m) {
    return '일평균: $h시간 $m분';
  }

  @override
  String get firstUnlock => '첫 잠금 해제';

  @override
  String get mostOpened => '가장 많이 열림';

  @override
  String get timesPickedUp => '집어든 횟수';

  @override
  String get openingCount => '회 실행';

  @override
  String get notificationUnit => '개 알림';

  @override
  String get timesUnit => '번';

  @override
  String get turkey => '튀르키예';

  @override
  String get consecutiveDays => '일 연속';

  @override
  String bestStreakLabel(int days) {
    return '최고: $days일';
  }

  @override
  String get seriFriends => '친구';

  @override
  String get oxygenTitle => '산소 (O₂)';

  @override
  String get totalO2 => '합계';

  @override
  String get remainingShort => '남은';

  @override
  String get noOffersYet => '아직 제공 없음';

  @override
  String o2SpentMsg(int amount) {
    return '$amount O₂ 사용';
  }

  @override
  String get mapLoadFailed => '지도 로드 실패';

  @override
  String confirmRedeemMsg(String reward) {
    return '$reward을(를) 교환할까요?';
  }

  @override
  String itemReceived(String item) {
    return '$item 교환 완료!';
  }

  @override
  String get insufficientO2 => 'O₂가 부족해요';

  @override
  String get season1Title => '시즌 1';

  @override
  String get season1Subtitle => '봄의 각성';

  @override
  String get seasonPassBtn => '시즌 패스 (99TL)';

  @override
  String get seasonPassLabel => '시즌 패스';

  @override
  String get noGroupsYet => '아직 그룹이 없어요';

  @override
  String get noGroupsSubtitle => '친구들과 그룹을 만들어보세요';

  @override
  String get newGroup => '새 그룹';

  @override
  String memberCount(int count) {
    return '$count명';
  }

  @override
  String get weeklyGoal => '주간 목표';

  @override
  String challengeProgress(int percent) {
    return '$percent% 완료';
  }

  @override
  String get membersLabel => '멤버';

  @override
  String get inviteLink => '초대 링크';

  @override
  String get linkCopied => '링크 복사됨!';

  @override
  String get copy => '복사';

  @override
  String get qrCode => 'QR 코드';

  @override
  String get groupNameLabel => '그룹 이름';

  @override
  String get groupNameHint => '그룹 이름 입력';

  @override
  String get groupNameEmpty => '그룹 이름을 입력해주세요';

  @override
  String dailyGoalHours(int hours) {
    return '일일 목표: $hours시간';
  }

  @override
  String get addMember => '멤버 추가';

  @override
  String selectedCount(int count) {
    return '$count명 선택됨';
  }

  @override
  String get create => '만들기';

  @override
  String groupCreated(String name) {
    return '$name 생성됨!';
  }

  @override
  String invitedCount(int count) {
    return '$count명 초대됨';
  }

  @override
  String get screenTimeLower => '스크린 타임';

  @override
  String get improvedFromLastWeek => '지난주보다 12% 개선';

  @override
  String get o2Earned => 'O₂ 획득';

  @override
  String get friendRank => '친구 랭크';

  @override
  String cityRankLabel(String city) {
    return '$city 랭크';
  }

  @override
  String get mostUsed => '가장 많이 사용';

  @override
  String get offGridClub => 'Off-Grid 클럽';

  @override
  String get clubSubtitle => '디지털 균형을 이루고 보상받으세요.';

  @override
  String get planStarter => '스타터';

  @override
  String get planStarterSubtitle => '기본부터 시작';

  @override
  String get currentPlanBtn => '현재 플랜';

  @override
  String get billingMonthly => '월간';

  @override
  String get billingYearly => '연간';

  @override
  String get yearlySavings => '33% 절약';

  @override
  String get planComparison => '플랜 비교';

  @override
  String get breathTechniquesComp => '호흡 기법';

  @override
  String get activeDuelsComp => '활성 대결';

  @override
  String get storyPhoto => '스토리 사진';

  @override
  String get heatMap => '히트맵';

  @override
  String get top10Report => 'TOP 10 리포트';

  @override
  String get exclusiveBadges => '전용 배지';

  @override
  String get adFree => '광고 없음';

  @override
  String get familyPlanComp => '가족 플랜';

  @override
  String get familyReport => '가족 리포트';

  @override
  String get exclusiveThemes => '전용 테마';

  @override
  String get prioritySupport => '우선 지원';

  @override
  String get billingNote =>
      '구독은 언제든지 취소할 수 있어요.\nApp Store/Google Play를 통해 결제됩니다.\n구독은 기간 만료 시 자동 갱신됩니다.';

  @override
  String get restoreSuccess => '구매가 복원됐어요!';

  @override
  String get restoreFailed => '복원할 구매를 찾지 못했어요.';

  @override
  String get packagesLoadFailed => '패키지를 불러오지 못했어요. 다시 시도해주세요.';

  @override
  String get themesTitle => '테마';

  @override
  String get themeLockedMsg => '이 테마는 프로+ 전용이에요! 설정 > Off-Grid 클럽';

  @override
  String get familyPlanTitle => '가족 플랜';

  @override
  String get familyPlanLocked => '함께하는 디지털 밸런스';

  @override
  String get familyPlanLockedDesc =>
      '최대 5명의 가족을 추가하고, 함께 목표를 설정하고 주간 가족 리포트를 받아보세요.';

  @override
  String get weeklyFamilyReport => '주간 가족 리포트';

  @override
  String get familyRanking => '가족 랭킹';

  @override
  String get totalOffline => '총 오프라인';

  @override
  String get average => '평균';

  @override
  String get best => '최고';

  @override
  String offlineTime(int h, int m) {
    return '$h시간 $m분 오프라인';
  }

  @override
  String get enterName => '이름 입력';

  @override
  String get cannotUndo => '이 작업은 되돌릴 수 없어요!';

  @override
  String get deleteWarningDesc => '계정을 삭제하면 다음 데이터가 영구적으로 삭제됩니다:';

  @override
  String get deleteItem1 => '프로필 정보 및 아바타';

  @override
  String get deleteItem2 => '모든 스크린 타임 통계';

  @override
  String get deleteItem3 => '친구 목록 및 대결';

  @override
  String get deleteItem4 => '스토리 및 댓글';

  @override
  String get deleteItem5 => 'O₂ 포인트 및 전리품';

  @override
  String get deleteItem6 => '구독 기록';

  @override
  String get deleteSubscriptionNote =>
      '활성 구독이 있다면 먼저 Apple App Store 또는 Google Play Store에서 취소해야 해요.';

  @override
  String get deleteConfirmCheck => '계정과 모든 데이터가 영구적으로 삭제된다는 것을 이해합니다.';

  @override
  String get deleteAccountBtn => '내 계정 영구 삭제';

  @override
  String get deleteErrorMsg => '오류가 발생했어요. 다시 시도해주세요.';

  @override
  String get emailHint => '이메일';

  @override
  String get passwordHint => '비밀번호';

  @override
  String get forgotPassword => '비밀번호를 잊었어요';

  @override
  String get passwordResetSent => '비밀번호 재설정 이메일이 전송됐어요.';

  @override
  String get signUp => '회원가입';

  @override
  String get signIn => '로그인';

  @override
  String get orDivider => '또는';

  @override
  String get continueWithGoogleShort => 'Google로 계속하기';

  @override
  String get continueWithAppleShort => 'Apple로 계속하기';

  @override
  String get noAccountYet => '계정이 없으신가요? ';

  @override
  String get adminExistingPoints => '기존 포인트';

  @override
  String get adminSearchPlace => '장소 검색...';

  @override
  String get adminRewardTitle => '보상 제목 (예: 무료 커피)';

  @override
  String get adminO2Cost => 'O₂ 비용';

  @override
  String get adminSave => '저장';

  @override
  String get adminSaved => '저장됨!';

  @override
  String get adminDeleteTitle => '삭제';

  @override
  String get adminDeleteMsg => '이 포인트를 삭제할까요?';

  @override
  String adminDeleteError(String error) {
    return '삭제 오류: $error';
  }

  @override
  String get adminFillFields => '보상과 O₂ 비용을 입력하세요';

  @override
  String breathCount(int count) {
    return '$count번 호흡';
  }

  @override
  String minutesRemaining(int count) {
    return '$count분 남음';
  }

  @override
  String focusMinutes(int count) {
    return '$count분 집중했어요';
  }

  @override
  String get o2TimeRestriction => 'O₂는 08:00~00:00 사이에만 획득 가능해요';

  @override
  String get breathTechniqueProMsg => '이 기법은 프로 전용이에요! 설정 > Off-Grid 클럽';

  @override
  String get inhale => '들이쉬기';

  @override
  String get holdBreath => '참기';

  @override
  String get exhale => '내쉬기';

  @override
  String get waitBreath => '대기';

  @override
  String get proMostPopular => '가장 인기';

  @override
  String get proFamilyBadge => '가족';

  @override
  String get comparedToLastWeek => '지난주 대비';

  @override
  String get appBlockTitle => '앱 차단';

  @override
  String get appBlockSchedule => '일정';

  @override
  String get appBlockEnableBlocking => '차단 활성화';

  @override
  String get appBlockActive => '차단 중';

  @override
  String get appBlockInactive => '차단 해제됨';

  @override
  String get appBlockStrictMode => '엄격 모드';

  @override
  String get appBlockStrictDesc => '타이머가 끝날 때까지 해제할 수 없습니다';

  @override
  String get appBlockStrictExpired => '타이머 만료';

  @override
  String get appBlockStrictDurationTitle => '엄격 모드 시간';

  @override
  String get appBlockDuration30m => '30분';

  @override
  String get appBlockDuration1h => '1시간';

  @override
  String get appBlockDuration2h => '2시간';

  @override
  String get appBlockDuration4h => '4시간';

  @override
  String get appBlockDurationAllDay => '하루 종일 (24시간)';

  @override
  String get appBlockScheduleTitle => '차단 일정';

  @override
  String get appBlockScheduleDesc => '일일 시간대 설정';

  @override
  String get appBlockBlockedApps => '차단된 앱';

  @override
  String get appBlockNoApps => '아직 추가된 앱이 없습니다';

  @override
  String get appBlockAddApp => '앱 추가';

  @override
  String get appBlockPickerTitle => '앱 선택';

  @override
  String get appBlockPresetWork => '근무 시간 (09-18)';

  @override
  String get appBlockPresetSleep => '취침 시간 (23-07)';

  @override
  String get appBlockPresetAllDay => '하루 종일';

  @override
  String get appBlockInterventionTitle => '잠깐만...';

  @override
  String get appBlockInterventionSubtitle => '숨을 고르고 자신을 관찰해 보세요';

  @override
  String get appBlockInterventionGiveUp => '그만둘게요';

  @override
  String get appBlockInterventionOpenAnyway => '그래도 열기';

  @override
  String get appBlockStrictModeActive => '엄격 모드 — 열 수 없습니다';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return '이번 주 $app에 $hours시간을 사용했습니다';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return '이번 달 $count번 그만두었습니다';
  }

  @override
  String get pickAppToBan => '차단할 앱 선택';

  @override
  String get pickAppToBanDesc => '상대방은 24시간 동안 이 앱을 열 수 없습니다';

  @override
  String get pickCategory => '카테고리 선택';

  @override
  String get pickCategoryDesc => '이 카테고리의 사용만 집계됩니다';

  @override
  String get rollDiceForTarget => '목표를 위해 주사위를 굴리세요';

  @override
  String get rollDiceDesc => '주사위 값 × 30분 = 목표 시간';

  @override
  String get diceTapToRoll => '탭하여 굴리기';

  @override
  String get diceRolling => '굴리는 중...';

  @override
  String diceResult(int value) {
    return '결과: $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return '목표 시간: $minutes분';
  }

  @override
  String get chooseTeammates => '팀원 선택';

  @override
  String teammatesSelected(int count) {
    return '$count/3 선택됨  ·  2~3명의 팀원을 선택하세요';
  }

  @override
  String get nightDuelInfo => '야간 결투';

  @override
  String get nightDuelRange => '23:00 — 07:00';

  @override
  String get nightDuelBody => '폰을 만지지 않고 잠드세요. 더 오래 버티는 사람이 승리. 고정 8시간.';

  @override
  String get nightDuelAutoStart => '이 결투는 23:00에 자동으로 시작됩니다.';

  @override
  String get mysteryMissionTitle => '미스터리 미션';

  @override
  String get mysteryMissionSubtitle => '미션은 결투 시작 시 공개됩니다';

  @override
  String get mysteryMissionBody => '결투를 시작하면 무작위 미션이 선택됩니다.';

  @override
  String get mysteryStart => '미션 시작';

  @override
  String opponentWantsToBanApp(String app) {
    return '상대방이 당신에게 $app을(를) 차단하기를 원합니다';
  }

  @override
  String opponentWantsCategory(String category) {
    return '상대방이 $category 카테고리에서 경쟁하기를 원합니다';
  }

  @override
  String get proposeDifferentApp => '그 앱이 없습니다, 다른 것을 제안하세요';

  @override
  String get proposeDifferentCategory => '그 카테고리를 사용하지 않습니다, 다른 것을 제안하세요';

  @override
  String get acceptInvite => '수락';

  @override
  String proposalSent(String value) {
    return '제안 전송됨: $value';
  }

  @override
  String get stepAppPicker => '앱 선택';

  @override
  String get stepCategoryPicker => '카테고리 선택';

  @override
  String get stepDice => '주사위 굴리기';

  @override
  String get stepNightInfo => '야간 결투';

  @override
  String get stepMystery => '미스터리 미션';

  @override
  String get stepTeamPicker => '팀원 선택';
}
