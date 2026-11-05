import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Daily Recitation Time" (6001:2438) — 390×1082 canvas.
class DailyRecitationScreen extends StatefulWidget {
  const DailyRecitationScreen({super.key});

  @override
  State<DailyRecitationScreen> createState() => _DailyRecitationScreenState();
}

class _DailyRecitationScreenState extends State<DailyRecitationScreen> {
  final s = AppState.instance;

  void _set(int m) => setState(() => s.update(() => s.dailyMinutes = m.clamp(1, 120)));

  @override
  Widget build(BuildContext context) {
    final m = s.dailyMinutes;
    const stroke = AppColors.gold08;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: DesignCanvas(
        designHeight: 1082,
        background: AppColors.background,
        children: [
          Positioned(top: 0, left: -1, right: -1, height: 287, child: Image.asset(AppImages.bgHeader, fit: BoxFit.cover)),
          Positioned(top: MediaQuery.of(context).padding.top + 4, left: 8, child: const ArrowBackButton()),
          Positioned(
            top: 128,
            left: 20,
            right: 19,
            child: Column(children: [
              const Logo.small(width: 103.6),
              const SizedBox(height: 45),
              SizedBox(
                width: 323,
                child: Text('Set Your Daily Recitation Time',
                    textAlign: TextAlign.center, style: ts(AppFonts.poppins, 18, w600, AppColors.textPrimary, lh: 39)),
              ),
              AppGap.v10,
              Text('We’ll show you your daily target and completion plan',
                  textAlign: TextAlign.center, style: ts(AppFonts.poppins, 11, w500, AppColors.textSecondary, lh: 24)),
              const SizedBox(height: 30 + 16),
              // Stepper: 48 · 32 · ring 128 · 32 · 48
              SizedBox(
                height: 128,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(onTap: () => _set(m - 1), child: const AppIcon('button_1fa2b729', w: 48, h: 48)),
                  const SizedBox(width: 32),
                  GoldRing(
                    progress: (m / 20).clamp(0.0, 1.0),
                    size: 128,
                    trackWidth: 5.1,
                    arcWidth: 7.7,
                    inset: 2.5,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(m.toString().padLeft(2, '0'), style: ts(AppFonts.amiri, 34, w400, AppColors.green800, lh: 27)),
                      Text('min', style: ts(AppFonts.inter, 12, w700, AppColors.textMuted, lh: 16, ls: 0.6)),
                    ]),
                  ),
                  const SizedBox(width: 32),
                  GestureDetector(onTap: () => _set(m + 1), child: const AppIcon('button_3acc3c56', w: 48, h: 48)),
                ]),
              ),
              const SizedBox(height: 16 + 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                for (final v in const [5, 10, 15, 20])
                  GestureDetector(
                    onTap: () => _set(v),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 76,
                      height: 39,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: m == v ? AppColors.goldGradient : null,
                        color: m == v ? null : stroke,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: m == v
                          ? Text('$v Min', style: ts(AppFonts.inter, 12.6, w700, AppColors.white, lh: 18.8))
                          : GradientText('$v Min', style: ts(AppFonts.inter, 12.6, w700, AppColors.white, lh: 18.8), gradient: AppColors.goldGradient),
                    ),
                  ),
              ]),
              AppGap.v30,
              Container(
                padding: const EdgeInsets.all(18.3),
                decoration: BoxDecoration(border: Border.all(color: stroke, width: 0.9), borderRadius: BorderRadius.circular(18.3)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Your plan', style: ts(AppFonts.poppins, 16.3, w600, AppColors.textPrimary, lh: 25.6, ls: -0.2)),
                  const SizedBox(height: 11),
                  _planRow('background_74c705c6', 'Daily target', '${s.sectionsPerDay} sections per day'),
                  const SizedBox(height: 14.6),
                  Container(height: 0.9, color: stroke),
                  const SizedBox(height: 14.6),
                  _planRow('background_c60b198a', 'To complete the whole Quran', '${s.daysToComplete} days'),
                  const SizedBox(height: 14.6),
                  Container(height: 0.9, color: stroke),
                  const SizedBox(height: 14.6),
                  _planRow('background_135f84e6', null, '${s.monthsToComplete} months'),
                ]),
              ),
              AppGap.v30,
              Container(
                height: 77,
                decoration: BoxDecoration(color: AppColors.gold08, borderRadius: BorderRadius.circular(14)),
                clipBehavior: Clip.antiAlias,
                child: Stack(children: [
                  Positioned(left: 253, top: 12, width: 98, height: 65, child: Image.asset(AppImages.mosqueCrescent, fit: BoxFit.cover)),
                  Positioned(
                    left: 10,
                    top: 10,
                    width: 259,
                    height: 58,
                    child: Row(children: [
                      const AppIcon('favourite_circle_0365a659', w: 44, h: 44),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('Consistency is the key.', style: ts(AppFonts.inter, 14, w600, AppColors.textPrimary, lh: 15)),
                          const SizedBox(height: 5),
                          Text('Allah loves small deeds done consistently more than big deeds done occasionally.\nKeep going, for the sake of allah.',
                              style: ts(AppFonts.poppins, 9, w400, AppColors.textSecondary, lh: 13)),
                        ]),
                      ),
                    ]),
                  ),
                ]),
              ),
              AppGap.v30,
              AppButton(
                label: 'Continue',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.notifications),
                trailing: AppButton.arrowWhite,
                textStyle: ts(AppFonts.inter, 16, w700, AppColors.white, lh: 28, ls: -0.2),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _planRow(String icon, String? label, String value) => SizedBox(
        height: 43,
        child: Row(children: [
          AppIcon(icon, w: 43, h: 43),
          AppGap.h10,
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            if (label != null) ...[
              Text(label, style: ts(AppFonts.inter, 13, w700, AppColors.textSecondary, lh: 16)),
              const SizedBox(height: 5),
            ],
            Text(value, style: ts(AppFonts.inter, 14, w600, AppColors.textPrimary, lh: 15)),
          ]),
        ]),
      );
}
