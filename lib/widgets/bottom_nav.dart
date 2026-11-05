import 'package:flutter/material.dart';

import '../core/theme/theme.dart';
import 'app_icon.dart';

/// Shared tab index so nested screens can switch the root tab.
final ValueNotifier<int> mainTabIndex = ValueNotifier<int>(0);

/// Figma "BottomNavBar": 390×78, #fff8f3, top radius 12, row gap 45,
/// items Home · Feedback · Setting · Profile (Inter 10/15).
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.index, required this.onTap});
  final int index;
  final ValueChanged<int> onTap;

  static void goToTab(BuildContext context, int i) {
    mainTabIndex.value = i;
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  // (label, inactive icon, active icon, icon w, icon h)
  static const _items = [
    ('Home', 'margin_dd364dd0', 'margin_c308f576', 48.0, 32.0),
    ('Feedback', 'margin_a346cfc1', 'margin_a346cfc1', 52.0, 34.0),
    ('Setting', 'margin_770e1309', 'margin_770e1309', 52.0, 34.0),
    ('Profile', 'margin_d49f093c', 'margin_4c58cc00', 48.0, 30.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: SizedBox(
        height: 78,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < _items.length; i++) ...[
                if (i > 0) const SizedBox(width: 45),
                _item(i),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(int i) {
    final (label, icon, activeIcon, w, h) = _items[i];
    final active = i == index;
    final style = active
        ? ts(AppFonts.inter, 10, w700, i == 0 ? AppColors.white : AppColors.green700, lh: 15)
        : ts(AppFonts.inter, 10, w400, AppColors.textSecondary, lh: 15);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(i),
      child: SizedBox(
        width: w,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // The exported "margin" frames already include the 4px gap under the icon.
          AppIcon(active ? activeIcon : icon, w: w, h: h),
          active && i == 0
              ? GradientText(label, style: style, gradient: AppColors.goldGradient)
              : Text(label, style: style),
        ]),
      ),
    );
  }
}

/// Bottom bar for pushed screens; taps return to the shell on that tab.
class PushedBottomNav extends StatelessWidget {
  const PushedBottomNav({super.key, this.index = 0});
  final int index;

  @override
  Widget build(BuildContext context) => AppBottomNav(index: index, onTap: (i) => AppBottomNav.goToTab(context, i));
}
