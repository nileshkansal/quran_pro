import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/hijri.dart';
import '../../data/mock_data.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/fig_widgets.dart';

/// Barrier used by the Home overlays: #03261c @ 60% with 4px backdrop blur.
Widget _blurBarrier() => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(color: fc(0x03261C, .6)),
    );

Future<T?> _figSheet<T>(BuildContext context, WidgetBuilder builder) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'close',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 320),
    pageBuilder: (ctx, a, _) => Stack(children: [
      Positioned.fill(child: GestureDetector(onTap: () => Navigator.pop(ctx), child: FadeTransition(opacity: a, child: _blurBarrier()))),
      Align(
        alignment: Alignment.bottomCenter,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
          child: Material(type: MaterialType.transparency, child: builder(ctx)),
        ),
      ),
    ]),
  );
}

// ───────────────────────────── Qibla ─────────────────────────────

/// Figma: "Qibla Direction" (6001:3218) — 390×548 sheet, top radius 36.
Future<void> showQiblaSheet(BuildContext context) => _figSheet(context, (_) => const _QiblaSheet());

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
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        border: Border.all(color: fc(0xE6D39D, .4)),
        boxShadow: [fShadow(fc(0x000000, .2), 0, -12, 40)],
      ),
      child: Stack(children: [
        Positioned(
          top: 13,
          left: 0,
          right: 0,
          child: Center(
            child: Opacity(
              opacity: 0.8,
              child: Container(width: 44, height: 4, decoration: BoxDecoration(color: const Color(0xFFD6D3D1), borderRadius: BorderRadius.circular(9999))),
            ),
          ),
        ),
        Positioned(
          top: 17,
          right: 20,
          child: GestureDetector(onTap: () => Navigator.pop(context), child: const FigIcon('close_button_top_right_1539a3f5', w: 32, h: 32)),
        ),
        Positioned(
          top: 29,
          left: 24,
          right: 24,
          child: Column(children: [
            const Padding(padding: EdgeInsets.only(bottom: 8), child: FigIcon('small_green_kaaba_quran_badg_7d915f64', w: 36, h: 36)),
            Text('Qibla Direction', style: ts(Ff.inter, 22, w700, const Color(0xFF064A3A), lh: 30.3, ls: -0.6)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('Point your device flat to find the direction of the\nQibla.',
                  textAlign: TextAlign.center, style: ts(Ff.inter, 12, w500, const Color(0xFF78716C), lh: 19.5)),
            ),
            const SizedBox(height: 14),
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F8F4),
                border: Border.all(color: const Color(0xFFE7E5E4)),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const FigIcon('container_6c5b5ae7', w: 10.7, h: 13.3),
                const SizedBox(width: 6),
                Text(AppState.instance.location, style: ts(Ff.inter, 12, w600, const Color(0xFF292524), lh: 18, ls: -0.3)),
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
                    boxShadow: [fShadow(fc(0x000000, .1), 0, 8, 10, -6), fShadow(fc(0x000000, .1), 0, 20, 25, -5)],
                  ),
                ),
                AnimatedBuilder(
                  animation: _c,
                  builder: (_, child) => Transform.rotate(angle: (Curves.easeInOut.transform(_c.value) - 0.5) * 0.12, child: child),
                  child: Image.asset('assets/icons/compass_dial.png', width: 218, height: 218),
                ),
                Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: fc(0xE6D39D, .7), width: 3),
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const FigIcon('kaaba_vector_graphic_2d3107ab', w: 32, h: 32),
                    const SizedBox(height: 2),
                    Text('299°', style: ts(Ff.inter, 18, w700, const Color(0xFF064A3A), lh: 18, ls: -0.4)),
                    const SizedBox(height: 1),
                    Text('NORTH WEST', style: ts(Ff.inter, 9.5, w600, const Color(0xFF78716C), lh: 9.5, ls: 0.5)),
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
              color: const Color(0xFFF9F8F4),
              border: Border.all(color: fc(0xE7E5E4, .8)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(children: [
              const FigIcon('background_border_f0bdce72', w: 32, h: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Keep your phone flat', style: ts(Ff.inter, 12.5, w700, const Color(0xFF292524), lh: 15.6)),
                  const SizedBox(height: 1.6),
                  Text('For more accurate results', style: ts(Ff.inter, 11, w500, const Color(0xFF78716C), lh: 16.5)),
                ]),
              ),
              const FigIcon('margin_2c7a440d', w: 32.5, h: 21.8),
            ]),
          ),
        ),
        Positioned(
          top: 504.4 + 12,
          left: 0,
          right: 0,
          child: Center(
            child: Container(width: 128, height: 4, decoration: BoxDecoration(color: const Color(0xFF292524), borderRadius: BorderRadius.circular(9999))),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────── Prayer times ───────────────────────────

/// Figma: "Prayer Times select time" (6001:3502) and "select Date" (6001:3845).
Future<void> showPrayerTimesSheet(BuildContext context) => _figSheet(context, (_) => const _PrayerTimesSheet());

class _PrayerTimesSheet extends StatefulWidget {
  const _PrayerTimesSheet();

  @override
  State<_PrayerTimesSheet> createState() => _PrayerTimesSheetState();
}

class _PrayerTimesSheetState extends State<_PrayerTimesSheet> {
  bool _calendar = false;
  DateTime _selected = DateTime.now();
  late DateTime _month = DateTime(_selected.year, _selected.month);

  BoxDecoration get _white => BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12));

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;
    final hijri = HijriDate.fromGregorian(_selected);
    final top = MediaQuery.of(context).padding.top;
    return Container(
      height: MediaQuery.of(context).size.height - top - 64,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF6),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        boxShadow: [fShadow(fc(0x000000, .2), 0, 25, 50, -12)],
      ),
      child: ListView(
        padding: EdgeInsets.fromLTRB(24, 12, 24, 32 + MediaQuery.of(context).padding.bottom),
        children: [
          // Drag handle + close
          SizedBox(
            height: 18,
            child: Stack(clipBehavior: Clip.none, alignment: Alignment.topCenter, children: [
              Container(width: 48, height: 6, decoration: BoxDecoration(color: AppColors.outline, borderRadius: BorderRadius.circular(9999))),
              Positioned(
                right: 0,
                top: -7,
                child: GestureDetector(onTap: () => Navigator.pop(context), child: const FigIcon('button_aabf7c08', w: 36, h: 36)),
              ),
            ]),
          ),
          const SizedBox(height: 24),
          Center(child: Text('Prayer Times', style: ts(Ff.inter, 24, w600, AppColors.green800, lh: 32, ls: -0.5))),
          const SizedBox(height: 9),
          GestureDetector(
            onTap: () async {
              await showChooseLocationSheet(context);
              setState(() {});
            },
            child: Container(
              height: 64,
              padding: const EdgeInsets.all(16),
              decoration: _white,
              child: Row(children: [
                const FigIcon('container_7c8958dd', w: 13.3, h: 16.7),
                const SizedBox(width: 12),
                Expanded(child: Text(s.location, style: ts(Ff.inter, 16, w500, AppColors.textPrimary, lh: 24))),
                const FigIcon('button_423a0953', w: 32, h: 32),
              ]),
            ),
          ),
          const SizedBox(height: 9),
          GestureDetector(
            onTap: () => setState(() => _calendar = !_calendar),
            child: Container(
              height: 72,
              padding: const EdgeInsets.all(16),
              decoration: _white,
              child: Row(children: [
                const FigIcon('container_67b78b7a', w: 15, h: 16.7),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(hijri.toString(), style: ts(Ff.inter, 16, w500, AppColors.textPrimary, lh: 24)),
                    Text(formatLongDate(_selected), style: ts(Ff.inter, 12, w400, AppColors.textSecondary, lh: 16, ls: 0.6)),
                  ]),
                ),
                AnimatedRotation(
                  turns: _calendar ? 0.25 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const FigIcon('container_4a7e8d26', w: 6.2, h: 10),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 24),
          if (_calendar) ...[
            _notifRow(true),
            const SizedBox(height: 24),
            _calendarCard(),
          ] else ...[
            _nextPrayer(),
            const SizedBox(height: 24),
            _lastThird(),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: _white,
              child: Column(children: [for (final p in kPrayerTimes) _PrayerRow(p, current: p.name == 'Dhuhr')]),
            ),
            const SizedBox(height: 24),
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
            const SizedBox(width: 8),
            Text('Notifications are ON', style: ts(Ff.inter, 16, w500, AppColors.textPrimary, lh: 24)),
          ]),
          GestureDetector(
            onTap: () {
              mainTabIndex.value = 2;
              Navigator.of(context).popUntil((r) => r.isFirst);
            },
            child: Row(children: [
              FigIcon(green ? 'container_285babb1' : 'container_8d315cbb', w: 16.8, h: 16.7),
              const SizedBox(width: 6),
              green
                  ? Text('Adjust in Settings', style: ts(Ff.inter, 16, w500, AppColors.green500, lh: 24))
                  : GradientText('Adjust in Settings', style: ts(Ff.inter, 16, w500, Colors.white, lh: 24), gradient: AppColors.goldGradient),
            ]),
          ),
        ]),
      );

  Widget _nextPrayer() => Container(
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.green700,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [fShadow(fc(0x000000, .1), 0, 2, 4, -2), fShadow(fc(0x000000, .1), 0, 4, 6, -1)],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(children: [
          Positioned(left: 212, top: 26.3, child: Opacity(opacity: 0.1, child: Image.asset('assets/icons/prayer_mosque_deco.png', width: 140, height: 123.7))),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              SizedBox(
                height: 60,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('NEXT PRAYER', style: ts(Ff.inter, 12, w400, AppColors.goldSoft, lh: 16, ls: 0.6)),
                    const SizedBox(height: 4),
                    Text('Asr', style: ts(Ff.inter, 30, w400, Colors.white, lh: 36)),
                  ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('03:58 PM', style: ts(Ff.inter, 24, w400, Colors.white, lh: 32)),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9999),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: 24,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          color: fc(0xF8FAF6, .1),
                          child: Text('In 2h 17m', style: ts(Ff.inter, 12, w400, AppColors.goldSoft, lh: 16, ls: 0.6)),
                        ),
                      ),
                    ),
                  ]),
                ]),
              ),
              const SizedBox(height: 16 + 8),
              Container(
                height: 8,
                decoration: BoxDecoration(color: fc(0xF8FAF6, .2), borderRadius: BorderRadius.circular(9999)),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: 191.1 / 294,
                  child: Container(decoration: BoxDecoration(color: AppColors.goldSoft, borderRadius: BorderRadius.circular(9999))),
                ),
              ),
            ]),
          ),
        ]),
      );

  Widget _lastThird() => Container(
        height: 104,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppColors.goldGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [fShadow(fc(0x000000, .1), 0, 2, 4, -2), fShadow(fc(0x000000, .1), 0, 4, 6, -1)],
        ),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(children: [
                const FigIcon('container_77b8f4cb', w: 11.3, h: 15),
                const SizedBox(width: 8),
                Text('LAST THIRD OF THE NIGHT', style: ts(Ff.inter, 12, w400, Colors.white, lh: 16, ls: 0.6)),
              ]),
              const SizedBox(height: 4),
              Text('Best time for Tahajjud & Du\'a', style: ts(Ff.inter, 16, w500, Colors.black, lh: 24)),
              const SizedBox(height: 4),
              Text('01:27 AM – 04:50 AM', style: ts(Ff.inter, 12, w400, Colors.white, lh: 16, ls: 0.6)),
            ]),
          ),
          const FigIcon('background_9be5b1ba', w: 48, h: 48),
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
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32), bottom: Radius.circular(12))),
      child: Column(children: [
        Container(width: 48, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(9999))),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: () => setState(() => _month = DateTime(_month.year, _month.month - 1)),
              child: const FigIcon('button_8f823ab2', w: 28.4, h: 32),
            ),
            SizedBox(
              width: 195,
              child: Column(children: [
                Text('${kMonths[_month.month - 1]} ${_month.year}', style: ts(Ff.inter, 18, w600, AppColors.green800, lh: 28)),
                Text(hijriRange, textAlign: TextAlign.center, style: ts(Ff.inter, 12, w400, const Color(0xFF5F4504), lh: 16, ls: 0.6)),
              ]),
            ),
            GestureDetector(
              onTap: () => setState(() => _month = DateTime(_month.year, _month.month + 1)),
              child: const FigIcon('button_9b857998', w: 28.4, h: 32),
            ),
          ]),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 24,
          child: Row(children: [
            for (final d in const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'])
              Expanded(child: Center(child: Text(d, style: ts(Ff.inter, 12, w600, AppColors.green800, lh: 16, ls: 0.6)))),
          ]),
        ),
        const SizedBox(height: 16),
        for (var r = 0; r < rows; r++)
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(children: [
              for (var c = 0; c < 7; c++)
                Expanded(child: _dayCell(r * 7 + c - lead + 1, daysInMonth, today)),
            ]),
          ),
        const SizedBox(height: 16),
        Container(height: 1, color: const Color(0xFFE6E9E5)),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Today's Corresponding Date", style: ts(Ff.inter, 12, w400, AppColors.textSecondary, lh: 16, ls: 0.6)),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: fc(0xA4F3CC, .2), borderRadius: BorderRadius.circular(9999)),
                child: Row(children: [
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.green500, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text('Active', style: ts(Ff.inter, 12, w400, AppColors.green500, lh: 16)),
                ]),
              ),
            ]),
            const SizedBox(height: 4),
            Text(hSel.toString(), style: ts(Ff.inter, 16, w700, AppColors.green800, lh: 24)),
            const SizedBox(height: 4),
            Text(formatLongDate(_selected), style: ts(Ff.inter, 12, w400, AppColors.textSecondary, lh: 16, ls: 0.6)),
          ]),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(border: Border(top: BorderSide(color: fc(0xE6E9E5, .5)))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _legend(AppColors.green500, 'Hijri Date (Emerald)'),
            const SizedBox(width: 24),
            _legend(const Color(0xFF5F4504), 'Gregorian Date (Gold)'),
          ]),
        ),
      ]),
    );
  }

  Widget _legend(Color c, String t) => Row(children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(t, style: ts(Ff.inter, 11, w500, AppColors.textSecondary, lh: 16.5)),
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
          child: Text('$day', style: ts(Ff.montserrat, 14, w500, sel ? Colors.white : const Color(0xFF1C252E), lh: 22)),
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
      decoration: BoxDecoration(color: cur ? fc(0xA4F3CC, .2) : null, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        SizedBox(width: 22, child: Center(child: FigIcon(icon, w: iw, h: ih))),
        const SizedBox(width: 12),
        Expanded(child: Text(p.name, style: ts(Ff.inter, 16, cur ? w600 : w400, nameColor, lh: 24))),
        Text(
          p.time,
          style: p.serif ? ts(Ff.amiri, 16, w400, AppColors.textSecondary, lh: 24) : ts(Ff.inter, 16, w600, cur ? AppColors.green800 : AppColors.textPrimary, lh: 24),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: p.notify ? () => setState(() => _on = !_on) : null,
          child: SizedBox(
            width: 18.2,
            child: p.notify
                ? Opacity(opacity: _on ? 1 : 0.3, child: const FigIcon('container_ed3c1858', w: 15, h: 14.6))
                : const FigIcon('container_0782c31c', w: 18.2, h: 0.9),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────── Choose location ───────────────────────────

/// Figma: "Choose Location" (6001:4185) — floating 356.7-wide card, r32.9.
Future<void> showChooseLocationSheet(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'close',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (ctx, a, _) => Stack(children: [
      Positioned.fill(child: GestureDetector(onTap: () => Navigator.pop(ctx), child: FadeTransition(opacity: a, child: _blurBarrier()))),
      Center(
        child: ScaleTransition(
          scale: Tween(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: a, curve: Curves.easeOut)),
          child: FadeTransition(opacity: a, child: const Material(type: MaterialType.transparency, child: _ChooseLocationCard())),
        ),
      ),
    ]),
  );
}

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
        child: on ? Container(width: 9.1, height: 9.1, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)) : null,
      );

  Widget _optionTitle(String t, bool on, VoidCallback tap) => GestureDetector(
        onTap: tap,
        child: Row(children: [
          _radio(on),
          const SizedBox(width: 11),
          GradientText(t, style: ts(Ff.inter, 14.6, w500, Colors.white, lh: 22), gradient: AppColors.goldGradient),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.9),
        boxShadow: [fShadow(fc(0x000000, .2), 0, 22.9, 45.7, -11)],
      ),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const FigIcon('location_icon_d44bc653', w: 65.9, h: 65.9),
          const SizedBox(height: 22),
          Text('Choose Location', style: ts(Ff.inter, 22, w600, AppColors.green800, lh: 29.3, ls: -0.4)),
          const SizedBox(height: 3.7),
          Text('How would you like to set your location\nfor accurate prayer times?',
              textAlign: TextAlign.center, style: ts(Ff.inter, 12.8, w400, AppColors.textSecondary, lh: 18.3)),
          const SizedBox(height: 22),
          _optionTitle('Choose Automatically', _auto, () => setState(() => _auto = true)),
          const SizedBox(height: 11),
          Container(
            height: 65.9,
            padding: const EdgeInsets.symmetric(horizontal: 18.3),
            decoration: BoxDecoration(color: fc(0x91D4B6, .2), borderRadius: BorderRadius.circular(14.6)),
            child: Row(children: [
              const FigIcon('container_ad0f4161', w: 20, h: 20),
              const SizedBox(width: 11),
              Expanded(child: Text(s.location, style: ts(Ff.inter, 14.6, w400, AppColors.textPrimary, lh: 22))),
              if (_auto) const FigIcon('container_b6a6528e', w: 18.3, h: 18.3),
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
              const FigIcon('icon_ebe2a693', w: 16.5, h: 16.5),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _q,
                  onChanged: (v) {
                    if (_auto) setState(() => _auto = false);
                    _search(v);
                  },
                  style: ts(Ff.inter, 14.6, w400, AppColors.textPrimary),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: 'Type city, state or country',
                    hintStyle: ts(Ff.inter, 14.6, w400, AppColors.textMuted),
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
                child: Text('Start typing to see matching cities', style: ts(Ff.inter, 11, w400, AppColors.textMuted, lh: 14.6, ls: 0.5)),
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
                    Expanded(child: Text(c, style: ts(Ff.inter, 14, w400, AppColors.textPrimary, lh: 20))),
                  ]),
                ),
              ),
          const SizedBox(height: 7.3),
          Container(height: 0.9, color: const Color(0xFFE6E9E5)),
          const SizedBox(height: 22 + 3.7),
          FigButton(
            label: 'Save Location',
            height: 58.5,
            gap: 7.3,
            textStyle: ts(Ff.inter, 14.6, w400, Colors.white, lh: 22),
            trailing: const FigIcon('container_a12022d6', w: 12.2, h: 12.2),
            shadow: [fShadow(fc(0x000000, .1), 0, 3.7, 5.5, -3.7), fShadow(fc(0x000000, .1), 0, 9.1, 13.7, -2.7)],
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
