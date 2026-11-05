import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/figma.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/common.dart';
import '../../widgets/fig_widgets.dart';

const _gray = Color(0xFF4A5568);

/// White r40 card over a barrier (#000 @40% or #03261c @60% + blur).
Future<T?> _figModal<T>(BuildContext context, Widget card, {bool greenBlur = false, bool bottom = false}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'close',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (ctx, a, _) => Stack(children: [
      Positioned.fill(
        child: GestureDetector(
          onTap: () => Navigator.pop(ctx),
          child: FadeTransition(
            opacity: a,
            child: greenBlur
                ? BackdropFilter(filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), child: Container(color: fc(0x03261C, .6)))
                : Container(color: fc(0x000000, .4)),
          ),
        ),
      ),
      if (bottom)
        Align(
          alignment: Alignment.bottomCenter,
          child: SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
            child: Material(type: MaterialType.transparency, child: card),
          ),
        )
      else
        Center(
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: a, curve: Curves.easeOut)),
            child: FadeTransition(opacity: a, child: Material(type: MaterialType.transparency, child: card)),
          ),
        ),
    ]),
  );
}

Widget _sheetTitle(String title, String sub) => SizedBox(
      height: 44,
      child: Column(children: [
        Text(title, textAlign: TextAlign.center, style: ts(Ff.inter, 16, w600, AppColors.textPrimary, lh: 24)),
        const SizedBox(height: 4),
        Text(sub, style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16)),
      ]),
    );

Widget _sheetButton(String label, VoidCallback onTap, {bool outline = false, Widget? trailing}) => FigButton(
      label: label,
      onTap: onTap,
      height: 50,
      style: outline ? FigButtonStyle.outline : FigButtonStyle.gold,
      borderColor: outline ? AppColors.gold : null,
      textStyle: ts(Ff.inter, 12, w500, outline ? AppColors.green700 : Colors.white, lh: 16, ls: 0.6),
      trailing: trailing,
      shadow: [fShadow(fc(0x000000, .1), 0, 2, 4, -2), fShadow(fc(0x000000, .1), 0, 4, 6, -1)],
    );

// ───────────────────────────── Tafsir ─────────────────────────────

/// Figma: "Tafsir Screen" (6001:5747) — sheet from y135, r40.
Future<void> showTafsirSheet(BuildContext context, Verse verse, {String surah = 'Al Baqara', String ref = 'Al-Baqarah 2'}) =>
    _figModal(context, _TafsirSheet(verse: verse, surah: surah, ref: ref), bottom: true);

class _TafsirSheet extends StatefulWidget {
  const _TafsirSheet({required this.verse, required this.surah, required this.ref});
  final Verse verse;
  final String surah;
  final String ref;

  @override
  State<_TafsirSheet> createState() => _TafsirSheetState();
}

class _TafsirSheetState extends State<_TafsirSheet> {
  int _tab = 0;
  static const _tabs = [('Ibn Kathir (Abridged)', 136.0, 9.0), ('Ma\'arif Al-Qur\'an', 79.0, 9.0), ('Tazkirul Quran', 79.0, 10.0)];

