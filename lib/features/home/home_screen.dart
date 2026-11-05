import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/fig_widgets.dart';
import '../quran/quran_sanctuary_screen.dart';
import 'prayer_sheets.dart';

/// Figma: "Home" (6001:3021)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF8FAF6), Colors.white]),
      ),
      child: Column(children: [
        // Header - TopAppBar: 64px, #f8faf6, Inter Bold 20/28 #003b29.
        Container(
          color: const Color(0xFFF8FAF6),
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 24, right: 24),
          height: MediaQuery.of(context).padding.top + 74,
          alignment: Alignment.centerLeft,
          child: Text('QuranPro', style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
        ),
        Expanded(
          child: ListenableBuilder(
            listenable: AppState.instance,
            builder: (context, _) => ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              children: [
                const _JourneyCard(progress: 0.2),
                const SizedBox(height: 24),
                const _DailyTargetCard(),
                const SizedBox(height: 24),
                Row(children: [
                  Expanded(
                    child: _ReadOption(
                      title: 'Quran \nin Arabic',
                      subtitle: 'Read the Quran in arabic',
                      color: fc(0x89D6B1, .2),
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.sanctuary, arguments: ReadingMode.arabic),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ReadOption(
                      title: 'Quran \nin Translation',
                      subtitle: 'Read with understanding',
                      color: fc(0xE8C177, .2),
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.sanctuary, arguments: ReadingMode.translation),
                    ),
                  ),
                ]),
                const SizedBox(height: 24),
                Container(
                  height: 96,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    _Tool('background_a4fba5ff', 'Dua', 'Supplications', () => Navigator.of(context).pushNamed(AppRoutes.dua)),
                    _Tool('background_055f7d07', 'Qibla', 'Direction', () => showQiblaSheet(context)),
                    _Tool('background_2209a473', 'Prayer', 'View Schedule', () => showPrayerTimesSheet(context)),
                    _Tool('background_531e780f', 'Virtues of deeds', 'Discover Rewards',
                        () => Navigator.of(context).pushNamed(AppRoutes.virtues)),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard({required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 167,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.1),
        child: Stack(fit: StackFit.expand, children: [
          Image.asset(AppImages.journeyCard, fit: BoxFit.fill),
          const Positioned(left: 274.8, top: 46.5, child: FigIcon('at_icons_moon_98864fe5', w: 25.8, h: 25.8)),
          Positioned(
            left: 17,
            top: 17,
            width: 162,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('YOUR JOURNEY', style: ts(Ff.inter, 10.2, w500, const Color(0xFF91D4B6), lh: 13.6, ls: 1)),
              const SizedBox(height: 3.4),
              Text('${(progress * 100).round()}%', style: ts(Ff.inter, 34, w700, Colors.white, lh: 34)),
              const SizedBox(height: 6.8),
              Opacity(opacity: 0.9, child: Text('completed', style: ts(Ff.inter, 13.6, w400, Colors.white, lh: 20.4))),
              const SizedBox(height: 20),
              Container(
                height: 6.8,
                decoration: BoxDecoration(color: fc(0x006345, .7), borderRadius: BorderRadius.circular(9999)),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(decoration: BoxDecoration(color: AppColors.goldSoft, borderRadius: BorderRadius.circular(9999))),
                ),
              ),
              const SizedBox(height: 5),
              Text('Keep going, you’re doing great!', style: ts(Ff.inter, 10, w400, Colors.white, lh: 20.4)),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _DailyTargetCard extends StatelessWidget {
  const _DailyTargetCard();

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;
    const target = 20;
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final today = DateTime.now().weekday - 1;
    final gold = ts(Ff.inter, 24, w700, Colors.white, lh: 24);
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Stack(children: [
        Positioned(
          left: 252,
          top: -29,
          child: Container(width: 122, height: 122, decoration: const BoxDecoration(color: Color(0xFFF0F4EE), shape: BoxShape.circle)),
        ),
        Positioned(left: 212, top: 16, width: 119, height: 79, child: Image.asset(AppImages.quranStand, fit: BoxFit.cover)),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Daily Recitation Target', style: ts(Ff.inter, 16.3, w700, AppColors.green500, lh: 22.8, ls: -0.2)),
            const SizedBox(height: 3.3),
            Text('Keep your habit strong', style: ts(Ff.inter, 13, w400, AppColors.textMuted, lh: 19.5)),
            const SizedBox(height: 24),
            SizedBox(
              height: 111,
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                SizedBox(
                  width: 128,
                  height: 111,
                  child: OverflowBox(
                    maxHeight: 128,
                    child: GoldRing(
                      progress: s.minutesReadToday / target,
                      size: 128,
                      trackWidth: 10.2,
                      arcWidth: 10.2,
                      inset: 7.7,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        GradientText('${s.minutesReadToday}', style: gold, gradient: AppColors.goldGradient),
                        GradientText('min', style: ts(Ff.inter, 12, w500, Colors.white, lh: 16, ls: 0.6), gradient: AppColors.goldGradient),
                      ]),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 76.6,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        width: 152,
                        height: 32,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('Target: $target min', style: ts(Ff.inter, 16, w500, AppColors.textPrimary, lh: 24)),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.myGoals),
                            child: const FigIcon('button_7844907e', w: 32, h: 32),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        for (var i = 0; i < 7; i++) _day(days[i], i < today ? 0 : (i == today ? 1 : 2), s.minutesReadToday, target),
                      ]),
                    ]),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 24),
            FigButton(
              label: 'Let\'s Read Now',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.dailyReading),
              leading: const FigIcon('container_2fe1f902', w: 22, h: 16),
              trailing: const FigIcon('margin_bcb7d0ed', w: 24, h: 16),
              gap: 12,
              textStyle: ts(Ff.inter, 16, w500, Colors.white, lh: 24),
            ),
          ]),
        ),
      ]),
    );
  }

  /// state: 0 done · 1 today · 2 upcoming
  Widget _day(String label, int state, int minutes, int target) {
    final circle = switch (state) {
      0 => const FigIcon('background_02513878', w: 19.7, h: 19.7),
      1 => Container(
          width: 19.7,
          height: 19.7,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.gold, width: 1.2)),
          alignment: Alignment.center,
          child: GradientText('$minutes', style: ts(Ff.inter, 9.8, w700, Colors.white, lh: 14.8), gradient: AppColors.goldGradient),
        ),
      _ => Container(
          width: 19.7,
          height: 19.7,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.surfaceAlt),
          alignment: Alignment.center,
          child: Text('$target', style: ts(Ff.inter, 9.8, w500, AppColors.textMuted, lh: 14.8)),
        ),
    };
    return Column(children: [
      circle,
      const SizedBox(height: 5),
      state == 1
          ? GradientText(label, style: ts(Ff.inter, 7.4, w700, Colors.white, lh: 9.8, ls: 0.4), gradient: AppColors.goldGradient)
          : Text(label, style: ts(Ff.inter, 7.4, w500, AppColors.textMuted, lh: 9.8, ls: 0.4)),
    ]);
  }
}

