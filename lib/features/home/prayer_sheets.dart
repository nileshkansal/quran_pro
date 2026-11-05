import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../core/state/app_state.dart';
import '../../core/utils/hijri.dart';
import '../../data/mock_data.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';
import '../../core/assets.dart';

/// Barrier used by the Home overlays: #03261c @ 60% with 4px backdrop blur.
// ───────────────────────────── Qibla ─────────────────────────────

/// Figma: "Qibla Direction" (6001:3218) — 390×548 sheet, top radius 36.
Future<void> showQiblaSheet(BuildContext context) => showAppModal(context, child: const _QiblaSheet(), bottom: true, barrier: AppBarrier.greenBlur, duration: const Duration(milliseconds: 320));

class _QiblaSheet extends StatefulWidget {
  const _QiblaSheet();

  @override
  State<_QiblaSheet> createState() => _QiblaSheetState();
}

class _QiblaSheetState extends State<_QiblaSheet> with SingleTickerProviderStateMixin {
  // Gentle sway while "calibrating". Wire flutter_compass heading here.
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      width: double.infinity,
      height: 548 + bottom,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        border: Border.all(color: AppColors.gold24.o(.4)),
        boxShadow: [fShadow(AppColors.pureBlack.o(.2), 0, -12, 40)],
      ),
      child: Stack(children: [
        Positioned(
          top: 13,
          left: 0,
          right: 0,
          child: Center(
            child: Opacity(
              opacity: 0.8,
              child: Container(width: 44, height: 4, decoration: const BoxDecoration(color: AppColors.stone300, borderRadius: AppRadius.pill)),
            ),
          ),
        ),
        Positioned(
          top: 17,
          right: 20,
          child: GestureDetector(onTap: () => Navigator.pop(context), child: const AppIcon('close_button_top_right_1539a3f5', w: 32, h: 32)),
        ),
        Positioned(
          top: 29,
          left: 24,
          right: 24,
          child: Column(children: [
            const Padding(padding: EdgeInsets.only(bottom: 8), child: AppIcon('small_green_kaaba_quran_badg_7d915f64', w: 36, h: 36)),
            Text('Qibla Direction', style: ts(AppFonts.inter, 22, w700, AppColors.green84, lh: 30.3, ls: -0.6)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('Point your device flat to find the direction of the\nQibla.',
                  textAlign: TextAlign.center, style: ts(AppFonts.inter, 12, w500, AppColors.stone500, lh: 19.5)),
            ),
            AppGap.v14,
            Container(
              height: 32,
              padding: AppInsets.h16,
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.stone200),
                borderRadius: AppRadius.pill,
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const AppIcon('container_6c5b5ae7', w: 10.7, h: 13.3),
                AppGap.h6,
                Text(AppState.instance.location, style: ts(AppFonts.inter, 12, w600, AppColors.stone800, lh: 18, ls: -0.3)),
              ]),
            ),
          ]),
        ),
        // Compass: dial + pointer rotate together; the centre disc stays upright.
        Positioned(
          top: 190.3 + 16,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              width: 218,
              height: 218,
              child: Stack(alignment: Alignment.center, children: [
                Container(
                  width: 218,
                  height: 218,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [fShadow(AppColors.pureBlack.o(.1), 0, 8, 10, -6), fShadow(AppColors.pureBlack.o(.1), 0, 20, 25, -5)],
                  ),
                ),
                AnimatedBuilder(
                  animation: _c,
                  builder: (_, child) => Transform.rotate(angle: (Curves.easeInOut.transform(_c.value) - 0.5) * 0.12, child: child),
                  child: Image.asset(AppIcons.compassDial, width: 218, height: 218),
                ),
                Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.gold24.o(.7), width: 3),
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const AppIcon('kaaba_vector_graphic_2d3107ab', w: 32, h: 32),
                    AppGap.v2,
                    Text('299°', style: ts(AppFonts.inter, 18, w700, AppColors.green84, lh: 18, ls: -0.4)),
                    const SizedBox(height: 1),
                    Text('NORTH WEST', style: ts(AppFonts.inter, 9.5, w600, AppColors.stone500, lh: 9.5, ls: 0.5)),
                  ]),
                ),
              ]),
            ),
          ),
        ),
        Positioned(
          top: 444.3,
          left: 24,
          right: 24,
          child: Container(
            height: 60.1,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.stone200.o(.8)),
              borderRadius: AppRadius.br12,
            ),
            child: Row(children: [
              const AppIcon('background_border_f0bdce72', w: 32, h: 32),
              AppGap.h12,
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Keep your phone flat', style: ts(AppFonts.inter, 12.5, w700, AppColors.stone800, lh: 15.6)),
                  const SizedBox(height: 1.6),
                  Text('For more accurate results', style: ts(AppFonts.inter, 11, w500, AppColors.stone500, lh: 16.5)),
                ]),
              ),
              const AppIcon('margin_2c7a440d', w: 32.5, h: 21.8),
            ]),
          ),
        ),
        Positioned(
          top: 504.4 + 12,
          left: 0,
          right: 0,
          child: Center(
            child: Container(width: 128, height: 4, decoration: const BoxDecoration(color: AppColors.stone800, borderRadius: AppRadius.pill)),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────── Prayer times ───────────────────────────

/// Figma: "Prayer Times select time" (6001:3502) and "select Date" (6001:3845).
Future<void> showPrayerTimesSheet(BuildContext context) => showAppModal(context, child: const _PrayerTimesSheet(), bottom: true, barrier: AppBarrier.greenBlur, duration: const Duration(milliseconds: 320));

class _PrayerTimesSheet extends StatefulWidget {
  const _PrayerTimesSheet();

  @override
  State<_PrayerTimesSheet> createState() => _PrayerTimesSheetState();
}

class _PrayerTimesSheetState extends State<_PrayerTimesSheet> {
  bool _calendar = false;
  DateTime _selected = DateTime.now();
  late DateTime _month = DateTime(_selected.year, _selected.month);

  BoxDecoration get _white => const BoxDecoration(color: AppColors.white, borderRadius: AppRadius.br12);

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;
    final hijri = HijriDate.fromGregorian(_selected);
    final top = MediaQuery.of(context).padding.top;
    return Container(
      height: MediaQuery.of(context).size.height - top - 64,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        boxShadow: [fShadow(AppColors.pureBlack.o(.2), 0, 25, 50, -12)],
      ),
      child: ListView(
        padding: EdgeInsets.fromLTRB(24, 12, 24, 32 + MediaQuery.of(context).padding.bottom),
        children: [
          // Drag handle + close
          SizedBox(
            height: 18,
            child: Stack(clipBehavior: Clip.none, alignment: Alignment.topCenter, children: [
              Container(width: 48, height: 6, decoration: const BoxDecoration(color: AppColors.outline, borderRadius: AppRadius.pill)),
              Positioned(
                right: 0,
                top: -7,
                child: GestureDetector(onTap: () => Navigator.pop(context), child: const AppIcon('button_aabf7c08', w: 36, h: 36)),
              ),
            ]),
          ),
          AppGap.v24,
          Center(child: Text('Prayer Times', style: ts(AppFonts.inter, 24, w600, AppColors.green800, lh: 32, ls: -0.5))),
          const SizedBox(height: 9),
          GestureDetector(
            onTap: () async {
              await showChooseLocationSheet(context);
              setState(() {});
            },
            child: Container(
              height: 64,
              padding: AppInsets.all16,
              decoration: _white,
              child: Row(children: [
                const AppIcon('container_7c8958dd', w: 13.3, h: 16.7),
                AppGap.h12,
                Expanded(child: Text(s.location, style: AppTextStyles.bodyMedium)),
                const AppIcon('button_423a0953', w: 32, h: 32),
              ]),
            ),
          ),
          const SizedBox(height: 9),
          GestureDetector(
            onTap: () => setState(() => _calendar = !_calendar),
            child: Container(
              height: 72,
              padding: AppInsets.all16,
              decoration: _white,
              child: Row(children: [
                const AppIcon('container_67b78b7a', w: 15, h: 16.7),
                AppGap.h12,
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(hijri.toString(), style: AppTextStyles.bodyMedium),
                    Text(formatLongDate(_selected), style: AppTextStyles.labelRegular),
                  ]),
                ),
                AnimatedRotation(
                  turns: _calendar ? 0.25 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const AppIcon('container_4a7e8d26', w: 6.2, h: 10),
                ),
              ]),
            ),
          ),
          AppGap.v24,
          if (_calendar) ...[
            _notifRow(true),
            AppGap.v24,
            _calendarCard(),
          ] else ...[
            _nextPrayer(),
            AppGap.v24,
            _lastThird(),
            AppGap.v24,
            Container(
              padding: AppInsets.all8,
              decoration: _white,
              child: Column(children: [for (final p in kPrayerTimes) _PrayerRow(p, current: p.name == 'Dhuhr')]),
            ),
            AppGap.v24,
            _notifRow(false),
          ],
        ],
      ),
    );
  }

  Widget _notifRow(bool green) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(shape: BoxShape.circle, gradient: green ? null : AppColors.goldGradient, color: green ? AppColors.green500 : null),
            ),
            AppGap.h8,
            Text('Notifications are ON', style: AppTextStyles.bodyMedium),
          ]),
          GestureDetector(
            onTap: () {
              mainTabIndex.value = 2;
              Navigator.of(context).popUntil((r) => r.isFirst);
            },
            child: Row(children: [
              AppIcon(green ? 'container_285babb1' : 'container_8d315cbb', w: 16.8, h: 16.7),
              AppGap.h6,
              green
                  ? Text('Adjust in Settings', style: AppTextStyles.bodyMedium.c(AppColors.green500))
                  : GradientText('Adjust in Settings', style: AppTextStyles.bodyMedium.c(AppColors.white), gradient: AppColors.goldGradient),
            ]),
          ),
        ]),
      );

  Widget _nextPrayer() => Container(
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.green700,
          borderRadius: AppRadius.br12,
          boxShadow: AppShadows.md,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(children: [
          Positioned(left: 212, top: 26.3, child: Opacity(opacity: 0.1, child: Image.asset(AppIcons.prayerMosqueDeco, width: 140, height: 123.7))),
          Padding(
            padding: AppInsets.all24,
            child: Column(children: [
              SizedBox(
                height: 60,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('NEXT PRAYER', style: AppTextStyles.labelRegular.c(AppColors.goldSoft)),
                    AppGap.v4,
                    Text('Asr', style: ts(AppFonts.inter, 30, w400, AppColors.white, lh: 36)),
                  ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('03:58 PM', style: ts(AppFonts.inter, 24, w400, AppColors.white, lh: 32)),
                    AppGap.v4,
                    ClipRRect(
                      borderRadius: AppRadius.pill,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: 24,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          color: AppColors.surface.o(.1),
                          child: Text('In 2h 17m', style: AppTextStyles.labelRegular.c(AppColors.goldSoft)),
                        ),
                      ),
                    ),
                  ]),
                ]),
              ),
              const SizedBox(height: 16 + 8),
              Container(
                height: 8,
                decoration: BoxDecoration(color: AppColors.surface.o(.2), borderRadius: AppRadius.pill),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: 191.1 / 294,
                  child: Container(decoration: const BoxDecoration(color: AppColors.goldSoft, borderRadius: AppRadius.pill)),
                ),
              ),
            ]),
          ),
        ]),
      );

  Widget _lastThird() => Container(
        height: 104,
        padding: AppInsets.all20,
        decoration: BoxDecoration(
          gradient: AppColors.goldGradient,
          borderRadius: AppRadius.br12,
          boxShadow: AppShadows.md,
        ),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(children: [
                const AppIcon('container_77b8f4cb', w: 11.3, h: 15),
                AppGap.h8,
                Text('LAST THIRD OF THE NIGHT', style: AppTextStyles.labelRegular.c(AppColors.white)),
              ]),
              AppGap.v4,
              Text('Best time for Tahajjud & Du\'a', style: AppTextStyles.bodyMedium.c(AppColors.pureBlack)),
              AppGap.v4,
              Text('01:27 AM – 04:50 AM', style: AppTextStyles.labelRegular.c(AppColors.white)),
            ]),
          ),
          const AppIcon('background_9be5b1ba', w: 48, h: 48),
        ]),
      );

  Widget _calendarCard() {
    final first = DateTime(_month.year, _month.month);
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    final lead = first.weekday % 7;
    final today = DateTime.now();
    final hStart = HijriDate.fromGregorian(first);
    final hEnd = HijriDate.fromGregorian(DateTime(_month.year, _month.month, daysInMonth));
    final hijriRange = hStart.month == hEnd.month ? '${hStart.monthName} ${hStart.year} AH' : '${hStart.monthName} – ${hEnd.monthName} ${hEnd.year} AH';
    final hSel = HijriDate.fromGregorian(_selected);
    final cells = lead + daysInMonth;
    final rows = (cells / 7).ceil();
    return Container(
      padding: AppInsets.all24,
      decoration: const BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32), bottom: Radius.circular(12))),
      child: Column(children: [
        Container(width: 48, height: 4, decoration: const BoxDecoration(color: AppColors.divider, borderRadius: AppRadius.pill)),
        AppGap.v16,
        Padding(
          padding: AppInsets.v8,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: () => setState(() => _month = DateTime(_month.year, _month.month - 1)),
              child: const AppIcon('button_8f823ab2', w: 28.4, h: 32),
            ),
            SizedBox(
              width: 195,
              child: Column(children: [
                Text('${kMonths[_month.month - 1]} ${_month.year}', style: ts(AppFonts.inter, 18, w600, AppColors.green800, lh: 28)),
                Text(hijriRange, textAlign: TextAlign.center, style: AppTextStyles.labelRegular.c(AppColors.gold81)),
              ]),
            ),
            GestureDetector(
              onTap: () => setState(() => _month = DateTime(_month.year, _month.month + 1)),
              child: const AppIcon('button_9b857998', w: 28.4, h: 32),
            ),
          ]),
        ),
        AppGap.v16,
        SizedBox(
          height: 24,
          child: Row(children: [
            for (final d in const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'])
              Expanded(child: Center(child: Text(d, style: ts(AppFonts.inter, 12, w600, AppColors.green800, lh: 16, ls: 0.6)))),
          ]),
        ),
        AppGap.v16,
        for (var r = 0; r < rows; r++)
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(children: [
              for (var c = 0; c < 7; c++)
                Expanded(child: _dayCell(r * 7 + c - lead + 1, daysInMonth, today)),
            ]),
          ),
        AppGap.v16,
        Container(height: 1, color: AppColors.grey09),
        AppGap.v16,
        Padding(
          padding: AppInsets.v8,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Today's Corresponding Date", style: AppTextStyles.labelRegular),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: AppColors.green20.o(.2), borderRadius: AppRadius.pill),
                child: Row(children: [
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.green500, shape: BoxShape.circle)),
                  AppGap.h6,
                  Text('Active', style: ts(AppFonts.inter, 12, w400, AppColors.green500, lh: 16)),
                ]),
              ),
            ]),
            AppGap.v4,
            Text(hSel.toString(), style: ts(AppFonts.inter, 16, w700, AppColors.green800, lh: 24)),
            AppGap.v4,
            Text(formatLongDate(_selected), style: AppTextStyles.labelRegular),
          ]),
        ),
        AppGap.v16,
        Container(
          padding: AppInsets.v12,
          decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.grey09.o(.5)))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _legend(AppColors.green500, 'Hijri Date (Emerald)'),
            AppGap.h24,
            _legend(AppColors.gold81, 'Gregorian Date (Gold)'),
          ]),
        ),
      ]),
    );
  }

  Widget _legend(Color c, String t) => Row(children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
        AppGap.h6,
        Text(t, style: ts(AppFonts.inter, 11, w500, AppColors.textSecondary, lh: 16.5)),
      ]);

  Widget _dayCell(int day, int daysInMonth, DateTime today) {
    if (day < 1 || day > daysInMonth) return const SizedBox(height: 36);
    final date = DateTime(_month.year, _month.month, day);
    final sel = _same(date, _selected);
    final isToday = _same(date, today);
    return GestureDetector(
      onTap: () => setState(() => _selected = date),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 41,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: sel ? AppColors.goldGradient : null,
            borderRadius: BorderRadius.circular(500),
            border: isToday && !sel ? Border.all(color: AppColors.gold) : null,
          ),
          child: Text('$day', style: ts(AppFonts.montserrat, 14, w500, sel ? AppColors.white : AppColors.blue85, lh: 22)),
        ),
      ),
    );
  }

  bool _same(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
}

