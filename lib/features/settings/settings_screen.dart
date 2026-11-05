import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/common.dart';
import '../home/prayer_sheets.dart';
import 'account_dialogs.dart';

/// Figma: "Settings" (6001:1088).
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;
    void go(String r, [Object? a]) => Navigator.of(context).pushNamed(r, arguments: a);
    final top = MediaQuery.of(context).padding.top;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF8FAF6), Colors.white]),
      ),
      child: Stack(children: [
        // Ambient warm glow (600px #ffdea3 @10%, blur 120).
        Positioned(
          left: -78,
          top: 312,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(width: 600, height: 600, decoration: BoxDecoration(color: fc(0xFFDEA3, .1), shape: BoxShape.circle)),
          ),
        ),
        ListenableBuilder(
          listenable: s,
          builder: (context, _) => Column(children: [
            SizedBox(
              height: 64 + top,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, top + 8, 24, 8),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  GestureDetector(onTap: () => mainTabIndex.value = 0, child: const FigIcon('button_b6fd047e', w: 16, h: 16)),
                  Text('QuranPro', style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
                  GestureDetector(onTap: () => showComingSoon(context, 'Search settings'), child: const FigIcon('button_search_dfbd8d53', w: 34, h: 40)),
                ]),
              ),
            ),
            const SizedBox(height: 17),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                children: [
                  Text('Settings', style: ts(Ff.inter, 20, w700, AppColors.textPrimary, lh: 28, ls: -0.2)),
                  const SizedBox(height: 8),
                  Text('Customize your reading experience and\napplication preferences.', style: ts(Ff.inter, 16, w400, AppColors.textSecondary, lh: 24)),
                  const SizedBox(height: 10),
                  _Section(icon: 'overlay_92729e5e', title: 'Reading', children: [
                    _Row(icon: 'fluent_text_case_title_16_fi_9fdf4380', label: 'Reading Preferences', onTap: () => go(AppRoutes.readingSettings)),
                    _Row(icon: 'fluent_headphones_sound_wave_b4b13b23', label: 'Audio & Recitation', onTap: () => go(AppRoutes.audioRecitation)),
                  ]),
                  _Section(icon: 'overlay_4f715626', title: 'Prayer & Qibla', children: [
                    _Row(icon: 'ant_design_history_outlined_a18220bf', label: 'Prayer Times', onTap: () => showPrayerTimesSheet(context)),
                    _Row(icon: 'ant_design_compass_outlined_02e88191', label: 'Qibla Settings', onTap: () => showQiblaSheet(context)),
                  ]),
                  _Section(icon: 'overlay_5ebc4f8a', title: 'Notifications', gap: 16, children: [
                    _Toggle(
                      icon: 'container_6d0882be',
                      iconW: 21.3,
                      iconH: 19.6,
                      label: 'Daily Reminder',
                      sub: 'Read a verse every day',
                      value: s.dailyReminder,
                      onChanged: (v) => s.update(() => s.dailyReminder = v),
                    ),
                    _Toggle(
                      icon: 'container_80e86661',
                      iconW: 24,
                      iconH: 20,
                      label: 'Prayer Notifications',
                      sub: 'Alerts for 5 daily prayers',
                      value: s.prayerNotifications,
                      onChanged: (v) => s.update(() => s.prayerNotifications = v),
                    ),
                  ]),
                  _Section(icon: 'overlay_30853dab', title: 'Language', children: [
                    _Row(icon: 'ant_design_global_outlined_995bffbd', label: 'App Language', onTap: () => go(AppRoutes.selectLanguage, true)),
                    _Row(icon: 'famicons_language_sharp_18680c93', label: 'Quran Translation Language', onTap: () => go(AppRoutes.readingSettings)),
                  ]),
                  _Section(icon: 'overlay_06e86f92', title: 'Privacy & Data', children: [
                    _Row(icon: 'griddy_icons_lock_alt_02_b32273ae', label: 'Permissions', onTap: () => showChooseLocationSheet(context)),
                    _Row(icon: 'ph_note_cb2bde72', label: 'Manage Data', onTap: () => showComingSoon(context, 'Manage Data')),
                    _Row(icon: 'griddy_icons_lock_alt_02_1e45d38d', label: 'Privacy Policy', onTap: () => go(AppRoutes.privacy)),
                    _Row(icon: 'flowbite_clipboard_list_outl_c90a759e', label: 'Terms & Condition', onTap: () => go(AppRoutes.terms)),
                  ]),
                  _Section(icon: 'overlay_bc0e7917', title: 'About QuranPro', onHeaderTap: () => go(AppRoutes.helpAbout), children: const []),
                  const SizedBox(height: 7),
                  Center(
                    child: Material(
                      color: AppColors.surfaceDim,
                      shape: const StadiumBorder(),
                      child: InkWell(
                        customBorder: const StadiumBorder(),
                        onTap: () => showDeleteAccountDialog(context),
                        child: SizedBox(
                          width: 226.4,
                          height: 42,
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            const FigIcon('container_c788a778', w: 16, h: 18),
                            const SizedBox(width: 8),
                            Text('DELETE ACCOUNT DATA', style: ts(Ff.inter, 12, w500, AppColors.error, lh: 16, ls: 0.6)),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }

}

/// Glass section: white @70%, r12, 57px tinted header (#f2f4f0 @50%).
class _Section extends StatelessWidget {
  const _Section({required this.icon, required this.title, required this.children, this.gap = 8, this.onHeaderTap});
  final String icon;
  final String title;
  final List<Widget> children;
  final double gap;
  final VoidCallback? onHeaderTap;

  @override
  Widget build(BuildContext context) {
    final header = Container(
      height: children.isEmpty ? 56 : 57,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: fc(0xF2F4F0, .5),
        border: children.isEmpty ? null : const Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(children: [
        FigIcon(icon, w: 32, h: 32),
        const SizedBox(width: 12),
        Text(title, style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
      ]),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: fc(0xFFFFFF, .7),
            border: Border.all(color: fc(0xFFFFFF, .5)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Column(children: [
              onHeaderTap == null ? header : InkWell(onTap: onHeaderTap, child: header),
              if (children.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    for (var i = 0; i < children.length; i++) ...[if (i > 0) SizedBox(height: gap), children[i]],
                  ]),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.label, required this.onTap});
  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              FigIcon(icon, w: 20, h: 20),
              const SizedBox(width: 16),
              Expanded(child: Text(label, style: ts(Ff.inter, 16, w500, AppColors.textPrimary, lh: 24))),
              const FigIcon('container_b38512cd', w: 7.4, h: 12),
            ]),
          ),
        ),
      );
}

class _Toggle extends StatelessWidget {
  const _Toggle({
    required this.icon,
    required this.iconW,
    required this.iconH,
    required this.label,
    required this.sub,
    required this.value,
    required this.onChanged,
  });
  final String icon;
  final double iconW;
  final double iconH;
  final String label;
  final String sub;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 56,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            SizedBox(width: 24, child: FigIcon(icon, w: iconW, h: iconH)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(label, style: ts(Ff.inter, 16, w500, AppColors.textPrimary, lh: 24)),
                Text(sub, style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16, ls: 0.6)),
              ]),
            ),
            FigSwitch(value: value, onChanged: onChanged),
          ]),
        ),
      );
}

/// Figma toggle: 44×24 track (#176b4d on / #e1e3df off), 20px white knob.
class FigSwitch extends StatelessWidget {
  const FigSwitch({super.key, required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 44,
          height: 24,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(color: value ? AppColors.green500 : AppColors.divider, borderRadius: BorderRadius.circular(9999)),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: value ? Colors.white : const Color(0xFFD1D5DB)),
              ),
            ),
          ),
        ),
      );
}
