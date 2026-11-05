import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/utils/formatters.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "My Goals" / My Reading Plan (6031:310).
class MyGoalsScreen extends StatefulWidget {
  const MyGoalsScreen({super.key});

  @override
  State<MyGoalsScreen> createState() => _MyGoalsScreenState();
}

class _MyGoalsScreenState extends State<MyGoalsScreen> {
  final s = AppState.instance;
  bool _catchUp = true;
  bool _paused = false;

  static const _ink = AppColors.textPrimary;
  static const _sub = AppColors.grey66;
  static const _muted = AppColors.grey49;
  static const _green = AppColors.green79;
  static const _line = AppColors.gold10;
  static const _cream = AppColors.cream;
  static const _paper = AppColors.gold04;

  BoxDecoration _card({Gradient? gradient, Color border = _line}) => BoxDecoration(
        color: gradient == null ? AppColors.white : null,
        gradient: gradient,
        border: Border.all(color: border),
        borderRadius: AppRadius.br16,
      );

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final months = s.monthsToComplete;
    final done = DateTime.now().add(Duration(days: s.daysToComplete));
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(children: [
        Container(
          color: _cream,
          padding: EdgeInsets.fromLTRB(24, top + 8, 24, 8),
          child: Row(children: [
            AppCircleIconButton(icon: const AppIcon.square('button_go_back_7053e066', 40), borderColor: _line, onTap: () => Navigator.maybePop(context)),
            Expanded(
              child: Text('My Reading Plan', textAlign: TextAlign.center, style: ts(AppFonts.jakarta, 16, w700, _ink, lh: 24, ls: -0.4)),
            ),
            AppCircleIconButton(icon: const AppIcon.square('button_reading_mode_d1c3f23f', 40), borderColor: _line, onTap: () => Navigator.of(context).pushNamed(AppRoutes.dailyReading)),
          ]),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(21, 8.5, 21, 40),
            children: [
              // HERO: Your plan
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: _card(),
                child: Stack(children: [
                  Positioned(
                    left: 251,
                    top: -31,
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: AppColors.gold06.o(.6), blurRadius: 48, spreadRadius: 10)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: AppInsets.all20,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('Your plan', style: ts(AppFonts.jakarta, 19, w700, _ink, lh: 28.5, ls: -0.5)),
                            AppGap.v2,
                            Text('Daily Khatm companion pace', style: AppTextStyles.jakartaCaption.c(_sub)),
                          ]),
                        ),
                        const AppIcon('icon_7621331a', w: 14.5, h: 19),
                      ]),
                      AppGap.v16,
                      _planItem('background_border_76dacba1', 'Daily target', '${s.sectionsPerDay} sections per day', note: '~${s.dailyMinutes * 18 ~/ 5} mins'),
                      _divider(),
                      _planItem('background_border_e4e6b223', 'To complete the whole Quran', '${s.daysToComplete} days', chip: '1,280 sections total'),
                      _divider(),
                      _planItem('background_border_b988dee8', 'Estimated completion', '$months months', note: Formatters.monthYear(done)),
                      AppGap.v16,
                      Container(
                        padding: const EdgeInsets.only(top: 14),
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: _line))),
                        child: Row(children: [
                          Expanded(child: Text('Created on 1st Muharram', style: AppTextStyles.jakartaCaption.c(_muted))),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.dailyRecitation),
                            child: Row(children: [
                              Text('Recalculate target', style: AppTextStyles.jakartaCaptionSemibold.c(_green)),
                              const AppIcon('margin_c45e118c', w: 6.5, h: 7.5),
                            ]),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                ]),
              ),
              AppGap.v16,
              // TODAY'S RECITATION
              Container(
                padding: AppInsets.all16,
                decoration: _card(),
                child: Column(children: [
                  Row(children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: _green, shape: BoxShape.circle)),
                    AppGap.h8,
                    Expanded(child: Text("TODAY'S RECITATION", style: ts(AppFonts.jakarta, 12, w700, _ink, lh: 16, ls: 0.6))),
                    Container(
                      height: 20,
                      padding: AppInsets.h8,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: AppColors.grey06, borderRadius: AppRadius.pill),
                      child: Text('2 of ${s.sectionsPerDay} Done', style: AppTextStyles.jakartaCaptionBold.c(_green)),
                    ),
                  ]),
                  AppGap.v10,
                  Row(children: [
                    for (var i = 0; i < s.sectionsPerDay; i++) ...[
                      if (i > 0) AppGap.h6,
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: i < 2 ? _green : _paper,
                            border: i < 2 ? null : Border.all(color: _line),
                            borderRadius: AppRadius.pill,
                          ),
                        ),
                      ),
                    ],
                  ]),
                  AppGap.v10,
                  Row(children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Up Next: Surah Al-Baqarah', style: AppTextStyles.jakartaCaption.c(_sub)),
                        const SizedBox(height: 1),
                        Text('Section 3 • ~6 mins remaining', style: AppTextStyles.jakartaSmall.c(_muted)),
                      ]),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.dailyReading),
                      child: Container(
                        height: 32,
                        padding: AppInsets.h14,
                        decoration: BoxDecoration(
                          color: AppColors.green89,
                          borderRadius: AppRadius.br12,
                          boxShadow: [fShadow(AppColors.green79.o(.3), 0, 8, 20, -4)],
                        ),
                        child: Row(children: [
                          const AppIcon('container_86e2efd5', w: 6.8, h: 8.8),
                          AppGap.h6,
                          Text('Recite Now', style: AppTextStyles.jakartaCaptionBold.c(AppColors.white)),
                        ]),
                      ),
                    ),
                  ]),
                ]),
              ),
              AppGap.v16,
              // OVERALL KHATM JOURNEY
              Container(
                padding: AppInsets.all16,
                decoration: _card(),
                child: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Overall Khatm Journey', style: AppTextStyles.jakartaTitle.c(_ink)),
                        AppGap.v2,
                        Text('Juz 4 of 30 in progress', style: AppTextStyles.jakartaCaption.c(_sub)),
                      ]),
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('13.3%', style: ts(AppFonts.jakarta, 16, w800, _green, lh: 24)),
                      Text('81 of 604 pages', style: AppTextStyles.jakartaSmall.c(_muted)),
                    ]),
                  ]),
                  AppGap.v12,
                  Container(
                    height: 10,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(color: _paper, border: Border.all(color: _line), borderRadius: AppRadius.pill),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.133,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [_green, _green, AppColors.gold], stops: [0, .5, 1]),
                          borderRadius: AppRadius.pill,
                        ),
                      ),
                    ),
                  ),
                  AppGap.v12,
                  Row(children: [
                    _milestone('NEXT\nMILESTONE', 'Juz 5 Finish'),
                    AppGap.h8,
                    _milestone('PACE', '+2 Days\nAhead', green: true),
                    AppGap.h8,
                    _milestone('TOTAL TIME', '28h 40m'),
                  ]),
                ]),
              ),
              AppGap.v16,
              // ROUTINE & PREFERENCES
              Container(
                padding: AppInsets.all16,
                decoration: _card(),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: _line))),
                    child: Row(children: [
                      Expanded(child: Text('Routine & Preferences', style: AppTextStyles.jakartaTitle.c(_ink))),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(AppRoutes.readingSettings),
                        child: const AppIcon('container_76b16c83', w: 13.9, h: 14.4),
                      ),
                    ]),
                  ),
                  AppGap.v12,
                  _pref('background_66158b30', 'Daily Reminders', 'After Fajr (05:45) & Isha (20:30)',
                      AppSwitch.small(value: s.dailyReminder, onChanged: (v) => setState(() => s.update(() => s.dailyReminder = v)))),
                  AppGap.v8,
                  _pref('background_10063977', 'Recitation Mode', 'Tarteel (Meditative pace with audio)',
                      const AppIcon('button_d7a11271', w: 8.5, h: 20.4),
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.audioRecitation)),
                  AppGap.v8,
                  _pref('background_db690065', 'Automatic Catch-up', 'Redistribute missed sections gracefully',
                      AppSwitch.small(value: _catchUp, onChanged: (v) => setState(() => _catchUp = v))),
                ]),
              ),
              AppGap.v16,
              // Quote
              Container(
                padding: AppInsets.all16,
                decoration: _card(
                  border: AppColors.gold21.o(.6),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.amber50, AppColors.white, AppColors.gold06.o(.4)],
                  ),
                ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Padding(padding: EdgeInsets.only(top: 2), child: AppIcon('margin_bdf4fe15', w: 14, h: 11.9)),
                  AppGap.h12,
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        '“The most beloved of deeds to Allah are those that are\nmost consistent, even if they are small.”',
                        style: ts(AppFonts.cormorant, 13, w600, _ink, lh: 19.5, style: FontStyle.italic),
                      ),
                      const SizedBox(height: 3),
                      Text('Sahih al-Bukhari 6464', style: ts(AppFonts.jakarta, 11, w700, AppColors.goldDark, lh: 16.5)),
                    ]),
                  ),
                ]),
              ),
              AppGap.v16,
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    setState(() => _paused = !_paused);
                    showAppSnackBar(context, _paused ? 'Plan paused' : 'Plan resumed');
                  },
                  child: Text(_paused ? 'Resume Plan' : 'Pause Plan', style: AppTextStyles.jakartaCaptionMedium.c(_muted)),
                ),
                Padding(padding: AppInsets.h8, child: Text('•', style: AppTextStyles.jakartaCaptionMedium.c(_muted))),
                GestureDetector(
                  onTap: () => _confirmReset(context),
                  child: Text('Reset Journey', style: AppTextStyles.jakartaCaptionMedium.c(_muted)),
                ),
              ]),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _divider() => Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 16), color: _paper);

  Widget _planItem(String icon, String label, String value, {String? note, String? chip}) => SizedBox(
        height: 44,
        child: Row(children: [
          AppIcon(icon, w: 44, h: 44),
          AppGap.h14,
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(label, style: AppTextStyles.jakartaCaptionMedium.c(_sub)),
              AppGap.v2,
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(value, style: AppTextStyles.jakartaTitle.c(_ink)),
                AppGap.h8,
                if (note != null) Text(note, style: AppTextStyles.jakartaSmall.c(_muted)),
                if (chip != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: const BoxDecoration(color: AppColors.grey06, borderRadius: AppRadius.br4),
                    child: Text(chip, style: ts(AppFonts.jakarta, 11, w500, _green, lh: 16.5)),
                  ),
              ]),
            ]),
          ),
        ]),
      );

  Widget _milestone(String label, String value, {bool green = false}) => Expanded(
        child: Container(
          height: 71,
          padding: AppInsets.all10,
          decoration: BoxDecoration(color: _cream, border: Border.all(color: AppColors.gold10.o(.6)), borderRadius: AppRadius.br12),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(label, textAlign: TextAlign.center, style: ts(AppFonts.jakarta, 10, w600, _muted, lh: 15, ls: 0.3)),
            AppGap.v2,
            Text(value, textAlign: TextAlign.center, style: ts(AppFonts.jakarta, 12, w700, green ? _green : _ink, lh: 16)),
          ]),
        ),
      );

  Widget _pref(String icon, String title, String sub, Widget trailing, {VoidCallback? onTap}) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 54,
          padding: AppInsets.all10,
          decoration: BoxDecoration(color: _cream, border: Border.all(color: AppColors.gold10.o(.5)), borderRadius: AppRadius.br12),
          child: Row(children: [
            AppIcon(icon, w: 32, h: 32),
            AppGap.h12,
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(title, style: AppTextStyles.jakartaCaptionBold.c(_ink)),
                Text(sub, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.jakartaSmall.c(_sub)),
              ]),
            ),
            trailing,
          ]),
        ),
      );

  Future<void> _confirmReset(BuildContext context) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Reset your journey?',
      message: 'Your Khatm progress will start again from Al-Fatihah.',
      confirmLabel: 'Reset',
      destructive: true,
    );
    if (ok && context.mounted) showAppSnackBar(context, 'Journey reset');
  }
}
