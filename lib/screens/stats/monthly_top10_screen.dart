import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../services/haptic_service.dart';

/// Instagram Stories tarzı aylık top 10 — her sayfa otomatik ilerler,
/// meme'ler ve eğlenceli metinlerle dolu.
class MonthlyTop10Screen extends StatefulWidget {
  const MonthlyTop10Screen({super.key});

  @override
  State<MonthlyTop10Screen> createState() => _MonthlyTop10ScreenState();
}

class _MonthlyTop10ScreenState extends State<MonthlyTop10Screen> {
  final _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoTimer;
  static const _pageDuration = Duration(seconds: 5);

  // Her ay farklı meme seti
  static final _month = DateTime.now().month;

  static final List<_StorySlide> _slides = [
    // Slide 0: Intro
    _StorySlide(
      gradient: [const Color(0xFF0F0C29), const Color(0xFF302B63), const Color(0xFF24243E)],
      emoji: '📊',
      title: 'Mart 2026',
      subtitle: 'AYIN ÖZETİ',
      body: 'Kim telefonu bıraktı?\nKim bırakamadı?\nBakalım...',
      meme: null,
    ),
    // Slide 1: #1 Best
    _StorySlide(
      gradient: [const Color(0xFF0D7377), const Color(0xFF14FFEC)],
      emoji: '🥇',
      title: 'AYIN KRALICASI',
      subtitle: '#1 En Az Ekran Süresi',
      body: null,
      userName: 'Zeynep',
      userColor: Color(0xFFF093FB),
      stat: '1s 20dk/gün',
      meme: _memes[_month % _memes.length][0],
    ),
    // Slide 2: #2-3 Best
    _StorySlide(
      gradient: [const Color(0xFF11998E), const Color(0xFF38EF7D)],
      emoji: '🏅',
      title: 'PODYUM',
      subtitle: '#2 ve #3',
      body: null,
      entries: [
        ('Burak', Color(0xFF4FACFE), '1s 45dk/gün', '🥈'),
        ('Elif', Color(0xFFA8EB12), '2s 10dk/gün', '🥉'),
      ],
      meme: _memes[_month % _memes.length][1],
    ),
    // Slide 3: Top 4-10
    _StorySlide(
      gradient: [const Color(0xFF1A2980), const Color(0xFF26D0CE)],
      emoji: '✨',
      title: 'TOP 10 — DİJİTAL DİYETÇİLER',
      subtitle: 'Telefondan uzak duranlar',
      body: null,
      entries: [
        ('Selin', Color(0xFF667EEA), '2s 30dk', '4'),
        ('Can', AppColors.neonOrange, '2s 45dk', '5'),
        ('Eren', Color(0xFF667EEA), '3s 00dk', '6'),
        ('Deniz', Color(0xFF00C9DB), '3s 15dk', '7'),
        ('Ayşe', Color(0xFFFF6B9D), '3s 30dk', '8'),
        ('Mert', Color(0xFF4FACFE), '3s 45dk', '9'),
        ('Yağız', Color(0xFFA8EB12), '4s 00dk', '10'),
      ],
      meme: null,
    ),
    // Slide 4: Worst intro
    _StorySlide(
      gradient: [const Color(0xFF200122), const Color(0xFF6F0000)],
      emoji: '💀',
      title: 'UTANÇ DUVARI',
      subtitle: 'Telefondan ayrılamayanlar',
      body: 'Şimdi biraz acı gerçekler...',
      meme: _memes[_month % _memes.length][2],
    ),
    // Slide 5: #1 Worst
    _StorySlide(
      gradient: [const Color(0xFFB91D73), const Color(0xFFF953C6)],
      emoji: '📱',
      title: 'AYIN TELEFON BAĞIMLISI',
      subtitle: '#1 En Çok Ekran Süresi',
      body: null,
      userName: 'Kaan',
      userColor: AppColors.neonOrange,
      stat: '8s 30dk/gün',
      meme: _memes[_month % _memes.length][3],
    ),
    // Slide 6: Worst 2-10
    _StorySlide(
      gradient: [const Color(0xFF360033), const Color(0xFF0B8793)],
      emoji: '🫣',
      title: 'UTANÇ LİSTESİ',
      subtitle: 'Bu ay abartanlar',
      body: null,
      entries: [
        ('Beren', Color(0xFFF093FB), '7s 45dk', '2'),
        ('Arda', Color(0xFF4FACFE), '7s 20dk', '3'),
        ('İrem', Color(0xFF667EEA), '6s 50dk', '4'),
        ('Oğuz', Color(0xFFA8EB12), '6s 30dk', '5'),
        ('Nisa', Color(0xFF00C9DB), '6s 15dk', '6'),
        ('Emre', Color(0xFFFF6B9D), '6s 00dk', '7'),
        ('Pınar', Color(0xFF4FACFE), '5s 45dk', '8'),
        ('Alp', Color(0xFFA8EB12), '5s 30dk', '9'),
        ('Ceren', Color(0xFFF093FB), '5s 15dk', '10'),
      ],
      meme: null,
    ),
    // Slide 7: Most improved
    _StorySlide(
      gradient: [const Color(0xFF4776E6), const Color(0xFF8E54E9)],
      emoji: '📈',
      title: 'AYIN COMEBACK KRALI',
      subtitle: 'En çok gelişenler',
      body: null,
      entries: [
        ('Burak', Color(0xFF4FACFE), '-%42', '🚀'),
        ('Zeynep', Color(0xFFF093FB), '-%38', '🔥'),
        ('Elif', Color(0xFFA8EB12), '-%35', '💪'),
        ('Can', AppColors.neonOrange, '-%28', '⚡'),
        ('Selin', Color(0xFF667EEA), '-%22', '✨'),
      ],
      meme: _memes[_month % _memes.length][4],
    ),
    // Slide 8: Outro
    _StorySlide(
      gradient: [const Color(0xFF0F0C29), const Color(0xFF302B63), const Color(0xFF24243E)],
      emoji: '🎯',
      title: 'Nisan\'da sıra sende!',
      subtitle: 'Hedefini koy, telefonunu bırak',
      body: 'Bir sonraki ayın en iyisi\nSEN olabilirsin 💚',
      meme: null,
    ),
  ];

