import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/fig_widgets.dart';
import '../settings/account_dialogs.dart';

/// Figma: "Profile / Account" (6001:4610). Per the client brief, progress is
/// shown directly on Profile — there are no separate My Progress /
/// Achievements pages.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;
    return ColoredBox(
      color: const Color(0xFFF8FAF6),
      child: ListenableBuilder(
        listenable: s,
        builder: (context, _) => Column(children: [
          // Header: 64px, "Profile" + settings gear.
          Container(
            color: fc(0xF8FAF6, .8),
            padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top, 24, 0),
            height: 64 + MediaQuery.of(context).padding.top,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Profile', style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
              GestureDetector(onTap: () => mainTabIndex.value = 2, child: const FigIcon('button_b1b2cf4f', w: 20.1, h: 26)),
            ]),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              children: [
                _GlassCard(
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.all(19),
                    child: Row(children: [
                      _Avatar(initials: _initials(s.fullName)),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(s.fullName, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
                          const SizedBox(height: 4),
                          Text(s.email, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(Ff.inter, 16, w400, AppColors.textSecondary, lh: 24)),
                          const SizedBox(height: 12),
                          _MintPill(
                            icon: 'codicon_edit_ed26c413',
                            iconSize: 12,
                            label: 'Edit Profile',
                            style: ts(Ff.inter, 12, w500, const Color(0xFF207153), lh: 16, ls: 0.6),
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.editProfile),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 15),
                _GlassCard(
                  child: Column(children: [
                    const _CardHeader('My Quran Journey'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 13),
                      child: Row(children: [
                        GoldRing(
                          progress: 0.2,
                          size: 92,
                          trackWidth: 5.8,
                          arcWidth: 5.8,
                          trackColor: const Color(0xFFDCDCD6),
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Text('20%', style: ts(Ff.inter, 17.3, w700, AppColors.green500, lh: 17.3)),
                            Text('Completed', style: ts(Ff.inter, 8.6, w500, AppColors.green500, lh: 11.5, ls: 0.4)),
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
                const SizedBox(height: 15),
                _GlassCard(
                  child: Column(children: [
                    const _CardHeader('My Quran Journey'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 14, 8, 7),
                      child: Column(children: [
                        _targetRow('Current Target', '${s.sectionsPerDay} sections per day', filled: true),
                        const SizedBox(height: 8),
                        _targetRow(
                          'Estimated Completion',
                          'Dec 2027',
                          trailing: _MintPill(
                            icon: 'codicon_edit_3e79e9c1',
                            iconSize: 15.1,
                            label: 'Update Target',
                            height: 27.3,
                            style: ts(Ff.inter, 11.3, w700, const Color(0xFF207153), lh: 15.1),
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.myGoals),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
                const SizedBox(height: 15),
                _GlassCard(
                  child: Column(children: [
                    const _CardHeader('My Quran Journey'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 14, 8, 14),
                      child: Container(
                        height: 65,
                        decoration: BoxDecoration(color: const Color(0xFFF1F6EC), borderRadius: BorderRadius.circular(8)),
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
                const SizedBox(height: 15),
                _GlassCard(
                  radius: 20,
                  child: InkWell(
                    onTap: () => showLogoutDialog(context),
                    child: Container(
                      height: 56,
                      color: fc(0xFFFFFF, .5),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        const FigIcon('overlay_f7db4cd4', w: 32, h: 32),
                        const SizedBox(width: 12),
                        Expanded(child: Text('Sign out', style: ts(Ff.inter, 16, w700, AppColors.green800, lh: 28, ls: -0.2))),
                        const FigIcon('container_b38512cd', w: 7.4, h: 12),
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

  static String _initials(String name) {
    final p = name.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
    if (p.isEmpty) return '';
    return (p.first[0] + (p.length > 1 ? p.last[0] : '')).toUpperCase();
  }

  Widget _stat(String icon, String value, String label, double width) => SizedBox(
        width: width,
        child: Column(children: [
          FigIcon(icon, w: 24, h: 24),
          const SizedBox(height: 9),
          Text(value, style: ts(Ff.inter, 16, w700, AppColors.green500, lh: 17.3)),
          const SizedBox(height: 5),
          Text(label, maxLines: 1, style: ts(Ff.inter, 8.6, w500, AppColors.green500, lh: 11.5, ls: 0.4)),
        ]),
      );

  Widget _targetRow(String label, String value, {bool filled = false, Widget? trailing}) => Container(
        height: 56,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: filled ? const Color(0xFFF1F6EC) : null, borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          const FigIcon('container_2eaa8fe3', w: 20, h: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(label, style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16, ls: 0.6)),
              Text(value, style: ts(Ff.inter, 16, w500, AppColors.textPrimary, lh: 24)),
            ]),
          ),
          if (trailing != null) trailing,
        ]),
      );

  Widget _streak(String value, String label) => SizedBox(
        width: 101,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(value, textAlign: TextAlign.center, style: ts(Ff.inter, 16, w600, AppColors.textPrimary, lh: 24)),
          Text(label, textAlign: TextAlign.center, style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16)),
        ]),
      );
}

/// Frosted card: white @70%, 1px white @50% border, r20, 10px backdrop blur.
class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child, this.height, this.radius = 20});
  final Widget child;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: fc(0xFFFFFF, .7),
              border: Border.all(color: fc(0xFFFFFF, .5)),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Material(type: MaterialType.transparency, child: child),
          ),
        ),
      );
}

/// 57px card header: white @50%, bottom rule #e1e3df, 32px icon + Inter Bold 20.
class _CardHeader extends StatelessWidget {
  const _CardHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) => Container(
        height: 57,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: fc(0xFFFFFF, .5), border: const Border(bottom: BorderSide(color: AppColors.divider))),
        child: Row(children: [
          const FigIcon('overlay_d9a1e0fb', w: 32, h: 32),
          const SizedBox(width: 12),
          Text(title, style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
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
          decoration: BoxDecoration(color: const Color(0xFFA4F3CC), borderRadius: BorderRadius.circular(9999)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            FigIcon(icon, w: iconSize, h: iconSize),
            const SizedBox(width: 4),
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
              child: Text(initials, style: ts(Ff.inter, 26.4, w500, Colors.white, lh: 39.6)),
            ),
          ),
          Positioned(
            left: 58.8,
            top: 58.8,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.editProfile),
              child: const FigIcon('frame_2085667917_632cfb86', w: 18.6, h: 18.6),
            ),
          ),
        ]),
      );
}
