import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../widgets/fig_widgets.dart';
import '../../widgets/sheets.dart';

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

  static const _ink = Color(0xFF1C1A17);
  static const _sub = Color(0xFF5F5850);
  static const _muted = Color(0xFF8C847A);
  static const _green = Color(0xFF0D5C3A);
  static const _line = Color(0xFFEFE7DC);
  static const _cream = Color(0xFFFFF8F3);
  static const _paper = Color(0xFFFAF5EE);

  BoxDecoration _card({Gradient? gradient, Color border = _line}) => BoxDecoration(
        color: gradient == null ? Colors.white : null,
        gradient: gradient,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(16),
      );

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final months = s.monthsToComplete;
    final done = DateTime.now().add(Duration(days: s.daysToComplete));
    const mon = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF6),
      body: Column(children: [
        Container(
          color: _cream,
          padding: EdgeInsets.fromLTRB(24, top + 8, 24, 8),
          child: Row(children: [
            _round('button_go_back_7053e066', () => Navigator.maybePop(context)),
            Expanded(
              child: Text('My Reading Plan', textAlign: TextAlign.center, style: ts(Ff.jakarta, 16, w700, _ink, lh: 24, ls: -0.4)),
            ),
            _round('button_reading_mode_d1c3f23f', () => Navigator.of(context).pushNamed(AppRoutes.dailyReading)),
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
                        boxShadow: [BoxShadow(color: fc(0xFAF3E0, .6), blurRadius: 48, spreadRadius: 10)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('Your plan', style: ts(Ff.jakarta, 19, w700, _ink, lh: 28.5, ls: -0.5)),
                            const SizedBox(height: 2),
                            Text('Daily Khatm companion pace', style: ts(Ff.jakarta, 12, w400, _sub, lh: 16)),
                          ]),
                        ),
                        const FigIcon('icon_7621331a', w: 14.5, h: 19),
                      ]),
                      const SizedBox(height: 16),
                      _planItem('background_border_76dacba1', 'Daily target', '${s.sectionsPerDay} sections per day', note: '~${s.dailyMinutes * 18 ~/ 5} mins'),
                      _divider(),
                      _planItem('background_border_e4e6b223', 'To complete the whole Quran', '${s.daysToComplete} days', chip: '1,280 sections total'),
                      _divider(),
                      _planItem('background_border_b988dee8', 'Estimated completion', '$months months', note: '${mon[done.month - 1]} ${done.year}'),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.only(top: 14),
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: _line))),
                        child: Row(children: [
                          Expanded(child: Text('Created on 1st Muharram', style: ts(Ff.jakarta, 12, w400, _muted, lh: 16))),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.dailyRecitation),
                            child: Row(children: [
                              Text('Recalculate target', style: ts(Ff.jakarta, 12, w600, _green, lh: 16)),
                              const FigIcon('margin_c45e118c', w: 6.5, h: 7.5),
                            ]),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              // TODAY'S RECITATION
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _card(),
                child: Column(children: [
                  Row(children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: _green, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Expanded(child: Text("TODAY'S RECITATION", style: ts(Ff.jakarta, 12, w700, _ink, lh: 16, ls: 0.6))),
                    Container(
                      height: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: const Color(0xFFEBF4F0), borderRadius: BorderRadius.circular(9999)),
                      child: Text('2 of ${s.sectionsPerDay} Done', style: ts(Ff.jakarta, 12, w700, _green, lh: 16)),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    for (var i = 0; i < s.sectionsPerDay; i++) ...[
                      if (i > 0) const SizedBox(width: 6),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: i < 2 ? _green : _paper,
                            border: i < 2 ? null : Border.all(color: _line),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                      ),
                    ],
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Up Next: Surah Al-Baqarah', style: ts(Ff.jakarta, 12, w400, _sub, lh: 16)),
                        const SizedBox(height: 1),
                        Text('Section 3 • ~6 mins remaining', style: ts(Ff.jakarta, 11, w400, _muted, lh: 16.5)),
                      ]),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.dailyReading),
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D3829),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [fShadow(fc(0x0D5C3A, .3), 0, 8, 20, -4)],
                        ),
                        child: Row(children: [
                          const FigIcon('container_86e2efd5', w: 6.8, h: 8.8),
                          const SizedBox(width: 6),
                          Text('Recite Now', style: ts(Ff.jakarta, 12, w700, Colors.white, lh: 16)),
                        ]),
                      ),
                    ),
                  ]),
                ]),
              ),
              const SizedBox(height: 16),
              // OVERALL KHATM JOURNEY
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _card(),
                child: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Overall Khatm Journey', style: ts(Ff.jakarta, 14, w700, _ink, lh: 20)),
                        const SizedBox(height: 2),
                        Text('Juz 4 of 30 in progress', style: ts(Ff.jakarta, 12, w400, _sub, lh: 16)),
                      ]),
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('13.3%', style: ts(Ff.jakarta, 16, w800, _green, lh: 24)),
                      Text('81 of 604 pages', style: ts(Ff.jakarta, 11, w400, _muted, lh: 16.5)),
                    ]),
                  ]),
                  const SizedBox(height: 12),
                  Container(
                    height: 10,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(color: _paper, border: Border.all(color: _line), borderRadius: BorderRadius.circular(9999)),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.133,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [_green, _green, Color(0xFFD4A349)], stops: [0, .5, 1]),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(children: [
                    _milestone('NEXT\nMILESTONE', 'Juz 5 Finish'),
                    const SizedBox(width: 8),
                    _milestone('PACE', '+2 Days\nAhead', green: true),
                    const SizedBox(width: 8),
                    _milestone('TOTAL TIME', '28h 40m'),
                  ]),
                ]),
              ),
              const SizedBox(height: 16),
              // ROUTINE & PREFERENCES
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _card(),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: _line))),
                    child: Row(children: [
                      Expanded(child: Text('Routine & Preferences', style: ts(Ff.jakarta, 14, w700, _ink, lh: 20))),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(AppRoutes.readingSettings),
                        child: const FigIcon('container_76b16c83', w: 13.9, h: 14.4),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 12),
                  _pref('background_66158b30', 'Daily Reminders', 'After Fajr (05:45) & Isha (20:30)',
                      _toggle(s.dailyReminder, (v) => setState(() => s.update(() => s.dailyReminder = v)))),
                  const SizedBox(height: 8),
                  _pref('background_10063977', 'Recitation Mode', 'Tarteel (Meditative pace with audio)',
                      const FigIcon('button_d7a11271', w: 8.5, h: 20.4),
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.audioRecitation)),
                  const SizedBox(height: 8),
                  _pref('background_db690065', 'Automatic Catch-up', 'Redistribute missed sections gracefully',
                      _toggle(_catchUp, (v) => setState(() => _catchUp = v))),
                ]),
              ),
              const SizedBox(height: 16),
              // Quote
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _card(
                  border: fc(0xEED9AD, .6),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFFFDF8ED), Colors.white, fc(0xFAF3E0, .4)],
                  ),
                ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Padding(padding: EdgeInsets.only(top: 2), child: FigIcon('margin_bdf4fe15', w: 14, h: 11.9)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        '“The most beloved of deeds to Allah are those that are\nmost consistent, even if they are small.”',
                        style: ts(Ff.cormorant, 13, w600, _ink, lh: 19.5, style: FontStyle.italic),
                      ),
                      const SizedBox(height: 3),
                      Text('Sahih al-Bukhari 6464', style: ts(Ff.jakarta, 11, w700, const Color(0xFFB88328), lh: 16.5)),
                    ]),
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    setState(() => _paused = !_paused);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_paused ? 'Plan paused' : 'Plan resumed')));
                  },
                  child: Text(_paused ? 'Resume Plan' : 'Pause Plan', style: ts(Ff.jakarta, 12, w500, _muted, lh: 16)),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text('•', style: ts(Ff.jakarta, 12, w500, _muted, lh: 16))),
                GestureDetector(
                  onTap: () => _confirmReset(context),
                  child: Text('Reset Journey', style: ts(Ff.jakarta, 12, w500, _muted, lh: 16)),
                ),
              ]),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _round(String icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: _line)),
          child: FigIcon(icon, w: 40, h: 40),
        ),
      );

  Widget _divider() => Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 16), color: _paper);

  Widget _planItem(String icon, String label, String value, {String? note, String? chip}) => SizedBox(
        height: 44,
        child: Row(children: [
          FigIcon(icon, w: 44, h: 44),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(label, style: ts(Ff.jakarta, 12, w500, _sub, lh: 16)),
              const SizedBox(height: 2),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(value, style: ts(Ff.jakarta, 14, w700, _ink, lh: 20)),
                const SizedBox(width: 8),
                if (note != null) Text(note, style: ts(Ff.jakarta, 11, w400, _muted, lh: 16.5)),
                if (chip != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(color: const Color(0xFFEBF4F0), borderRadius: BorderRadius.circular(4)),
                    child: Text(chip, style: ts(Ff.jakarta, 11, w500, _green, lh: 16.5)),
                  ),
              ]),
            ]),
          ),
        ]),
      );

  Widget _milestone(String label, String value, {bool green = false}) => Expanded(
        child: Container(
          height: 71,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: _cream, border: Border.all(color: fc(0xEFE7DC, .6)), borderRadius: BorderRadius.circular(12)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(label, textAlign: TextAlign.center, style: ts(Ff.jakarta, 10, w600, _muted, lh: 15, ls: 0.3)),
            const SizedBox(height: 2),
            Text(value, textAlign: TextAlign.center, style: ts(Ff.jakarta, 12, w700, green ? _green : _ink, lh: 16)),
          ]),
        ),
      );

  Widget _pref(String icon, String title, String sub, Widget trailing, {VoidCallback? onTap}) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 54,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: _cream, border: Border.all(color: fc(0xEFE7DC, .5)), borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            FigIcon(icon, w: 32, h: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(title, style: ts(Ff.jakarta, 12, w700, _ink, lh: 16)),
                Text(sub, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(Ff.jakarta, 11, w400, _sub, lh: 16.5)),
              ]),
            ),
            trailing,
          ]),
        ),
      );

  /// 36×20 pill toggle (#0d5c3a on), 16px knob.
  Widget _toggle(bool v, ValueChanged<bool> onChanged) => GestureDetector(
        onTap: () => onChanged(!v),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 36,
          height: 20,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(color: v ? _green : _line, borderRadius: BorderRadius.circular(9999)),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            alignment: v ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
          ),
        ),
      );

  void _confirmReset(BuildContext context) => showAppDialog(
        context,
        builder: (ctx) => Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Reset your journey?', style: ts(Ff.jakarta, 18, w700, _ink, lh: 26)),
          const SizedBox(height: 10),
          Text('Your Khatm progress will start again from Al-Fatihah.', textAlign: TextAlign.center, style: ts(Ff.jakarta, 14, w400, _sub, lh: 20)),
          const SizedBox(height: 20),
          FigButton(label: 'Reset', height: 46, onTap: () => Navigator.pop(ctx)),
          const SizedBox(height: 10),
          FigButton(label: 'Cancel', height: 46, style: FigButtonStyle.outline, onTap: () => Navigator.pop(ctx)),
        ]),
      );
}
