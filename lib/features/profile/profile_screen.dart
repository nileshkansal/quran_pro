import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../settings/account_dialogs.dart';
import '../../core/theme/theme.dart';
import '../../core/utils/formatters.dart';
import '../../widgets/widgets.dart';

/// Figma: "Profile / Account" (6001:4610). Per the client brief, progress is
/// shown directly on Profile — there are no separate My Progress /
/// Achievements pages.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;
    return ColoredBox(
      color: AppColors.surface,
      child: ListenableBuilder(
        listenable: s,
        builder: (context, _) => Column(children: [
          // Header: 64px, "Profile" + settings gear.
          Container(
            color: AppColors.surface.o(.8),
            padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top, 24, 0),
            height: 64 + MediaQuery.of(context).padding.top,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Profile', style: AppTextStyles.title),
              GestureDetector(onTap: () => mainTabIndex.value = 2, child: const AppIcon('button_b1b2cf4f', w: 20.1, h: 26)),
            ]),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              children: [
                GlassCard(
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.all(19),
                    child: Row(children: [
                      _Avatar(initials: Formatters.initials(s.fullName)),
                      AppGap.h15,
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(s.fullName, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.title),
                          AppGap.v4,
                          Text(s.email, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.body),
                          AppGap.v12,
                          _MintPill(
                            icon: 'codicon_edit_ed26c413',
                            iconSize: 12,
                            label: 'Edit Profile',
                            style: AppTextStyles.label.c(AppColors.green73),
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.editProfile),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                ),
                AppGap.v15,
                GlassCard(
                  child: Column(children: [
                    const CardHeader(icon: 'overlay_d9a1e0fb', title: 'My Quran Journey'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 13),
                      child: Row(children: [
                        GoldRing(
                          progress: 0.2,
                          size: 92,
                          trackWidth: 5.8,
                          arcWidth: 5.8,
                          trackColor: AppColors.grey15,
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Text('20%', style: ts(AppFonts.inter, 17.3, w700, AppColors.green500, lh: 17.3)),
                            Text('Completed', style: ts(AppFonts.inter, 8.6, w500, AppColors.green500, lh: 11.5, ls: 0.4)),
                          ]),
                        ),
                        const SizedBox(width: 22),
                        _stat('akar_icons_book_9b10e4aa', '24', 'Surahs Completed', 83),
                        const SizedBox(width: 22),
                        _stat('ant_design_history_outlined_d0c08d26', '12h 30m', 'Time Spent Reading', 90),
                      ]),
                    ),
                  ]),
                ),
                AppGap.v15,
                GlassCard(
                  child: Column(children: [
                    const CardHeader(icon: 'overlay_d9a1e0fb', title: 'My Quran Journey'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 14, 8, 7),
                      child: Column(children: [
                        _targetRow('Current Target', '${s.sectionsPerDay} sections per day', filled: true),
                        AppGap.v8,
                        _targetRow(
                          'Estimated Completion',
                          'Dec 2027',
                          trailing: _MintPill(
                            icon: 'codicon_edit_3e79e9c1',
                            iconSize: 15.1,
                            label: 'Update Target',
                            height: 27.3,
                            style: ts(AppFonts.inter, 11.3, w700, AppColors.green73, lh: 15.1),
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.myGoals),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
                AppGap.v15,
                GlassCard(
                  child: Column(children: [
                    const CardHeader(icon: 'overlay_d9a1e0fb', title: 'My Quran Journey'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 14, 8, 14),
                      child: Container(
                        height: 65,
                        decoration: const BoxDecoration(color: AppColors.grey07, borderRadius: AppRadius.br8),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          _streak('${s.streakDays} Days', 'Current Streak'),
                          const SizedBox(width: 21),
                          Container(width: 1, height: 17, color: AppColors.green800),
                          const SizedBox(width: 21),
                          _streak('45 Days', 'Longest Streak'),
                        ]),
                      ),
                    ),
                  ]),
                ),
                AppGap.v15,
                GlassCard(
                  radius: 20,
                  child: InkWell(
                    onTap: () => showLogoutDialog(context),
                    child: Container(
                      height: 56,
                      color: AppColors.white.o(.5),
                      padding: AppInsets.h16,
                      child: Row(children: [
                        const AppIcon('overlay_f7db4cd4', w: 32, h: 32),
                        AppGap.h12,
                        Expanded(child: Text('Sign out', style: ts(AppFonts.inter, 16, w700, AppColors.green800, lh: 28, ls: -0.2))),
                        const AppIcon('container_b38512cd', w: 7.4, h: 12),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _stat(String icon, String value, String label, double width) => SizedBox(
        width: width,
        child: Column(children: [
          AppIcon(icon, w: 24, h: 24),
          const SizedBox(height: 9),
          Text(value, style: ts(AppFonts.inter, 16, w700, AppColors.green500, lh: 17.3)),
          const SizedBox(height: 5),
          Text(label, maxLines: 1, style: ts(AppFonts.inter, 8.6, w500, AppColors.green500, lh: 11.5, ls: 0.4)),
        ]),
      );

  Widget _targetRow(String label, String value, {bool filled = false, Widget? trailing}) => Container(
        height: 56,
        padding: AppInsets.all8,
        decoration: BoxDecoration(color: filled ? AppColors.grey07 : null, borderRadius: AppRadius.br8),
        child: Row(children: [
          const AppIcon('container_2eaa8fe3', w: 20, h: 20),
          AppGap.h16,
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(label, style: AppTextStyles.label),
              Text(value, style: AppTextStyles.bodyMedium),
            ]),
          ),
          if (trailing != null) trailing,
        ]),
      );

  Widget _streak(String value, String label) => SizedBox(
        width: 101,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(value, textAlign: TextAlign.center, style: AppTextStyles.bodySemibold),
          Text(label, textAlign: TextAlign.center, style: AppTextStyles.caption),
        ]),
      );
}

class _MintPill extends StatelessWidget {
  const _MintPill({required this.icon, required this.iconSize, required this.label, required this.style, required this.onTap, this.height = 24});
  final String icon;
  final double iconSize;
  final String label;
  final TextStyle style;
  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(color: AppColors.green20, borderRadius: AppRadius.pill),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            AppIcon(icon, w: iconSize, h: iconSize),
            AppGap.h4,
            Text(label, style: style),
          ]),
        ),
      );
}

/// 82px avatar: gold ring, 74.8px gold disc with initials, edit badge.
class _Avatar extends StatelessWidget {
  const _Avatar({required this.initials});
  final String initials;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 82,
        height: 82,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.gold)),
          ),
          Positioned(
            left: 3.6,
            top: 3.6,
            child: Container(
              width: 74.8,
              height: 74.8,
              alignment: Alignment.center,
              decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppColors.goldGradient),
              child: Text(initials, style: ts(AppFonts.inter, 26.4, w500, AppColors.white, lh: 39.6)),
            ),
          ),
          Positioned(
            left: 58.8,
            top: 58.8,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.editProfile),
              child: const AppIcon('frame_2085667917_632cfb86', w: 18.6, h: 18.6),
            ),
          ),
        ]),
      );
}
