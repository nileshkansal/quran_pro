import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../home/prayer_sheets.dart';
import 'account_dialogs.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

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
        gradient: AppColors.pageGradient,
      ),
      child: Stack(children: [
        // Ambient warm glow (600px #ffdea3 @10%, blur 120).
        Positioned(
          left: -78,
          top: 312,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(width: 600, height: 600, decoration: BoxDecoration(color: AppColors.gold18.o(.1), shape: BoxShape.circle)),
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
                  GestureDetector(onTap: () => mainTabIndex.value = 0, child: const AppIcon('button_b6fd047e', w: 16, h: 16)),
                  Text('QuranPro', style: AppTextStyles.title),
                  GestureDetector(onTap: () => showComingSoon(context, 'Search settings'), child: const AppIcon('button_search_dfbd8d53', w: 34, h: 40)),
                ]),
              ),
            ),
            const SizedBox(height: 17),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                children: [
                  Text('Settings', style: AppTextStyles.title.c(AppColors.textPrimary)),
                  AppGap.v8,
                  Text('Customize your reading experience and\napplication preferences.', style: AppTextStyles.body),
                  AppGap.v10,
                  _Section(icon: 'overlay_92729e5e', title: 'Reading', children: [
                    AppListRow(icon: 'fluent_text_case_title_16_fi_9fdf4380', label: 'Reading Preferences', onTap: () => go(AppRoutes.readingSettings)),
                    AppListRow(icon: 'fluent_headphones_sound_wave_b4b13b23', label: 'Audio & Recitation', onTap: () => go(AppRoutes.audioRecitation)),
                  ]),
                  _Section(icon: 'overlay_4f715626', title: 'Prayer & Qibla', children: [
                    AppListRow(icon: 'ant_design_history_outlined_a18220bf', label: 'Prayer Times', onTap: () => showPrayerTimesSheet(context)),
                    AppListRow(icon: 'ant_design_compass_outlined_02e88191', label: 'Qibla Settings', onTap: () => showQiblaSheet(context)),
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
                    AppListRow(icon: 'ant_design_global_outlined_995bffbd', label: 'App Language', onTap: () => go(AppRoutes.selectLanguage, true)),
                    AppListRow(icon: 'famicons_language_sharp_18680c93', label: 'Quran Translation Language', onTap: () => go(AppRoutes.readingSettings)),
                  ]),
                  _Section(icon: 'overlay_06e86f92', title: 'Privacy & Data', children: [
                    AppListRow(icon: 'griddy_icons_lock_alt_02_b32273ae', label: 'Permissions', onTap: () => showChooseLocationSheet(context)),
                    AppListRow(icon: 'ph_note_cb2bde72', label: 'Manage Data', onTap: () => showComingSoon(context, 'Manage Data')),
                    AppListRow(icon: 'griddy_icons_lock_alt_02_1e45d38d', label: 'Privacy Policy', onTap: () => go(AppRoutes.privacy)),
                    AppListRow(icon: 'flowbite_clipboard_list_outl_c90a759e', label: 'Terms & Condition', onTap: () => go(AppRoutes.terms)),
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
                            const AppIcon('container_c788a778', w: 16, h: 18),
                            AppGap.h8,
                            Text('DELETE ACCOUNT DATA', style: AppTextStyles.label.c(AppColors.error)),
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

/// Glass section: [GlassCard] (r12, no blur) + tinted [CardHeader] + rows.
class _Section extends StatelessWidget {
  const _Section({required this.icon, required this.title, required this.children, this.gap = AppSpacing.sm, this.onHeaderTap});
  final String icon;
  final String title;
  final List<Widget> children;
  final double gap;
  final VoidCallback? onHeaderTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: AppSpacing.s10),
        child: GlassCard(
          radius: AppRadius.r12,
          blur: 0,
          child: Column(children: [
            CardHeader(
              icon: icon,
              title: title,
              background: AppColors.surfaceAlt.o(.5),
              showDivider: children.isNotEmpty,
              onTap: onHeaderTap,
            ),
            if (children.isNotEmpty)
              Padding(
                padding: AppInsets.all8,
                child: Column(children: [
                  for (var i = 0; i < children.length; i++) ...[if (i > 0) SizedBox(height: gap), children[i]],
                ]),
              ),
          ]),
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
          padding: AppInsets.all8,
          child: Row(children: [
            SizedBox(width: 24, child: AppIcon(icon, w: iconW, h: iconH)),
            AppGap.h16,
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(label, style: AppTextStyles.bodyMedium),
                Text(sub, style: AppTextStyles.label),
              ]),
            ),
            AppSwitch(value: value, onChanged: onChanged),
          ]),
        ),
      );
}
