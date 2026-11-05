import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../quran/quran_sanctuary_screen.dart';
import 'prayer_sheets.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Home" (6001:3021)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: AppColors.pageGradient,
      ),
      child: Column(children: [
        // Header - TopAppBar: 64px, #f8faf6, Inter Bold 20/28 #003b29.
        Container(
          color: AppColors.surface,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 24, right: 24),
          height: MediaQuery.of(context).padding.top + 74,
          alignment: Alignment.centerLeft,
          child: Text('QuranPro', style: AppTextStyles.title),
        ),
        Expanded(
          child: ListenableBuilder(
            listenable: AppState.instance,
            builder: (context, _) => ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              children: [
                const _JourneyCard(progress: 0.2),
                AppGap.v24,
                const _DailyTargetCard(),
                AppGap.v24,
                Row(children: [
                  Expanded(
                    child: _ReadOption(
                      title: 'Quran \nin Arabic',
                      subtitle: 'Read the Quran in arabic',
                      color: AppColors.green31.o(.2),
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.sanctuary, arguments: ReadingMode.arabic),
                    ),
                  ),
                  AppGap.h10,
                  Expanded(
                    child: _ReadOption(
                      title: 'Quran \nin Translation',
                      subtitle: 'Read with understanding',
                      color: AppColors.goldSoft.o(.2),
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.sanctuary, arguments: ReadingMode.translation),
                    ),
                  ),
                ]),
                AppGap.v24,
                Container(
                  height: 96,
                  padding: AppInsets.h4,
                  decoration: const BoxDecoration(color: AppColors.white, borderRadius: AppRadius.br24),
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
          const Positioned(left: 274.8, top: 46.5, child: AppIcon('at_icons_moon_98864fe5', w: 25.8, h: 25.8)),
          Positioned(
            left: 17,
            top: 17,
            width: 162,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('YOUR JOURNEY', style: ts(AppFonts.inter, 10.2, w500, AppColors.green30, lh: 13.6, ls: 1)),
              const SizedBox(height: 3.4),
              Text('${(progress * 100).round()}%', style: ts(AppFonts.inter, 34, w700, AppColors.white, lh: 34)),
              const SizedBox(height: 6.8),
              Opacity(opacity: 0.9, child: Text('completed', style: ts(AppFonts.inter, 13.6, w400, AppColors.white, lh: 20.4))),
              AppGap.v20,
              Container(
                height: 6.8,
                decoration: BoxDecoration(color: AppColors.green81.o(.7), borderRadius: AppRadius.pill),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(decoration: const BoxDecoration(color: AppColors.goldSoft, borderRadius: AppRadius.pill)),
                ),
              ),
              const SizedBox(height: 5),
              Text('Keep going, you’re doing great!', style: ts(AppFonts.inter, 10, w400, AppColors.white, lh: 20.4)),
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
    final gold = ts(AppFonts.inter, 24, w700, AppColors.white, lh: 24);
    return Container(
      decoration: const BoxDecoration(color: AppColors.white, borderRadius: AppRadius.br24),
      clipBehavior: Clip.antiAlias,
      child: Stack(children: [
        Positioned(
          left: 252,
          top: -29,
          child: Container(width: 122, height: 122, decoration: const BoxDecoration(color: AppColors.surfaceAlt, shape: BoxShape.circle)),
        ),
        Positioned(left: 212, top: 16, width: 119, height: 79, child: Image.asset(AppImages.quranStand, fit: BoxFit.cover)),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Daily Recitation Target', style: ts(AppFonts.inter, 16.3, w700, AppColors.green500, lh: 22.8, ls: -0.2)),
            const SizedBox(height: 3.3),
            Text('Keep your habit strong', style: ts(AppFonts.inter, 13, w400, AppColors.textMuted, lh: 19.5)),
            AppGap.v24,
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
                        GradientText('min', style: AppTextStyles.label.c(AppColors.white), gradient: AppColors.goldGradient),
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
                          Text('Target: $target min', style: AppTextStyles.bodyMedium),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.myGoals),
                            child: const AppIcon('button_7844907e', w: 32, h: 32),
                          ),
                        ]),
                      ),
                      AppGap.v10,
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        for (var i = 0; i < 7; i++) _day(days[i], i < today ? 0 : (i == today ? 1 : 2), s.minutesReadToday, target),
                      ]),
                    ]),
                  ),
                ),
              ]),
            ),
            AppGap.v24,
            AppButton(
              label: 'Let\'s Read Now',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.dailyReading),
              leading: const AppIcon('container_2fe1f902', w: 22, h: 16),
              trailing: const AppIcon('margin_bcb7d0ed', w: 24, h: 16),
              gap: 12,
              textStyle: AppTextStyles.bodyMedium.c(AppColors.white),
            ),
          ]),
        ),
      ]),
    );
  }

  /// state: 0 done · 1 today · 2 upcoming
  Widget _day(String label, int state, int minutes, int target) {
    final circle = switch (state) {
      0 => const AppIcon('background_02513878', w: 19.7, h: 19.7),
      1 => Container(
          width: 19.7,
          height: 19.7,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.gold, width: 1.2)),
          alignment: Alignment.center,
          child: GradientText('$minutes', style: ts(AppFonts.inter, 9.8, w700, AppColors.white, lh: 14.8), gradient: AppColors.goldGradient),
        ),
      _ => Container(
          width: 19.7,
          height: 19.7,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.surfaceAlt),
          alignment: Alignment.center,
          child: Text('$target', style: ts(AppFonts.inter, 9.8, w500, AppColors.textMuted, lh: 14.8)),
        ),
    };
    return Column(children: [
      circle,
      const SizedBox(height: 5),
      state == 1
          ? GradientText(label, style: ts(AppFonts.inter, 7.4, w700, AppColors.white, lh: 9.8, ls: 0.4), gradient: AppColors.goldGradient)
          : Text(label, style: ts(AppFonts.inter, 7.4, w500, AppColors.textMuted, lh: 9.8, ls: 0.4)),
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
      borderRadius: AppRadius.br20,
      child: InkWell(
        borderRadius: AppRadius.br20,
        onTap: onTap,
        child: SizedBox(
          height: 179.5,
          child: Padding(
            padding: AppInsets.all20,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const AppIcon('overlay_e67e4c0d', w: 48, h: 48),
              AppGap.v16,
              Text(title, textAlign: TextAlign.center, style: AppTextStyles.title.c(AppColors.textPrimary)),
              const SizedBox(height: 3.5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                  child: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(AppFonts.inter, 9, w500, AppColors.textSecondary, lh: 16, ls: 0.6)),
                ),
                AppGap.h4,
                const AppIcon('container_c7216164', w: 9.3, h: 9.3),
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
          borderRadius: AppRadius.br12,
          onTap: onTap,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            AppIcon(icon, w: 36, h: 36),
            const SizedBox(height: 7.7),
            Text(title, maxLines: 1, textAlign: TextAlign.center, style: ts(AppFonts.inter, 10.3, w500, AppColors.textPrimary, lh: 15.4)),
            Text(sub, textAlign: TextAlign.center, style: ts(AppFonts.inter, 5.8, w500, AppColors.textSecondary, lh: 10.3, ls: 0.4)),
          ]),
        ),
      );
}
