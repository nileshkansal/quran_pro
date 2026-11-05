import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/common.dart';
import 'settings_screen.dart';

/// Figma: "Audio & Recitation" (6021:121).
class AudioRecitationScreen extends StatefulWidget {
  const AudioRecitationScreen({super.key});

  @override
  State<AudioRecitationScreen> createState() => _AudioRecitationScreenState();
}

class _AudioRecitationScreenState extends State<AudioRecitationScreen> {
  final s = AppState.instance;
  static const _green = Color(0xFF0D5C46);
  static const _muted = Color(0xFFA3A3A3);
  static const _line = Color(0xFFF5F5F5);

  // Avatar tile styles for the non-selected reciters (fill, border, text).
  static const _tiles = [
    (Color(0xFFFFFBEB), Color(0x4DC99A3E), Color(0xFFC99A3E)),
    (Color(0xFFF8FAFC), Color(0xFFE2E8F0), Color(0xFF334155)),
    (Color(0xFFECFDF5), Color(0x330D5C46), Color(0xFF0D5C46)),
    (Color(0xFFF5F5F5), Color(0xFFE5E5E5), Color(0xFF404040)),
  ];

  void _set(VoidCallback f) => setState(() => s.update(f));

  TextStyle get _caps => ts(Ff.jakarta, 12, w700, const Color(0xFF262626), lh: 16, ls: 0.6);
  TextStyle get _title => ts(Ff.jakarta, 14, w600, const Color(0xFF171717), lh: 20);
  TextStyle get _sub => ts(Ff.jakarta, 12, w400, _muted, lh: 16);

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final selected = s.reciterIndex;
    final others = [for (var i = 0; i < kReciters.length; i++) if (i != selected) i];
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF6),
      body: Column(children: [
        Container(
          height: 64 + top,
          color: fc(0xF8FAF6, .8),
          padding: EdgeInsets.fromLTRB(24, top, 24, 0),
          child: Row(children: [
            GestureDetector(onTap: () => Navigator.maybePop(context), child: const FigIcon('button_margin_2fc59631', w: 32, h: 46)),
            const SizedBox(width: 53.8),
            Text('Audio & Recitation', style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
          ]),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Audio', style: ts(Ff.inter, 20, w700, AppColors.textPrimary, lh: 28, ls: -0.2)),
                  const SizedBox(height: 12),
                  Container(
                    height: 56,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [
                      Expanded(child: Text('Auto Play Next', style: ts(Ff.inter, 16, w400, AppColors.textPrimary, lh: 24))),
                      FigSwitch(value: s.autoPlayNext, onChanged: (v) => _set(() => s.autoPlayNext = v)),
                    ]),
                  ),
                ]),
              ),
              Container(
                color: const Color(0xFFFAFBFA),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('AUDIO PLAYBACK', style: _caps),
                      Text('Auto Sync', style: ts(Ff.jakarta, 11, w600, _green, lh: 16.5)),
                    ]),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: fc(0xF5F5F5, .9)), borderRadius: BorderRadius.circular(16)),
                    child: Column(children: [
                      SizedBox(
                        height: 52,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('Auto Play Next', style: _title),
                              const SizedBox(height: 2),
                              Text('Play consecutive Ayahs automatically', style: _sub),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: FigSwitch(value: s.autoPlayAyahs, onChanged: (v) => _set(() => s.autoPlayAyahs = v)),
                          ),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: _line))),
                        child: Row(children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('Repeat Ayah', style: _title),
                              const SizedBox(height: 2),
                              Text('Repetitions for memorization\n(Hifz)', style: _sub),
                            ]),
                          ),
                          Container(
                            height: 28,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(color: _line, borderRadius: BorderRadius.circular(8)),
                            child: Row(children: [
                              for (final r in const [1, 2, 3, 0])
                                GestureDetector(
                                  onTap: () => _set(() => s.repeatAyah = r),
                                  child: Container(
                                    height: 24,
                                    padding: EdgeInsets.symmetric(horizontal: r == 0 ? 8 : 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: s.repeatAyah == r ? Colors.white : null, borderRadius: BorderRadius.circular(6)),
                                    child: Text(r == 0 ? '∞' : '${r}x',
                                        style: ts(Ff.jakarta, 12, s.repeatAyah == r ? w700 : w600, s.repeatAyah == r ? _green : const Color(0xFF737373), lh: 16)),
                                  ),
                                ),
                            ]),
                          ),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 12),
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: _line))),
                        child: Row(children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('Audio Bitrate', style: _title),
                              const SizedBox(height: 2),
                              Text('Crystal High Definition (192 kbps)', style: _sub),
                            ]),
                          ),
                          Container(
                            height: 26,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F6F4),
                              border: Border.all(color: fc(0x0D5C46, .2)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('HQ Studio', style: ts(Ff.jakarta, 12, w600, _green, lh: 16)),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('RECITER SELECTION', style: _caps),
                          Text('Select voice for Ayah recitation', style: ts(Ff.jakarta, 11, w400, _muted, lh: 16.5)),
                        ]),
                      ),
                      Container(
                        height: 23,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBEB),
                          border: Border.all(color: fc(0xC99A3E, .3)),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text("Hafs 'an 'Asim", style: ts(Ff.jakarta, 11, w600, const Color(0xFFC99A3E), lh: 16.5)),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  _featured(kReciters[selected]),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: _line), borderRadius: BorderRadius.circular(16)),
                    child: Column(children: [
                      for (final (k, i) in others.indexed) _otherRow(i, _tiles[k % _tiles.length], first: k == 0),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  Material(
                    color: const Color(0xFFF0F6F4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: fc(0x0D5C46, .2))),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => showComingSoon(context, 'Full reciter catalogue'),
                      child: SizedBox(
                        height: 38,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('Explore All 35+ Qaris & Reciters', style: ts(Ff.jakarta, 12, w600, _green, lh: 16)),
                          const SizedBox(width: 8),
                          const FigIcon('svg_4e94cdc0', w: 14, h: 14),
                        ]),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _featured(Reciter r) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white, Color(0xFFF4F8F6)]),
          border: Border.all(color: _green, width: 2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: _green, spreadRadius: 1.5)],
        ),
        child: Column(children: [
          Row(children: [
            SizedBox(
              width: 52,
              height: 52,
              child: Stack(children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _green,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: fc(0xC99A3E, .4), spreadRadius: 2)],
                  ),
                  child: Text(r.arabicMark, textDirection: TextDirection.rtl, style: ts(Ff.amiri, 20, w700, const Color(0xFFF4EDE0), lh: 28)),
                ),
                const Positioned(left: 36, top: 36, child: FigIcon('active_status_pill_9d36663c', w: 16, h: 16)),
              ]),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(r.name, style: ts(Ff.jakarta, 14, w700, const Color(0xFF171717), lh: 17.5)),
                const SizedBox(height: 2),
                Text('مشاري بن راشد العفاسي', textDirection: TextDirection.rtl, style: ts(Ff.jakarta, 12, w600, _green, lh: 16)),
                Row(children: [
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(r.subtitle.split(' • ').skip(1).join(' • '),
                        maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(Ff.jakarta, 11, w400, const Color(0xFF737373), lh: 16.5)),
                  ),
                ]),
              ]),
            ),
            GestureDetector(onTap: () => showComingSoon(context, 'Preview playback'), child: const FigIcon('button_listen_preview_sample_e57bb17c', w: 36, h: 36)),
          ]),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: fc(0x0D5C46, .1)))),
            child: Row(children: [
              for (final h in const [8.0, 12.0, 6.0, 10.0]) ...[
                Container(width: 2, height: h, decoration: BoxDecoration(color: _green, borderRadius: BorderRadius.circular(9999))),
                const SizedBox(width: 2),
              ],
              const SizedBox(width: 4),
              Expanded(child: Text('Sample: Surah Al-Fatihah (0:42)', style: ts(Ff.jakarta, 11, w500, _green, lh: 16.5))),
              Text('DEFAULT', style: ts(Ff.jakarta, 12, w700, const Color(0xFFC99A3E), lh: 16)),
            ]),
          ),
        ]),
      );

  Widget _otherRow(int i, (Color, Color, Color) tile, {required bool first}) {
    final r = kReciters[i];
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _set(() => s.reciterIndex = i),
      child: Container(
        height: 60,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(border: first ? null : const Border(top: BorderSide(color: _line))),
        child: Row(children: [
          Container(
            width: 42,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: tile.$1, border: Border.all(color: tile.$2), borderRadius: BorderRadius.circular(12)),
            child: Text(r.arabicMark, textDirection: TextDirection.rtl, style: ts(Ff.amiri, 18, w700, tile.$3, lh: 28)),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(r.name, style: ts(Ff.jakarta, 12, w700, const Color(0xFF262626), lh: 16)),
              Text(r.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(Ff.jakarta, 11, w400, _muted, lh: 16.5)),
            ]),
          ),
          const FigIcon('container_90fdac8d', w: 52, h: 28),
        ]),
      ),
    );
  }
}
