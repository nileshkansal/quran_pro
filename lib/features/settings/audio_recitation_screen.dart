import 'package:flutter/material.dart';

import '../../core/state/app_state.dart';
import '../../data/mock_data.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Audio & Recitation" (6021:121).
class AudioRecitationScreen extends StatefulWidget {
  const AudioRecitationScreen({super.key});

  @override
  State<AudioRecitationScreen> createState() => _AudioRecitationScreenState();
}

class _AudioRecitationScreenState extends State<AudioRecitationScreen> {
  final s = AppState.instance;
  static const _green = AppColors.green600;
  static const _muted = AppColors.neutral400;
  static const _line = AppColors.neutral100;

  // Avatar tile styles for the non-selected reciters (fill, border, text).
  static final _tiles = [
    (AppColors.amber50, AppColors.gold48.o(.3), AppColors.gold48),
    (AppColors.slate50, AppColors.slate200, AppColors.slate700),
    (AppColors.emerald50, AppColors.green600.o(.2), AppColors.green600),
    (AppColors.neutral100, AppColors.stone200, AppColors.neutral700),
  ];

  void _set(VoidCallback f) => setState(() => s.update(f));

  TextStyle get _caps => ts(AppFonts.jakarta, 12, w700, AppColors.stone800, lh: 16, ls: 0.6);
  TextStyle get _title => ts(AppFonts.jakarta, 14, w600, AppColors.neutral900, lh: 20);
  TextStyle get _sub => AppTextStyles.jakartaCaption.c(_muted);