class _PrayerRow extends StatefulWidget {
  const _PrayerRow(this.p, {this.current = false});
  final PrayerTime p;
  final bool current;

  @override
  State<_PrayerRow> createState() => _PrayerRowState();
}

class _PrayerRowState extends State<_PrayerRow> {
  late bool _on = widget.p.notify;

  static const _icons = {
    'Fajr': ('container_1429d038', 20.0, 16.0),
    'Sunrise': ('container_b147f6dd', 22.0, 22.0),
    'Dhuhr': ('container_09af1a34', 22.0, 22.0),
    'Asr': ('container_0aa5328d', 22.0, 22.0),
    'Maghrib': ('container_eb8b28a7', 20.0, 19.0),
    'Isha': ('container_ed2602b4', 20.0, 20.0),
  };

  @override
  Widget build(BuildContext context) {
    final p = widget.p;
    final cur = widget.current;
    final (icon, iw, ih) = _icons[p.name]!;
    final nameColor = cur ? AppColors.green800 : (p.serif ? AppColors.textSecondary : AppColors.textPrimary);
    return Container(
      height: 52,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: cur ? AppColors.green20.o(.2) : null, borderRadius: AppRadius.br8),
      child: Row(children: [
        SizedBox(width: 22, child: Center(child: AppIcon(icon, w: iw, h: ih))),
        AppGap.h12,
        Expanded(child: Text(p.name, style: ts(AppFonts.inter, 16, cur ? w600 : w400, nameColor, lh: 24))),
        Text(
          p.time,
          style: p.serif ? ts(AppFonts.amiri, 16, w400, AppColors.textSecondary, lh: 24) : ts(AppFonts.inter, 16, w600, cur ? AppColors.green800 : AppColors.textPrimary, lh: 24),
        ),
        AppGap.h16,
        GestureDetector(
          onTap: p.notify ? () => setState(() => _on = !_on) : null,
          child: SizedBox(
            width: 18.2,
            child: p.notify
                ? Opacity(opacity: _on ? 1 : 0.3, child: const AppIcon('container_ed3c1858', w: 15, h: 14.6))
                : const AppIcon('container_0782c31c', w: 18.2, h: 0.9),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────── Choose location ───────────────────────────

/// Figma: "Choose Location" (6001:4185) — floating 356.7-wide card, r32.9.
Future<void> showChooseLocationSheet(BuildContext context) =>
    showAppModal(context, child: const _ChooseLocationCard(), barrier: AppBarrier.greenBlur);

class _ChooseLocationCard extends StatefulWidget {
  const _ChooseLocationCard();

  @override
  State<_ChooseLocationCard> createState() => _ChooseLocationCardState();
}

class _ChooseLocationCardState extends State<_ChooseLocationCard> {
  bool _auto = true;
  final _q = TextEditingController();
  String? _picked;
  Timer? _debounce;
  List<String> _results = const [];

  @override
  void dispose() {
    _q.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _search(String v) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      final q = v.trim().toLowerCase();
      setState(() => _results = q.isEmpty ? const [] : kCities.where((c) => c.toLowerCase().contains(q)).toList());
    });
  }

  Widget _radio(bool on) => Container(
        width: 22,
        height: 22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: on ? AppColors.goldGradient : null,
          border: on ? null : Border.all(color: AppColors.textMuted, width: 1.8),
        ),
        child: on ? Container(width: 9.1, height: 9.1, decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle)) : null,
      );

  Widget _optionTitle(String t, bool on, VoidCallback tap) => GestureDetector(
        onTap: tap,
        child: Row(children: [
          _radio(on),
          const SizedBox(width: 11),
          GradientText(t, style: ts(AppFonts.inter, 14.6, w500, AppColors.white, lh: 22), gradient: AppColors.goldGradient),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;
    final w = math.min(356.7, MediaQuery.of(context).size.width - 32);
    return Container(
      width: w,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32.9),
        boxShadow: [fShadow(AppColors.pureBlack.o(.2), 0, 22.9, 45.7, -11)],
      ),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const AppIcon('location_icon_d44bc653', w: 65.9, h: 65.9),
          const SizedBox(height: 22),
          Text('Choose Location', style: ts(AppFonts.inter, 22, w600, AppColors.green800, lh: 29.3, ls: -0.4)),
          const SizedBox(height: 3.7),
          Text('How would you like to set your location\nfor accurate prayer times?',
              textAlign: TextAlign.center, style: ts(AppFonts.inter, 12.8, w400, AppColors.textSecondary, lh: 18.3)),
          const SizedBox(height: 22),
          _optionTitle('Choose Automatically', _auto, () => setState(() => _auto = true)),
          const SizedBox(height: 11),
          Container(
            height: 65.9,
            padding: const EdgeInsets.symmetric(horizontal: 18.3),
            decoration: BoxDecoration(color: AppColors.green30.o(.2), borderRadius: BorderRadius.circular(14.6)),
            child: Row(children: [
              const AppIcon('container_ad0f4161', w: 20, h: 20),
              const SizedBox(width: 11),
              Expanded(child: Text(s.location, style: ts(AppFonts.inter, 14.6, w400, AppColors.textPrimary, lh: 22))),
              if (_auto) const AppIcon('container_b6a6528e', w: 18.3, h: 18.3),
            ]),
          ),
          const SizedBox(height: 14.6 + 7.3),
          _optionTitle('Choose Manually', !_auto, () => setState(() => _auto = false)),
          const SizedBox(height: 11),
          Container(
            height: 51.2,
            decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(14.6)),
            child: Row(children: [
              const SizedBox(width: 17.4),
              const AppIcon('icon_ebe2a693', w: 16.5, h: 16.5),
              AppGap.h10,
              Expanded(
                child: TextField(
                  controller: _q,
                  onChanged: (v) {
                    if (_auto) setState(() => _auto = false);
                    _search(v);
                  },
                  style: ts(AppFonts.inter, 14.6, w400, AppColors.textPrimary),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: 'Type city, state or country',
                    hintStyle: ts(AppFonts.inter, 14.6, w400, AppColors.textMuted),
                  ),
                ),
              ),
              const SizedBox(width: 14.6),
            ]),
          ),
          const SizedBox(height: 3.7),
          if (_results.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.3),
              child: SizedBox(
                width: double.infinity,
                child: Text('Start typing to see matching cities', style: ts(AppFonts.inter, 11, w400, AppColors.textMuted, lh: 14.6, ls: 0.5)),
              ),
            )
          else
            for (final c in _results.take(4))
              InkWell(
                onTap: () => setState(() => _picked = c),
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 7.3),
                  alignment: Alignment.centerLeft,
                  child: Row(children: [
                    _radio(_picked == c),
                    const SizedBox(width: 11),
                    Expanded(child: Text(c, style: AppTextStyles.bodySmall.c(AppColors.textPrimary))),
                  ]),
                ),
              ),
          const SizedBox(height: 7.3),
          Container(height: 0.9, color: AppColors.grey09),
          const SizedBox(height: 22 + 3.7),
          AppButton(
            label: 'Save Location',
            height: 58.5,
            gap: 7.3,
            textStyle: ts(AppFonts.inter, 14.6, w400, AppColors.white, lh: 22),
            trailing: const AppIcon('container_a12022d6', w: 12.2, h: 12.2),
            shadow: [fShadow(AppColors.pureBlack.o(.1), 0, 3.7, 5.5, -3.7), fShadow(AppColors.pureBlack.o(.1), 0, 9.1, 13.7, -2.7)],
            onTap: () {
              s.update(() {
                if (!_auto && _picked != null) s.location = _picked!;
                s.locationAllowed = true;
              });
              Navigator.pop(context);
            },
          ),
        ]),
      ),
    );
  }
}
