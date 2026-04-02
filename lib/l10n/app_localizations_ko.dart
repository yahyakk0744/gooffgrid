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
  String get longestOffScreen => '최장 오프라인 시간';

  @override
  String get dailyGoal => '일일 목표';

  @override
  String get streak => '연속 기록';

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
  String get logout => '로그아웃';

  @override
  String get shareProfile => '프로필 공유';

  @override
  String get shareReportCard => 'Drop the Air';

  @override
  String get o2Balance => 'O₂ Points';

  @override
  String get offGridMarket => 'Loot';

  @override
  String get offGridMarketHint => 'Turn O₂ points into real-world loot';

  @override
  String get appUsage => '앱 사용량';

  @override
  String get weeklyReport => '주간 리포트';

  @override
  String get seasons => '시즌';

  @override
  String get groups => '그룹';

  @override
  String get createGroup => '그룹 만들기';

  @override
  String get stats => '통계';

  @override
  String get whatIf => '만약에?';

  @override
  String get focusMode => '호흡';

  @override
  String get reportCard => '성적표';

  @override
  String get antiSocialStory => '반사회적 순간';

  @override
  String get postStory => '게시';

  @override
  String get storyExpired => '만료됨';

  @override
  String get noStories => '아직 스토리가 없습니다';

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
  String get deleteAccount => '계정 삭제';

  @override
  String get deleteAccountConfirm =>
      '계정과 모든 데이터가 영구적으로 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get error => '오류';

  @override
  String get tryAgain => '다시 시도';

  @override
  String get loading => '로딩 중...';

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
}
