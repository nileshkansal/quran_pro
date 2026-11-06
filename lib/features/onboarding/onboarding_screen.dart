import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';
import 'widgets/onboarding_bar.dart';

/// Figma: "Onboarding 1" … "Onboarding 5" (6001:1733 / 1795 / 1937 / 2004 / 2122).
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, this.tour = false});

  /// When opened from Help ▸ How to Use, the last "Next" just closes the tour.
  final bool tour;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pc = PageController();
  int _page = 0;

  // Per-page bottom offset of the bar and top of the wave, from Figma.
  static const _barBottom = [40.1, 61.1, 57.1, 61.1, 47.1];
  static const _waveTop = <double>[629.5, 624, 628, 624, 638];

  void _next() {
    if (_page < 4) {
      _pc.nextPage(duration: const Duration(milliseconds: 380), curve: Curves.easeOutCubic);
    } else if (widget.tour) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushNamed(AppRoutes.createProfile);
    }
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(children: [
        PageView(
          controller: _pc,
          onPageChanged: (i) => setState(() => _page = i),
          children: [
            for (var i = 0; i < 5; i++)
              DesignCanvas(
                decoration: i == 4 ? const BoxDecoration(color: AppColors.background) : _pageGradient(i == 0),
                children: [
                  ..._pageContent(i),
                  Positioned(
                    top: _waveTop[i],
                    left: -90.5,
                    width: 567,
                    height: 233,
                    child: Image.asset(i == 0 ? AppIcons.waveGold : AppIcons.waveCream, fit: BoxFit.fill),
                  ),
                ],
              ),
          ],
        ),
        // Bottom bar (fixed while pages slide).
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          bottom: _barBottom[_page],
          left: 16,
          right: 16,
          child: Center(child: OnboardingBar(index: _page, onNext: _next, firstPage: _page == 0)),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top,
          right: 8,
          child: TextButton(
            onPressed: () => widget.tour ? Navigator.of(context).pop() : Navigator.of(context).pushNamed(AppRoutes.createProfile),
            child: Text(widget.tour ? 'Close' : 'Skip', style: ts(AppFonts.inter, 13, w500, AppColors.textMuted)),
          ),
        ),
      ]),
    );
  }

  BoxDecoration _pageGradient(bool first) => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [first ? AppColors.surface : AppColors.grey02, AppColors.white],
        ),
      );

  List<Widget> _pageContent(int i) => switch (i) {
        0 => _page1(),
        1 => _page2(),
        2 => _page3(),
        3 => _page4(),
        _ => _page5(),
      };

  // ───────────── Onboarding 1 ─────────────
  List<Widget> _page1() => [
        Positioned.fill(child: Image.asset(AppImages.onb1Bg, fit: BoxFit.cover, alignment: Alignment.topCenter)),
        Positioned(
          top: 76,
          left: 48,
          right: 48,
          child: Column(children: [
            const Logo.small(width: 103.6),
            AppGap.v30,
            SizedBox(
              width: 236,
              child: Text(
                'The Quran was revealed to be understood',
                textAlign: TextAlign.center,
                style: ts(AppFonts.poppins, 17, w600, AppColors.green800, lh: 28, ls: -0.2),
              ),
            ),
            AppGap.v30,
            const GoldFadeLine(),
            AppGap.v30,
            SizedBox(
              width: 279,
              child: Column(children: [
                _iconLine('frame_2085667648_b1a9eda4', 'Millions of Muslims read the Qur\'an without understanding its meaning.', 20),
                AppGap.v15,
                _iconLine('frame_2085667648_f6d39382', 'Our mission is to help Muslims understand the message of the Qur\'an.', 18),
                AppGap.v15,
                _iconLine('frame_2085667648_7620cf0f',
                    'Through QuranPro, we help people reflect on its verses, strengthen their connection with Allah, and live by the guidance of the Qur\'an.', 20),
              ]),
            ),
          ]),
        ),
      ];

  Widget _iconLine(String icon, String text, double lh) => Row(children: [
        AppIcon(icon, w: 40, h: 40),
        AppGap.h10,
        Expanded(child: Text(text, style: ts(AppFonts.poppins, 11, w400, AppColors.pureBlack, lh: lh))),
      ]);

  // ───────────── Onboarding 2 ─────────────
  List<Widget> _page2() => [
        Positioned(
          top: 39,
          left: 41,
          right: 37,
          child: Column(children: [
            const AppIcon('frame_2085667722_6a0c3718', w: 65.5, h: 63),
            AppGap.v16,
            SizedBox(
              width: 296,
              child: Text(
                'Don’t Feel the Connection Between Verses?',
                textAlign: TextAlign.center,
                style: ts(AppFonts.poppins, 17, w600, AppColors.green800, lh: 25, ls: -0.2),
              ),
            ),
            AppGap.v16,
            const GoldFadeLine(),
            AppGap.v16,
            Text(
              'We’ve organized the Qur’an into topic-based sections with a short summary before each one, helping you understand, ponder, and connect the verses with ease.',
              textAlign: TextAlign.center,
              style: ts(AppFonts.poppins, 11, w400, AppColors.pureBlack, lh: 22),
            ),
          ]),
        ),
        // Phone mock: black body, live screenshot, then bezel + island on top.
        Positioned(
          top: 310,
          left: 16,
          width: 224.9,
          height: 456.7,
          child: Stack(children: [
            Positioned.fill(child: Image.asset(AppIcons.onb2PhoneFrame, fit: BoxFit.fill)),
            Positioned(
              left: 11.2,
              top: 9.5,
              width: 202.4,
              height: 438,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28.5),
                child: Image.asset(AppImages.onb2Screen, fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
              ),
            ),
            const Positioned(left: 80.4, top: 16.4, child: AppIcon('camera_17b026da', w: 64, h: 18.7)),
          ]),
        ),
        _callout(345, 248, 31, 14, 'Chapter / Surah ', 'Each Surah is clearly identified.', 22),
        _callout(414, 208, 58, 9, 'Section Summary ', 'A short overview to set the context before you read.', 33),
        _callout(590, 244, 29, 9, 'Verses in Order ', 'Read verses with translation and easy actions.', 33),
      ];

  Widget _callout(double top, double left, double lineW, double gap, String title, String body, double bodyH) => Positioned(
        top: top,
        left: left,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(width: lineW, height: 0.7, color: AppColors.pureBlack),
          SizedBox(width: gap),
          SizedBox(
            width: 102.9,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text(title, style: ts(AppFonts.inter, 12, w600, AppColors.textPrimary, lh: 19.5)),
              SizedBox(
                width: 94,
                child: Text(body, style: ts(AppFonts.inter, 10, w500, AppColors.textMuted, lh: 11)),
              ),
            ]),
          ),
        ]),
      );

  // ───────────── Onboarding 3 ─────────────
  static const _features = [
    ('splash_screen_9cd1f4f1', 'Personalized \nReading Targets'),
    ('splash_screen_5fbabdce', 'Motivational \nReminders'),
    ('splash_screen_becfeb91', 'Creative \nNotifications'),
    ('splash_screen_692d4a90', 'Beautiful Home \nScreen Widgets'),
    ('splash_screen_4943a594', 'Progress \nTracking'),
  ];

  List<Widget> _page3() => [
        Positioned.fill(child: Image.asset(AppImages.onb3Bg, fit: BoxFit.cover, alignment: Alignment.topCenter)),
        Positioned(
          top: 110,
          left: 20,
          width: 300,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Addicted to scrolling?', style: ts(AppFonts.poppins, 26.1, w600, AppColors.green800, lh: 34.8)),
            const SizedBox(height: 8.2),
            SizedBox(
              width: 184.1,
              child: Text('Turn your scrolling into\na Quran habit.', style: ts(AppFonts.inter, 12.4, w500, AppColors.pureBlack, lh: 20.4)),
            ),
            AppGap.v16,
            Container(width: 49.1, height: 2, color: AppColors.gold63),
            AppGap.v16,
            SizedBox(
              width: 164.7,
              child: Text(
                'QuranPro is designed to help you build a daily Qur’an habit through personalized reading targets, motivational reminders, creative notifications, beautiful home screen widgets, and progress tracking—keeping you inspired every day.',
                style: ts(AppFonts.poppins, 10.3, w400, AppColors.pureBlack, lh: 22.3),
              ),
            ),
            const SizedBox(height: 30.4),
            for (var k = 0; k < _features.length; k++) ...[
              if (k > 0) const SizedBox(height: 15.3),
              Row(children: [
                Container(
                  width: 36.8,
                  height: 36.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.2),
                    boxShadow: [fShadow(AppColors.pureBlack.o(.2), 0, 2, 14.3)],
                  ),
                  child: AppIcon(_features[k].$1, w: 36.8, h: 36.8),
                ),
                const SizedBox(width: 8.2),
                Text(_features[k].$2, style: ts(AppFonts.inter, 10.2, w400, AppColors.pureBlack, lh: 14.3)),
              ]),
            ],
          ]),
        ),
      ];

  // ───────────── Onboarding 4 ─────────────
  List<Widget> _page4() => [
        Positioned(
          top: 39,
          left: 41,
          right: 37,
          child: Column(children: [
            const AppIcon('frame_2085667722_6a0c3718', w: 65.5, h: 63),
            AppGap.v20,
            SizedBox(
              width: 296,
              child: Text(
                'Completely Free.  No Subscription Required.',
                textAlign: TextAlign.center,
                style: ts(AppFonts.poppins, 17, w600, AppColors.green800, lh: 28, ls: -0.2),
              ),
            ),
            AppGap.v15,
            const GoldFadeLine(),
            AppGap.v15,
            Text('Why pay every month?', textAlign: TextAlign.center, style: ts(AppFonts.inter, 12, w400, AppColors.pureBlack, lh: 13)),
          ]),
        ),
        const Positioned(top: 259, left: 16, width: 358, height: 295, child: _CompareTable()),
        Positioned(
          top: 592,
          left: 16,
          right: 16,
          height: 64,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: 174,
              child: Text(
                'Because everyone deserves  free access to the Qur’an  and its understanding.',
                style: ts(AppFonts.poppins, 11, w400, AppColors.pureBlack, lh: 18),
              ),
            ),
            Image.asset(AppImages.quranStandBig, width: 96, height: 64, fit: BoxFit.cover),
          ]),
        ),
      ];

  // ───────────── Onboarding 5 ─────────────
  static const _tools = [
    ('background_f33958cf', 'Qibla', 85.3),
    ('background_0216d5f3', 'Dua', 86.5),
    ('background_583c5c40', 'Prayer\nTimes', 87.8),
    ('background_986b0cee', 'Virtues of good deeds', 91.4),
  ];

  List<Widget> _page5() => [
        const Positioned.fill(child: LanternBackdrop(footerTop: 670)),
        Positioned(
          top: 128,
          left: 20,
          right: 19,
          child: Column(children: [
            const Logo.small(width: 103.6),
            const SizedBox(height: 45),
            SizedBox(
              width: 323,
              child: Text('More Than \nJust a Quran App',
                  textAlign: TextAlign.center, style: ts(AppFonts.inter, 25, w600, AppColors.textPrimary, lh: 35)),
            ),
            AppGap.v15,
            const DecorDivider(),
            AppGap.v15,
            SizedBox(
              width: 334,
              child: Text(
                'We help you make the Qur’an a part of your everyday life — reading with understanding and discovering guidance in every verse.',
                textAlign: TextAlign.center,
                style: ts(AppFonts.poppins, 12, w400, AppColors.textSecondary, lh: 25),
              ),
            ),
            const SizedBox(height: 36),
            Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (final t in _tools)
                SizedBox(
                  width: t.$3,
                  child: Column(children: [
                    AppIcon(t.$1, w: 50, h: 50),
                    const SizedBox(height: 9.4),
                    Text(t.$2, textAlign: TextAlign.center, style: ts(AppFonts.inter, 12.6, w500, AppColors.textPrimary, lh: 18.8)),
                  ]),
                ),
            ]),
            const SizedBox(height: 22),
            Container(
              width: 339,
              height: 55,
              padding: const EdgeInsets.all(8.4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(11.8),
                boxShadow: AppShadows.glow,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _badge('security_check_90cc3561', '100% Free.', 'Made for the ummah.'),
                const SizedBox(width: 15.2),
                Container(width: 0.8, height: 14.4, color: AppColors.pureBlack),
                const SizedBox(width: 15.2),
                _badge('gift_1196161c', 'No hidden charges.', 'Just pure benefit.'),
              ]),
            ),
          ]),
        ),
      ];

  Widget _badge(String icon, String a, String b) => SizedBox(
        width: 136.8,
        child: Row(children: [
          AppIcon(icon, w: 20.3, h: 20.3),
          const SizedBox(width: 9.3),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              // Figma's text boxes are wider than their column; let them run over.
              Text(a, softWrap: false, overflow: TextOverflow.visible, style: ts(AppFonts.inter, 11.8, w600, AppColors.pureBlack, lh: 11)),
              const SizedBox(height: 4.2),
              Text(b, softWrap: false, overflow: TextOverflow.visible, style: ts(AppFonts.inter, 10.1, w500, AppColors.pureBlack, lh: 11)),
            ]),
          ),
        ]),
      );
}