  @override
  Widget build(BuildContext context) {
    final name = _tabs[_tab].$1.split(' (').first;
    final body = ts(Ff.inter, 10, w400, AppColors.textSecondary, lh: 16);
    return Container(
      height: MediaQuery.of(context).size.height - 135,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
      child: ListView(
        padding: EdgeInsets.fromLTRB(18, 20, 16, 20 + MediaQuery.of(context).padding.bottom),
        children: [
          _sheetTitle('Tafsir', '${widget.surah} — Verse ${widget.verse.number}'),
          const SizedBox(height: 30),
          Center(
            child: SizedBox(
              width: 258,
              child: Text(widget.verse.arabic,
                  textAlign: TextAlign.center, textDirection: TextDirection.rtl, style: ts(Ff.amiri, 17, w700, AppColors.green800, lh: 42)),
            ),
          ),
          const SizedBox(height: 17),
          Center(
            child: Container(
              width: 320,
              height: 42,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                border: Border.all(color: AppColors.surfaceDim),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (final (i, t) in _tabs.indexed) ...[
                  if (i > 0) const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => setState(() => _tab = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: t.$2,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(gradient: i == _tab ? AppColors.goldGradient : null, borderRadius: BorderRadius.circular(9999)),
                      child: Text(t.$1,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: ts(Ff.inter, t.$3, w500, i == _tab ? Colors.white : AppColors.textSecondary, lh: 16, ls: 0.6)),
                    ),
                  ),
                ],
              ]),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: AppColors.surfaceDim, borderRadius: BorderRadius.circular(19)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const FigIcon('si_ai_alt_1_fill_5c6374bb', w: 24, h: 24),
                const SizedBox(width: 9),
                Text('AI summary', style: ts(Ff.inter, 12, w600, AppColors.textPrimary, lh: 24)),
              ]),
              const SizedBox(height: 12),
              Text(kTafsirAiSummary, style: body),
            ]),
          ),
          const SizedBox(height: 20),
          Row(children: [
            const FigIcon('bi_book_c31c98dc', w: 20, h: 20),
            const SizedBox(width: 9),
            Text('Tafsir $name Explantion', style: ts(Ff.inter, 12, w600, AppColors.textPrimary, lh: 24)),
          ]),
          const SizedBox(height: 6),
          Text(_tab == 0 ? kTafsirIbnKathir : 'Commentary from ${_tabs[_tab].$1} appears here once the tafsir source is connected (Quran.com API).',
              style: body),
          const SizedBox(height: 30),
          Container(height: 1, color: fc(0x000000, .1)),
          const SizedBox(height: 30),
          Row(children: [
            const FigIcon('frame_2085667711_617a1a3c', w: 48, h: 48),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Source: Tafsir $name', style: ts(Ff.inter, 16, w600, AppColors.textPrimary, lh: 24)),
              const SizedBox(height: 4),
              Text('${widget.ref}:${widget.verse.number}', style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16)),
            ]),
          ]),
          const SizedBox(height: 30),
          _sheetButton('Close', () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

// ───────────────────────────── Share ─────────────────────────────

/// Figma: "Share" (6001:6094) — 359×599 card, r40, #000 @40% barrier.
Future<void> showShareSheet(BuildContext context, Verse verse) => _figModal(context, _ShareCard(verse: verse));

class _ShareCard extends StatefulWidget {
  const _ShareCard({required this.verse});
  final Verse verse;

  @override
  State<_ShareCard> createState() => _ShareCardState();
}

class _ShareCardState extends State<_ShareCard> {
  bool _group = true;
  int _include = 0;
  int? _from;
  int? _to;

  Widget _radio(String label, bool on, VoidCallback tap) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: tap,
        child: SizedBox(
          height: 24,
          child: Row(children: [
            FigIcon(on ? 'fluent_radio_button_24_fille_269e9c88' : 'fluent_radio_button_24_fille_d02f2271', w: 24, h: 24),
            const SizedBox(width: 11),
            Text(label, style: ts(Ff.inter, 12, w600, AppColors.textPrimary, lh: 24)),
          ]),
        ),
      );

  BoxDecoration get _box => BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(19), boxShadow: [fShadow(fc(0x000000, .06), 0, 0, 24)]);

  Widget _picker(String label, int? value, ValueChanged<int?> onChanged) => Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16)),
          const SizedBox(height: 7),
          Container(
            height: 43.5,
            padding: const EdgeInsets.fromLTRB(12.8, 0, 13, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: fc(0xBFC9C2, .3), width: 0.7),
              borderRadius: BorderRadius.circular(11.4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                isExpanded: true,
                value: value,
                hint: Text('Select verse', style: ts(Ff.inter, 11.4, w400, AppColors.textPrimary, lh: 17.1)),
                icon: const RotatedBox(quarterTurns: 1, child: FigIcon('ic_round_navigate_next_fd7b0252', w: 19.3, h: 19.3)),
                style: ts(Ff.inter, 11.4, w400, AppColors.textPrimary, lh: 17.1),
                items: [for (var v = 1; v <= 30; v++) DropdownMenuItem(value: v, child: Text('Verse $v'))],
                onChanged: onChanged,
              ),
            ),
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    const includes = ['Arabic text with translation', 'Arabic text only', 'Translation only'];
    return Container(
      width: 359,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 80),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 29.5),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _sheetTitle('Share', 'What would you like to share?'),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: _box,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _radio('This verse only', !_group, () => setState(() => _group = false)),
              const SizedBox(height: 20),
              Container(height: 1, color: fc(0x000000, .1)),
              const SizedBox(height: 20),
              _radio('Group of verses', _group, () => setState(() => _group = true)),
              const SizedBox(height: 15),
              Opacity(
                opacity: _group ? 1 : 0.4,
                child: IgnorePointer(
                  ignoring: !_group,
                  child: Row(children: [
                    _picker('From', _from, (v) => setState(() => _from = v)),
                    const SizedBox(width: 14),
                    _picker('To', _to, (v) => setState(() => _to = v)),
                  ]),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: _box,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Include in share', style: ts(Ff.inter, 14, w600, AppColors.textPrimary, lh: 24)),
              for (final (i, t) in includes.indexed) ...[
                const SizedBox(height: 20),
                _radio(t, _include == i, () => setState(() => _include = i)),
              ],
            ]),
          ),
          const SizedBox(height: 30),
          Row(children: [
            Expanded(child: _sheetButton('Cancel', () => Navigator.pop(context), outline: true)),
            const SizedBox(width: 20),
            Expanded(
              child: _sheetButton('Share', () {
                Navigator.pop(context);
                showComingSoon(context, 'System share');
              }, trailing: const FigIcon('container_9d18190a', w: 12, h: 12)),
            ),
          ]),
        ]),
      ),
    );
  }
}