  @override
  Widget build(BuildContext context) {
    final selected = s.reciterIndex;
    final others = [for (var i = 0; i < kReciters.length; i++) if (i != selected) i];
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(children: [
        const AppHeader(
          title: 'Audio & Recitation',
          centerTitle: false,
          titleGap: 53.8,
          leading: AppBackButton(icon: 'button_margin_2fc59631', w: 32, h: 46),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Audio', style: AppTextStyles.title.c(AppColors.textPrimary)),
                  AppGap.v12,
                  Container(
                    height: 56,
                    padding: AppInsets.all16,
                    decoration: const BoxDecoration(color: AppColors.white, borderRadius: AppRadius.br12),
                    child: Row(children: [
                      Expanded(child: Text('Auto Play Next', style: AppTextStyles.body.c(AppColors.textPrimary))),
                      AppSwitch(value: s.autoPlayNext, onChanged: (v) => _set(() => s.autoPlayNext = v)),
                    ]),
                  ),
                ]),
              ),
              Container(
                color: AppColors.background,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Padding(
                    padding: AppInsets.h4,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('AUDIO PLAYBACK', style: _caps),
                      Text('Auto Sync', style: ts(AppFonts.jakarta, 11, w600, _green, lh: 16.5)),
                    ]),
                  ),
                  AppGap.v8,
                  Container(
                    padding: AppInsets.all16,
                    decoration: BoxDecoration(color: AppColors.white, border: Border.all(color: AppColors.neutral100.o(.9)), borderRadius: AppRadius.br16),
                    child: Column(children: [
                      SizedBox(
                        height: 52,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('Auto Play Next', style: _title),
                              AppGap.v2,
                              Text('Play consecutive Ayahs automatically', style: _sub),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: AppSwitch(value: s.autoPlayAyahs, onChanged: (v) => _set(() => s.autoPlayAyahs = v)),
                          ),
                        ]),
                      ),
                      Container(
                        padding: AppInsets.v12,
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: _line))),
                        child: Row(children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('Repeat Ayah', style: _title),
                              AppGap.v2,
                              Text('Repetitions for memorization\n(Hifz)', style: _sub),
                            ]),
                          ),
                          Container(
                            height: 28,
                            padding: AppInsets.all2,
                            decoration: const BoxDecoration(color: _line, borderRadius: AppRadius.br8),
                            child: Row(children: [
                              for (final r in const [1, 2, 3, 0])
                                GestureDetector(
                                  onTap: () => _set(() => s.repeatAyah = r),
                                  child: Container(
                                    height: 24,
                                    padding: EdgeInsets.symmetric(horizontal: r == 0 ? 8 : 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: s.repeatAyah == r ? AppColors.white : null, borderRadius: AppRadius.br6),
                                    child: Text(r == 0 ? '∞' : '${r}x',
                                        style: ts(AppFonts.jakarta, 12, s.repeatAyah == r ? w700 : w600, s.repeatAyah == r ? _green : AppColors.neutral500, lh: 16)),
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
                              AppGap.v2,
                              Text('Crystal High Definition (192 kbps)', style: _sub),
                            ]),
                          ),
                          Container(
                            height: 26,
                            padding: AppInsets.h8,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.grey04,
                              border: Border.all(color: AppColors.green600.o(.2)),
                              borderRadius: AppRadius.br6,
                            ),
                            child: Text('HQ Studio', style: AppTextStyles.jakartaCaptionSemibold.c(_green)),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                  AppGap.v20,
                  Padding(
                    padding: AppInsets.h4,
                    child: Row(children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('RECITER SELECTION', style: _caps),
                          Text('Select voice for Ayah recitation', style: AppTextStyles.jakartaSmall.c(_muted)),
                        ]),
                      ),
                      Container(
                        height: 23,
                        padding: AppInsets.h8,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.amber50,
                          border: Border.all(color: AppColors.gold48.o(.3)),
                          borderRadius: AppRadius.pill,
                        ),
                        child: Text("Hafs 'an 'Asim", style: ts(AppFonts.jakarta, 11, w600, AppColors.gold48, lh: 16.5)),
                      ),
                    ]),
                  ),
                  AppGap.v10,
                  _featured(kReciters[selected]),
                  AppGap.v10,
                  Container(
                    padding: AppInsets.all8,
                    decoration: BoxDecoration(color: AppColors.white, border: Border.all(color: _line), borderRadius: AppRadius.br16),
                    child: Column(children: [
                      for (final (k, i) in others.indexed) _otherRow(i, _tiles[k % _tiles.length], first: k == 0),
                    ]),
                  ),
                  AppGap.v10,
                  Material(
                    color: AppColors.grey04,
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.br12, side: BorderSide(color: AppColors.green600.o(.2))),
                    child: InkWell(
                      borderRadius: AppRadius.br12,
                      onTap: () => showComingSoon(context, 'Full reciter catalogue'),
                      child: SizedBox(
                        height: 38,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('Explore All 35+ Qaris & Reciters', style: AppTextStyles.jakartaCaptionSemibold.c(_green)),
                          AppGap.h8,
                          const AppIcon('svg_4e94cdc0', w: 14, h: 14),
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
        padding: AppInsets.all16,
        decoration: BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.white, AppColors.neutral100]),
          border: Border.all(color: _green, width: 2),
          borderRadius: AppRadius.br16,
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
                    borderRadius: AppRadius.br16,
                    boxShadow: [BoxShadow(color: AppColors.gold48.o(.4), spreadRadius: 2)],
                  ),
                  child: Text(r.arabicMark, textDirection: TextDirection.rtl, style: ts(AppFonts.amiri, 20, w700, AppColors.gold12, lh: 28)),
                ),
                const Positioned(left: 36, top: 36, child: AppIcon('active_status_pill_9d36663c', w: 16, h: 16)),
              ]),
            ),
            AppGap.h10,
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(r.name, style: ts(AppFonts.jakarta, 14, w700, AppColors.neutral900, lh: 17.5)),
                AppGap.v2,
                Text('مشاري بن راشد العفاسي', textDirection: TextDirection.rtl, style: AppTextStyles.jakartaCaptionSemibold.c(_green)),
                Row(children: [
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.emerald500, shape: BoxShape.circle)),
                  AppGap.h4,
                  Expanded(
                    child: Text(r.subtitle.split(' • ').skip(1).join(' • '),
                        maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.jakartaSmall.c(AppColors.neutral500)),
                  ),
                ]),
              ]),
            ),
            GestureDetector(onTap: () => showComingSoon(context, 'Preview playback'), child: const AppIcon('button_listen_preview_sample_e57bb17c', w: 36, h: 36)),
          ]),
          AppGap.v14,
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.green600.o(.1)))),
            child: Row(children: [
              for (final h in const [8.0, 12.0, 6.0, 10.0]) ...[
                Container(width: 2, height: h, decoration: const BoxDecoration(color: _green, borderRadius: AppRadius.pill)),
                AppGap.h2,
              ],
              AppGap.h4,
              Expanded(child: Text('Sample: Surah Al-Fatihah (0:42)', style: ts(AppFonts.jakarta, 11, w500, _green, lh: 16.5))),
              Text('DEFAULT', style: AppTextStyles.jakartaCaptionBold.c(AppColors.gold48)),
            ]),
          ),
        ]),
      );

  Widget _otherRow(int i, (Color, Color, Color) tile, {required bool first}) {
    final r = kReciters[i];
    return InkWell(
      borderRadius: AppRadius.br12,
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
            decoration: BoxDecoration(color: tile.$1, border: Border.all(color: tile.$2), borderRadius: AppRadius.br12),
            child: Text(r.arabicMark, textDirection: TextDirection.rtl, softWrap: false, overflow: TextOverflow.visible, style: ts(AppFonts.amiri, 18, w700, tile.$3, lh: 28)),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(r.name, style: AppTextStyles.jakartaCaptionBold.c(AppColors.stone800)),
              Text(r.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.jakartaSmall.c(_muted)),
            ]),
          ),
          const AppIcon('container_90fdac8d', w: 52, h: 28),
        ]),
      ),
    );
  }
}