  // Ay bazlı farklı meme/mesaj setleri (5 meme per set)
  static const _memes = [
    // Set 0
    [
      '"Telefonu bırak" dedi, bıraktı. Efsane.',
      'Bu ikili telefon görmemiş bu ay 🙈',
      'Telefonun: "Beni neden açmıyorsun artık?" 😢',
      'Telefon: "Kaan, bırak beni artık"\nKaan: "Hayır."',
      'Geçen ay: 7 saat → Bu ay: 4 saat. İşte buna gelişim derim 💪',
    ],
    // Set 1
    [
      'Zeynep bu ay başka bir seviyeye çıktı 👑',
      'Podium yine değişmedi, konsistans bu olsa gerek',
      'Plot twist: Telefon sahiplerini terk etmeye başladı',
      'Kaan\'ın telefonu: "Mola ver artık abi" 😭',
      'Comeback of the year! Alkış hak ediyor 👏',
    ],
    // Set 2
    [
      'Bu insan gerçek mi? 1 saat 20 dk? Saygılar...',
      'İkisi de "challenge accepted" demiş',
      '"Telefonsuz yaşam" documentary\'si yakında',
      'Bir ay boyunca Netflix\'e abone olmuş gibi kullanmış',
      'Bu düşüş oranı borsa görseydi zengin olurdun 📉→📈',
    ],
    // Set 3
    [
      'Herkes konuşur, Zeynep yapar. Respect.',
      'Bu iki kişi sanki yarışıyor',
      'Telefonlar ağlıyor: "Kimse bizi sevmiyor artık"',
      'Bro literally telefonu yastık yapmış',
      'En çok gelişen = En çok kararlı. Basit.',
    ],
    // Set 4
    [
      'Telefondan uzak kalmak süper güç mü? Zeynep: "Evet."',
      'İkinci ve üçüncü sıra fena kapışmış',
      'Bu listede olmak istemeyen herkes: 😬',
      'Telefon kullanım rekoru kırıldı... ama kötü yönde 😅',
      'Geri dönüş hikayesi yazmışlar, bravo!',
    ],
    // Set 5
    [
      '1 saat 20 dk. Bu kadar az kullanan var mıydı?',
      'Top 3 bu ay da değişmedi, legends never die',
      'Telefonlar: "Biz ne yaptık size?"',
      'Ekran süresi bu kadar yüksek olmamalıydı ama...',
      'En büyük düşüş! Bu azim herkese örnek olsun 🏆',
    ],
  ];

