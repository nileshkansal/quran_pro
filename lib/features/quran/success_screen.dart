import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Success Screen" (6001:6971). Tap anywhere (or wait) to return Home.
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  static const _ink = AppColors.green85;

  void _home(BuildContext context) {
    final s = AppState.instance;
    s.update(() => s.minutesReadToday = 20);
    AppBottomNav.goToTab(context, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gold11,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _home(context),
        child: DesignCanvas(
          background: AppColors.gold11,
          children: [
            Positioned.fill(child: Image.asset(AppImages.successBg, fit: BoxFit.fill)),
            Positioned(
              top: 465,
              left: 27,
              right: 28,
              child: Column(children: [
                const SizedBox(height: 3.8),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.7, end: 1),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.elasticOut,
                  builder: (_, v, child) => Transform.scale(scale: v, child: child),
                  child: Text('You Did It!', style: ts(AppFonts.inter, 40, w700, _ink, lh: 37.7, ls: -0.8)),
                ),
                const SizedBox(height: 3.4 + 6),
                Text('You completed today’s Qur’an goal.', style: ts(AppFonts.inter, 14.2, w500, AppColors.slateGray600, lh: 21.2)),
                const SizedBox(height: 9.2),
                Opacity(
                  opacity: 0.6,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(width: 69.9, height: 1.1, color: AppColors.goldSoft),
                    const AppIcon('margin_f99a0634', w: 29.9, h: 12),
                    Container(width: 69.9, height: 1.1, color: AppColors.goldSoft),
                  ]),
                ),
                const SizedBox(height: 11.3 + 3.8 + 3.8),
                _card(
                  fill: AppColors.gold09,
                  icon: 'frame_2085667896_00b3bd5b',
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text('Small steps every day', style: ts(AppFonts.inter, 14.2, w700, _ink, lh: 19.5)),
                    const SizedBox(height: 1),
                    Text('lead to a lasting connection with the\nQur’an.', style: ts(AppFonts.jakarta, 12.3, w400, AppColors.gray700, lh: 16.9)),
                  ]),
                ),
                const SizedBox(height: 11.3),
                _card(
                  fill: AppColors.gold09,
                  icon: 'frame_2085667896_bd4f831a',
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text('VERSES READ', style: ts(AppFonts.inter, 9.2, w600, AppColors.gray500, lh: 17)),
                    const SizedBox(height: 3.3),
                    Text('12', style: ts(AppFonts.inter, 17.2, w700, _ink, lh: 17)),
                  ]),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({required Color fill, required String icon, required Widget child}) => Container(
        height: 87.2,
        padding: const EdgeInsets.all(15.1),
        decoration: BoxDecoration(
          color: fill,
          border: Border.all(color: AppColors.gold19, width: 1.1),
          borderRadius: BorderRadius.circular(20.8),
        ),
        child: Row(children: [
          AppIcon(icon, w: 50.5, h: 50.5),
          const SizedBox(width: 13.2),
          Expanded(child: child),
        ]),
      );
}