/// Onboarding 4 comparison table (QuranPro vs Netflix / Prime / Spotify).
class _CompareTable extends StatelessWidget {
  const _CompareTable();

  static final _gold = ts(AppFonts.inter, 12, w500, AppColors.white, lh: 13);

  // Single line: Figma's price boxes (58px) are narrower than "₹649/month".
  Widget _goldText(String s, TextStyle st) => GradientText(s, style: st, gradient: AppColors.goldGradient, textAlign: TextAlign.center, softWrap: false);

  Widget _tick() => const AppIcon('teenyicons_tick_circle_solid_b1bcd1f5', w: 15, h: 15);
  Widget _dash() => SizedBox(
        width: 15,
        height: 15,
        child: Center(child: _goldText('-', ts(AppFonts.inter, 19, w400, AppColors.white, lh: 13))),
      );

  Widget _col({required double width, required double gap, required List<Widget> children, BoxDecoration? deco}) => Container(
        width: width,
        height: 295,
        decoration: deco,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (var i = 0; i < children.length; i++) ...[if (i > 0) SizedBox(height: gap), children[i]],
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final label = ts(AppFonts.inter, 10, w400, AppColors.pureBlack, lh: 13);
    return Stack(children: [
      Positioned(
        top: 19,
        left: 0,
        width: 99,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: 79, child: Text('What you pay', textAlign: TextAlign.center, style: ts(AppFonts.inter, 12, w500, AppColors.pureBlack, lh: 13))),
          const SizedBox(height: 47),
          for (final (i, s) in ['Monthly cost', 'Premium Content', 'Offline Access', 'Ad-free Experience', 'Rewards for your deen'].indexed) ...[
            if (i > 0) const SizedBox(height: 21),
            SizedBox(width: i == 1 ? 99 : 79, height: 26, child: Text(s, style: label)),
          ],
        ]),
      ),
      Positioned(
        left: 102,
        top: 0,
        width: 254,
        height: 295,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _col(
            width: 53,
            gap: 33,
            deco: BoxDecoration(
              color: AppColors.gold07,
              border: Border.all(color: AppColors.pureBlack.o(.2)),
              borderRadius: BorderRadius.circular(11),
            ),
            children: [
              const AppIcon('frame_2085667723_6c813e81', w: 45.5, h: 43.9),
              _goldText('Free', _gold),
              _tick(), _tick(), _tick(), _tick(),
            ],
          ),
          AppGap.h10,
          _col(width: 58, gap: 33, children: [
            SizedBox(
              height: 43.9,
              child: Column(children: [
                const AppIcon('thesvg_color_netflix_aceb46bb', w: 13.9, h: 25.3),
                const SizedBox(height: 5.6),
                _goldText('Netflix', ts(AppFonts.inter, 11.2, w400, AppColors.white, lh: 12.2)),
              ]),
            ),
            _goldText('₹649/month', _gold),
            _tick(), _tick(), _dash(), _dash(),
          ]),
          AppGap.h10,
          _col(width: 57, gap: 33, children: [
            const AppIcon('selfhst_amazon_prime_4640a26e', w: 43.1, h: 43.1),
            _goldText('₹299/month', _gold),
            _tick(), _tick(), _dash(), _dash(),
          ]),
          AppGap.h10,
          _col(width: 56, gap: 34, children: [
            SizedBox(
              height: 44.1,
              child: Column(children: [
                const AppIcon('selfhst_spotify_58d21b89', w: 19.7, h: 19.7),
                const SizedBox(height: 7.4),
                _goldText('Spotify', ts(AppFonts.inter, 14.8, w400, AppColors.white, lh: 16)),
              ]),
            ),
            _goldText('₹199/month', _gold),
            _tick(), _tick(), _tick(), _dash(),
          ]),
        ]),
      ),
    ]);
  }
}