// ─────────────────────── Verse popup (Arabic reading) ───────────────────────

/// Figma: "Surah AI-Mulk (67:2)" (6001:6699) — opened by long-pressing an ayah.
/// Shows the ayah, its translation, and Tafsir · Play · Share underneath.
Future<void> showVersePopup(BuildContext context, Verse verse, {required String surah, required int surahNo}) {
  return _figModal(
    context,
    Builder(
      builder: (ctx) => Container(
        width: 359,
        padding: const EdgeInsets.fromLTRB(16, 34.8, 16, 34.8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Stack(children: [
            Center(child: _sheetTitle('Surah $surah ($surahNo:${verse.number})', 'What would you like to share?')),
            Positioned(right: 0, top: 0, child: GestureDetector(onTap: () => Navigator.pop(ctx), child: const FigIcon('circle_x_0bdf2e26', w: 24, h: 24))),
          ]),
          const SizedBox(height: 30),
          Text('بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ', textDirection: TextDirection.rtl, style: ts(Ff.amiriQuran, 21, w400, const Color(0xFF19332C), lh: 34.1)),
          const SizedBox(height: 5),
          Text.rich(
            TextSpan(children: [
              TextSpan(text: '${verse.arabic} '),
              WidgetSpan(alignment: PlaceholderAlignment.middle, child: AyahMarker(verse.number, size: 24, popupStyle: true)),
            ]),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: ts(Ff.amiriQuran, 20.5, w400, const Color(0xFF171A1C), lh: 48.8),
          ),
          const SizedBox(height: 30),
          Text(verse.translation, textAlign: TextAlign.center, style: ts(Ff.inter, 14.2, w500, _gray, lh: 21.2)),
          const SizedBox(height: 30),
          Container(height: 1, color: fc(0x000000, .1)),
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _popupAction('bi_book_717239de', 'Tafsir', () {
              Navigator.pop(ctx);
              showTafsirSheet(context, verse, surah: 'Al-Mulk', ref: 'Al-Mulk 67');
            }),
            Container(width: 1.1, height: 8.5, color: Colors.black),
            _popupAction('fluent_play_16_regular_175084d1', 'Play', () {
              Navigator.pop(ctx);
              showComingSoon(context, 'Recitation');
            }),
            Container(width: 1.1, height: 8.5, color: Colors.black),
            _popupAction('basil_share_outline_196887ab', 'Share', () {
              Navigator.pop(ctx);
              showShareSheet(context, verse);
            }),
          ]),
        ]),
      ),
    ),
    greenBlur: true,
  );
}

Widget _popupAction(String icon, String label, VoidCallback onTap) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(children: [
        FigIcon(icon, w: 17, h: 17),
        const SizedBox(width: 10.6),
        Text(label, style: ts(Ff.inter, 12.7, w500, AppColors.textSecondary, lh: 17)),
      ]),
    );

/// Ayah end marker (ornamental circle + Arabic-Indic numeral).
class AyahMarker extends StatelessWidget {
  const AyahMarker(this.number, {super.key, this.size = 25, this.popupStyle = false});
  final int number;
  final double size;
  final bool popupStyle;

