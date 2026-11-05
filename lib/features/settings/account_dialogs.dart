import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/fig_widgets.dart';

Future<void> _modal(BuildContext context, Widget card) => showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'close',
      barrierColor: fc(0x191C1A, .35),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (ctx, a, _) => Center(
        child: ScaleTransition(
          scale: Tween(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: a, curve: Curves.easeOut)),
          child: FadeTransition(opacity: a, child: Material(type: MaterialType.transparency, child: card)),
        ),
      ),
    );

/// 96px icon disc (#f2f4f0) with a faint outer ring, used by both dialogs.
Widget _iconDisc(Widget icon) => SizedBox(
      width: 96,
      height: 96,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(alignment: Alignment.center, decoration: const BoxDecoration(color: AppColors.surfaceAlt, shape: BoxShape.circle), child: icon),
        Positioned(
          left: -4.8,
          top: -4.8,
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: fc(0xBFC9C2, .3))),
          ),
        ),
      ]),
    );

/// Figma: "Log Out Confirmation" (6001:1438) — 364×584 card, r20.
Future<void> showLogoutDialog(BuildContext context) => _modal(
      context,
      Builder(
        builder: (ctx) => Container(
          width: 364,
          height: 584,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: fc(0xE1E3DF, .5)),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.fromLTRB(41, 41, 41, 41),
          child: Column(children: [
            _iconDisc(const FigIcon('container_f7f3a61d', w: 26.7, h: 26.7)),
            const SizedBox(height: 24),
            Text('Are you sure\nyou want to log out?', textAlign: TextAlign.center, style: ts(Ff.inter, 32, w600, AppColors.textPrimary, lh: 40)),
            const SizedBox(height: 12 + 20),
            Text('Your progress and reflections\nwill be saved for your next\nvisit.',
                textAlign: TextAlign.center, style: ts(Ff.inter, 18, w400, AppColors.textSecondary, lh: 28)),
            const Spacer(),
            FigButton(
              label: 'Log Out',
              height: 56,
              textStyle: ts(Ff.inter, 16, w600, Colors.white, lh: 24, ls: 0.4),
              onTap: () => _signOut(ctx),
            ),
            const SizedBox(height: 12),
            FigButton(
              label: 'Stay Signed In',
              height: 58,
              style: FigButtonStyle.outline,
              borderColor: const Color(0xFFD9B46B),
              textStyle: ts(Ff.inter, 16, w600, const Color(0xFF5F4504), lh: 24, ls: 0.4),
              onTap: () => Navigator.pop(ctx),
            ),
          ]),
        ),
      ),
    );

/// Figma: Delete Account dialog (6001:1460) — 350×548 card, pad 40.
Future<void> showDeleteAccountDialog(BuildContext context) => _modal(
      context,
      Builder(
        builder: (ctx) {
          final btn = ts(Ff.inter, 12, w500, Colors.white, lh: 16, ls: 0.6);
          return Container(
            width: 350,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              _iconDisc(const FigIcon('icon_88155548', w: 21.3, h: 24)),
              const SizedBox(height: 24),
              Text('Delete Account?', style: ts(Ff.inter, 20, w700, AppColors.textPrimary, lh: 28, ls: -0.2)),
              const SizedBox(height: 12),
              Text(
                'Are you sure you want to delete\nyour account? This action is\npermanent and will erase all your\nreading progress, bookmarks, and\nreflections. This cannot be\nundone.',
                textAlign: TextAlign.center,
                style: ts(Ff.inter, 16, w400, AppColors.textSecondary, lh: 24),
              ),
              const SizedBox(height: 40),
              _pill('DELETE MY ACCOUNT', btn, fill: AppColors.error, onTap: () => _signOut(ctx)),
              const SizedBox(height: 12),
              _pill('KEEP MY ACCOUNT', btn.copyWith(color: AppColors.green800), border: AppColors.green800, onTap: () => Navigator.pop(ctx)),
            ]),
          );
        },
      ),
    );

Widget _pill(String label, TextStyle style, {Color? fill, Color? border, required VoidCallback onTap}) => Material(
      color: fill ?? Colors.transparent,
      shape: StadiumBorder(side: border == null ? BorderSide.none : BorderSide(color: border)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: SizedBox(height: 56, width: double.infinity, child: Center(child: Text(label, style: style))),
      ),
    );

void _signOut(BuildContext ctx) {
  AppState.instance.update(() => AppState.instance.loggedIn = false);
  mainTabIndex.value = 0;
  Navigator.of(ctx).pushNamedAndRemoveUntil(AppRoutes.welcome, (_) => false);
}