  @override
  void initState() {
    super.initState();
    _startAutoAdvance();
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoAdvance() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(_pageDuration, (_) {
      if (_currentPage < _slides.length - 1) {
        _goToPage(_currentPage + 1);
      } else {
        _autoTimer?.cancel();
      }
    });
  }

  void _goToPage(int page) {
    if (!mounted) return;
    _pageController.animateToPage(page, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    setState(() => _currentPage = page);
    _startAutoAdvance();
  }

  void _onTapLeft() {
    if (_currentPage > 0) {
      HapticService.light();
      _goToPage(_currentPage - 1);
    }
  }

  void _onTapRight() {
    if (_currentPage < _slides.length - 1) {
      HapticService.light();
      _goToPage(_currentPage + 1);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Pages
          PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (i) {
              setState(() => _currentPage = i);
              _startAutoAdvance();
            },
            itemBuilder: (_, i) => _SlideWidget(slide: _slides[i]),
          ),

          // Tap zones (left/right)
          Positioned.fill(
            child: Row(
              children: [
                Expanded(child: GestureDetector(onTap: _onTapLeft, behavior: HitTestBehavior.translucent)),
                Expanded(child: GestureDetector(onTap: _onTapRight, behavior: HitTestBehavior.translucent)),
              ],
            ),
          ),

          // Progress bars (top)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            right: 12,
            child: Row(
              children: List.generate(_slides.length, (i) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: i <= _currentPage
                          ? AppColors.neonGreen
                          : Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Close button
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            right: 16,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close_rounded, color: Colors.white, size: 18),
              ),
            ),
          ),

          // gooffgrid branding (top left)
          Positioned(
            top: MediaQuery.of(context).padding.top + 22,
            left: 16,
            child: const Text(
              'gooffgrid',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }
}

class _StorySlide {
  final List<Color> gradient;
  final String emoji;
  final String title;
  final String subtitle;
  final String? body;
  final String? userName;
  final Color? userColor;
  final String? stat;
  final String? meme;
  final List<(String, Color, String, String)>? entries;

  const _StorySlide({
    required this.gradient,
    required this.emoji,
    required this.title,
    required this.subtitle,
    this.body,
    this.userName,
    this.userColor,
    this.stat,
    this.meme,
    this.entries,
  });
}

class _SlideWidget extends StatelessWidget {
  const _SlideWidget({required this.slide});
  final _StorySlide slide;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: slide.gradient,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Emoji
              Text(slide.emoji, style: const TextStyle(fontSize: 64)),
              const SizedBox(height: 20),

              // Title
              Text(
                slide.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                slide.subtitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Single user highlight
              if (slide.userName != null) ...[
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: slide.userColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: (slide.userColor ?? Colors.white).withValues(alpha: 0.5), blurRadius: 24),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      slide.userName![0],
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  slide.userName!,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    slide.stat!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ],

              // Entry list
              if (slide.entries != null) ...[
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: slide.entries!.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 28,
                                child: Text(
                                  e.$4,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 10),
                              CircleAvatar(radius: 14, backgroundColor: e.$2, child: Text(e.$1[0], style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600))),
                              const SizedBox(width: 10),
                              Expanded(child: Text(e.$1, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white))),
                              Text(e.$3, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.8))),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],

              // Body text
              if (slide.body != null) ...[
                const SizedBox(height: 16),
                Text(
                  slide.body!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              // Meme text (fun caption)
              if (slide.meme != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    slide.meme!,
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.white.withValues(alpha: 0.8),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