  static String arabicDigits(int n) {
    const d = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return n.toString().split('').map((c) => d[int.parse(c)]).join();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: Stack(alignment: Alignment.center, children: [
          FigIcon(popupStyle ? 'svg_0d98e1ed' : 'svg_8d9beb49', w: size, h: size),
          Text(
            arabicDigits(number),
            textDirection: TextDirection.rtl,
            style: popupStyle
                ? ts(Ff.amiri, 11, w700, const Color(0xFF1A3830), lh: 14)
                : ts(Ff.scheherazade, 11.5, w700, const Color(0xFF111827), lh: 11.5, ls: -0.3),
          ),
        ]),
      );
}

// ───────────────────────────── Audio bar ─────────────────────────────

/// Figma: "AI Baqara Audio Play" mini-player — 390×111, #f9fbf8, top r20.
class AudioPlayerBar extends StatelessWidget {
  const AudioPlayerBar({
    super.key,
    required this.title,
    required this.reciter,
    required this.playing,
    required this.progress,
    required this.onToggle,
    required this.onPrev,
    required this.onNext,
    required this.onClose,
    this.total = const Duration(minutes: 3, seconds: 31),
  });

  final String title;
  final String reciter;
  final bool playing;
  final double progress;
  final VoidCallback onToggle;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onClose;
  final Duration total;

  String _fmt(Duration d) => '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final remain = total - Duration(seconds: (total.inSeconds * progress).round());
    final time = ts(Ff.montserrat, 10, w700, AppColors.textPrimary);
    return Container(
      height: 111,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Color(0xFFF9FBF8), borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(children: [
        SizedBox(
          height: 46,
          child: Row(children: [
            GestureDetector(
              onTap: onClose,
              child: const RotatedBox(quarterTurns: 3, child: FigIcon('ic_round_navigate_next_537605d0', w: 30, h: 30)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Row(children: [
                  ClipOval(child: Image.asset(AppImages.reciter, width: 46, height: 46, fit: BoxFit.cover)),
                  const SizedBox(width: 7),
                  SizedBox(
                    width: 128,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(title, maxLines: 1, style: ts(Ff.inter, 12, w600, AppColors.textPrimary, lh: 24)),
                      Text(reciter, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16)),
                    ]),
                  ),
                ]),
                SizedBox(
                  width: 108,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    GestureDetector(onTap: onPrev, child: const FigIcon('vector_82650e71', w: 12.9, h: 12.9)),
                    const SizedBox(width: 25),
                    GestureDetector(
                      onTap: onToggle,
                      child: playing
                          ? const FigIcon('frame_2085667691_e364f79f', w: 29, h: 29)
                          : Container(
                              width: 29,
                              height: 29,
                              decoration: const BoxDecoration(color: AppColors.textPrimary, shape: BoxShape.circle),
                              child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
                            ),
                    ),
                    const SizedBox(width: 25),
                    GestureDetector(
                      onTap: onNext,
                      child: Transform.flip(flipX: true, child: const FigIcon('vector_82650e71', w: 12.9, h: 12.9)),
                    ),
                  ]),
                ),
              ]),
            ),
          ]),
        ),
        const SizedBox(height: 15),
        LayoutBuilder(builder: (context, c) {
          final w = c.maxWidth;
          return SizedBox(
            height: 26,
            child: Stack(clipBehavior: Clip.none, children: [
              Positioned(
                top: 0.5,
                left: 0,
                right: 0,
                child: Container(height: 5, decoration: BoxDecoration(color: fc(0x8B8787, .5), borderRadius: BorderRadius.circular(50))),
              ),
              Positioned(
                top: 0.5,
                left: 0,
                width: w * progress,
                child: Container(height: 5, decoration: BoxDecoration(color: AppColors.textPrimary, borderRadius: BorderRadius.circular(50))),
              ),
              Positioned(
                top: -3,
                left: (w * progress - 5.5).clamp(0, w - 11),
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(color: AppColors.textPrimary, shape: BoxShape.circle, border: Border.all(color: Colors.white)),
                ),
              ),
              Positioned(left: 0, top: 12, child: Text(_fmt(total), style: time)),
              Positioned(right: 0, top: 12, child: Text('-${_fmt(remain)}', style: time)),
            ]),
          );
        }),
      ]),
    );
  }
}
