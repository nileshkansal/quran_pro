import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/state/app_state.dart';
import '../../data/mock_data.dart';
import 'quran_sheets.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Surah Al-Mulk" (6044:2) Mushaf page, with the client's requested
/// interaction: long-press an ayah → it is highlighted and the
/// "Surah Al-Mulk (67:2)" popup (6001:6699) opens with the translation and
/// Tafsir · Play · Share underneath.
///
/// Note: exact Madani line breaks need per-page line data (Quran.com
/// `mushaf` layouts). Until that is wired in, verses flow as justified RTL text.
class MushafScreen extends StatefulWidget {
  const MushafScreen({super.key});

  @override
  State<MushafScreen> createState() => _MushafScreenState();
}

class _MushafScreenState extends State<MushafScreen> {
  int _page = 562;
  bool _bookmarked = false;
  int? _highlight;
  late final List<LongPressGestureRecognizer> _press = [
    for (final v in kMulkVerses) LongPressGestureRecognizer()..onLongPress = () => _onVerse(v),
  ];

  static const _ink = AppColors.grey95;
  static const _paper = AppColors.background;

  @override
  void dispose() {
    for (final r in _press) {
      r.dispose();
    }
    super.dispose();
  }

  Future<void> _onVerse(Verse v) async {
    HapticFeedback.selectionClick();
    setState(() => _highlight = v.number);
    await showVersePopup(context, v, surah: 'Al-Mulk', surahNo: 67);
    if (mounted) setState(() => _highlight = null);
  }

  @override
  Widget build(BuildContext context) {
    final size = 16.8 + (AppState.instance.fontScale - 0.5) * 6;
    final jak = ts(AppFonts.jakarta, 15, w400, AppColors.gray700, lh: 20);
    final nav = AppTextStyles.jakartaCaption.c(AppColors.stone600);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.pageGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(children: [
            // Authentic Mushaf top header: 44px, 20/16/20/8.
            SizedBox(
              height: 44,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                child: Row(children: [
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, size: 20, color: AppColors.gray700)),
                  Text('Surah Al-Mulk', style: jak.copyWith(letterSpacing: 0.4)),
                  const Spacer(),
                  Text('Juz\' 29, Hizb 57', style: jak),
                ]),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (d) {
                  final vx = d.primaryVelocity ?? 0;
                  if (vx.abs() > 200) setState(() => _page += vx > 0 ? 1 : -1);
                },
                child: Padding(
                  padding: AppInsets.h14,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(border: Border.all(color: AppColors.textPrimary), borderRadius: BorderRadius.circular(2)),
                    child: Container(
                      decoration: BoxDecoration(color: _paper, border: Border.all(color: AppColors.textPrimary), borderRadius: BorderRadius.circular(2)),
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(7, 7, 7, 16),
                        children: [
                          Padding(padding: const EdgeInsets.fromLTRB(2, 2, 2, 5), child: _surahTitle()),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 3.5, 0, 4.5),
                            child: Text('بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: ts(AppFonts.amiriQuran, 25, w400, AppColors.textPrimary, lh: 40, ls: 0.6)),
                          ),
                          Text.rich(
                            TextSpan(children: [
                              for (var i = 0; i < kMulkVerses.length; i++) ...[
                                TextSpan(
                                  text: '${kMulkVerses[i].arabic} ',
                                  recognizer: _press[i],
                                  style: TextStyle(backgroundColor: _highlight == kMulkVerses[i].number ? AppColors.gold.o(.22) : null),
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: GestureDetector(
                                    onLongPress: () => _onVerse(kMulkVerses[i]),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 1),
                                      child: AyahMarker(kMulkVerses[i].number),
                                    ),
                                  ),
                                ),
                                const TextSpan(text: ' '),
                              ],
                            ]),
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: ts(AppFonts.amiriQuran, size, w400, _ink, lh: 32.8 * size / 16.8 + 14, ls: -0.3),
                          ),
                          AppGap.v12,
                          Text('Long-press an ayah for translation, tafsir and sharing',
                              textAlign: TextAlign.center, style: ts(AppFonts.jakarta, 10, w400, AppColors.stone400)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Page number footer.
            SizedBox(
              height: 44,
              child: Center(child: Text('$_page', style: ts(AppFonts.jakarta, 18, w500, AppColors.stone700, lh: 28, ls: 0.9))),
            ),
            // Minimalist bottom reader nav: 47px.
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10 + MediaQuery.of(context).padding.bottom),
              decoration: BoxDecoration(
                color: AppColors.surface.o(.9),
                border: Border(top: BorderSide(color: AppColors.stone200.o(.8))),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  onTap: () => setState(() => _page--),
                  child: Row(children: [const AppIcon('svg_ce4537c1', w: 16, h: 16), AppGap.h6, Text('Page ${_page - 1}', style: nav)]),
                ),
                Row(children: [
                  GestureDetector(
                    onTap: () => showTafsirSheet(context, kMulkVerses[1], surah: 'Al-Mulk', ref: 'Al-Mulk 67'),
                    child: Container(
                      height: 26,
                      padding: AppInsets.h8,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.neutral100,
                        border: Border.all(color: AppColors.stone300),
                        borderRadius: AppRadius.br4,
                      ),
                      child: Text('Tafsir', style: ts(AppFonts.jakarta, 11, w500, AppColors.stone700, lh: 16)),
                    ),
                  ),
                  AppGap.h16,
                  GestureDetector(onTap: () => showComingSoon(context, 'Page recitation'), child: const AppIcon('button_d477c1f3', w: 24, h: 24)),
                  AppGap.h16,
                  GestureDetector(
                    onTap: () => setState(() => _bookmarked = !_bookmarked),
                    child: Opacity(opacity: _bookmarked ? 1 : 0.6, child: const AppIcon('button_496ab95d', w: 24, h: 24)),
                  ),
                ]),
                GestureDetector(
                  onTap: () => setState(() => _page++),
                  child: Row(children: [Text('Page ${_page + 1}', style: nav), AppGap.h6, const AppIcon('svg_0cfe70b4', w: 16, h: 16)]),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  /// Classical Madani surah title frame (377×47 with corner accents).
  Widget _surahTitle() {
    Widget corner() => Container(width: 6, height: 6, decoration: BoxDecoration(border: Border.all(color: AppColors.grey91)));
    return Container(
      height: 47,
      padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 1.5),
      decoration: BoxDecoration(color: _paper, border: Border.all(color: AppColors.grey91)),
      child: Stack(children: [
        Positioned(left: -1.5, top: -0.5, child: corner()),
        Positioned(right: -1.5, top: -0.5, child: corner()),
        Positioned(left: -1.5, bottom: -0.5, child: corner()),
        Positioned(right: -1.5, bottom: -0.5, child: corner()),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
          decoration: BoxDecoration(
            gradient: const RadialGradient(colors: [AppColors.white, AppColors.grey02]),
            border: Border.all(color: AppColors.grey84),
          ),
          child: Row(children: [
            const Opacity(opacity: 0.9, child: AppIcon('left_decorative_arabesque_ro_dbddbfbc', w: 48, h: 36)),
            Expanded(
              child: Center(
                child: Text('سُورَةُ المُلْكِ',
                    textDirection: TextDirection.rtl, style: ts(AppFonts.amiri, 24, w700, AppColors.grey96, lh: 30, ls: 1.2)),
              ),
            ),
            Transform.flip(flipX: true, child: const Opacity(opacity: 0.9, child: AppIcon('left_decorative_arabesque_ro_dbddbfbc', w: 48, h: 36))),
          ]),
        ),
      ]),
    );
  }
}