class _ReadOption extends StatelessWidget {
  const _ReadOption({required this.title, required this.subtitle, required this.color, required this.onTap});
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: SizedBox(
          height: 179.5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const FigIcon('overlay_e67e4c0d', w: 48, h: 48),
              const SizedBox(height: 16),
              Text(title, textAlign: TextAlign.center, style: ts(Ff.inter, 20, w700, AppColors.textPrimary, lh: 28, ls: -0.2)),
              const SizedBox(height: 3.5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                  child: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(Ff.inter, 9, w500, AppColors.textSecondary, lh: 16, ls: 0.6)),
                ),
                const SizedBox(width: 4),
                const FigIcon('container_c7216164', w: 9.3, h: 9.3),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}

class _Tool extends StatelessWidget {
  const _Tool(this.icon, this.title, this.sub, this.onTap);
  final String icon;
  final String title;
  final String sub;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 83.7,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            FigIcon(icon, w: 36, h: 36),
            const SizedBox(height: 7.7),
            Text(title, maxLines: 1, textAlign: TextAlign.center, style: ts(Ff.inter, 10.3, w500, AppColors.textPrimary, lh: 15.4)),
            Text(sub, textAlign: TextAlign.center, style: ts(Ff.inter, 5.8, w500, AppColors.textSecondary, lh: 10.3, ls: 0.4)),
          ]),
        ),
      );
}
