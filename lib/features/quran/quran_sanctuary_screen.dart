import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/bottom_nav.dart';

enum ReadingMode { arabic, translation }

/// Figma: "Quran Sanctuary Surahs" (6001:4437) / "Juz" (6001:5476) / Arabic (6001:6451).
class QuranSanctuaryScreen extends StatefulWidget {
  const QuranSanctuaryScreen({super.key, this.mode = ReadingMode.translation});
  final ReadingMode mode;

  @override
  State<QuranSanctuaryScreen> createState() => _QuranSanctuaryScreenState();
}

class _QuranSanctuaryScreenState extends State<QuranSanctuaryScreen> {
  bool _juz = false;
  final _q = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _q.dispose();
    super.dispose();
  }

  void _open() => Navigator.of(context).pushNamed(widget.mode == ReadingMode.arabic ? AppRoutes.mushaf : AppRoutes.surahDetail);

  @override
  Widget build(BuildContext context) {
    final q = _query.toLowerCase();
    final surahs = kSurahs.where((s) => q.isEmpty || s.name.toLowerCase().contains(q) || s.meaning.toLowerCase().contains(q) || '${s.number}' == q).toList();
    final juz = [for (var j = 1; j <= 30; j++) j].where((j) => q.isEmpty || 'juz $j'.contains(q)).toList();
    final top = MediaQuery.of(context).padding.top;

    return Scaffold(
      bottomNavigationBar: const PushedBottomNav(),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF8FAF6), Colors.white]),
        ),
        child: Stack(children: [
          Positioned(top: top - 7, left: 71, width: 249, height: 166, child: Image.asset(AppImages.mosqueSilhouette, fit: BoxFit.cover)),
          Column(children: [
            // Header: 62px row, 24px padding, back · title · search.
            Padding(
              padding: EdgeInsets.fromLTRB(24, top + 10 + 8, 24, 8 + 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(onTap: () => Navigator.maybePop(context), child: const FigIcon('button_margin_35cdaed2', w: 32, h: 46)),
                Text('Quran Sanctuary', style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.5)),
                const FigIcon('button_margin_437cb4d7', w: 32, h: 34),
              ]),
            ),
            const SizedBox(height: 21),
            _segmented(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.outline), borderRadius: BorderRadius.circular(9999)),
                child: Row(children: [
                  const SizedBox(width: 12),
                  const FigIcon('container_256d4634', w: 18, h: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _q,
                      onChanged: (v) => setState(() => _query = v.trim()),
                      cursorColor: AppColors.green700,
                      style: ts(Ff.inter, 16, w400, AppColors.textPrimary, lh: 24),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: _juz ? 'Search Juz' : 'Search Surah',
                        hintStyle: ts(Ff.inter, 16, w400, AppColors.textPrimary, lh: 24),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _q.clear();
                      _query = '';
                    }),
                    child: const Padding(padding: EdgeInsets.all(8), child: FigIcon('container_f58cf768', w: 8.2, h: 8.2)),
                  ),
                  const SizedBox(width: 4),
                ]),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _juz
                  ? ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: juz.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 6),
                      itemBuilder: (_, i) => _card(
                        height: 67,
                        child: Row(children: [
                          _badge(juz[i]),
                          const SizedBox(width: 16),
                          Expanded(child: Text('Juz ${juz[i]}', style: ts(Ff.inter, 16, w600, AppColors.textPrimary, lh: 24))),
                          const FigIcon('ic_round_navigate_next_541b0af5', w: 24, h: 24),
                        ]),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: surahs.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (_, i) => SurahTile(surah: surahs[i], onTap: _open),
                    ),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _card({required double height, required Widget child}) => Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: AppColors.surfaceDim)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: _open,
          child: SizedBox(height: height, child: Padding(padding: const EdgeInsets.all(16), child: child)),
        ),
      );

  Widget _segmented() => Container(
        width: 320,
        height: 42,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          border: Border.all(color: AppColors.surfaceDim),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Stack(children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            alignment: _juz ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(width: 151, height: 32, decoration: BoxDecoration(gradient: AppColors.goldGradient, borderRadius: BorderRadius.circular(9999))),
          ),
          Row(children: [
            for (final (i, l) in ['Surahs', 'Juz'].indexed) ...[
              if (i > 0) const SizedBox(width: 8),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() {
                  _juz = i == 1;
                  _q.clear();
                  _query = '';
                }),
                child: SizedBox(
                  width: 151,
                  height: 32,
                  child: Center(
                    child: Text(l, style: ts(Ff.inter, 12, w500, (i == 1) == _juz ? Colors.white : AppColors.textSecondary, lh: 16, ls: 0.6)),
                  ),
                ),
              ),
            ],
          ]),
        ]),
      );
}

/// 32px verse-number badge (garden:check-badge-stroke) with Inter Medium 16.
Widget _badge(int n) => SizedBox(
      width: 32,
      height: 32,
      child: Stack(alignment: Alignment.center, children: [
        Image.asset(AppIcons.verseBadge, width: 32, height: 32, color: Colors.black),
        Text('$n', style: ts(Ff.inter, n > 99 ? 11 : 16, w500, Colors.black, lh: 21.3, ls: n > 9 ? 0 : 0.8)),
      ]),
    );

/// Surah card: 84px, r20, #ecefeb border.
class SurahTile extends StatelessWidget {
  const SurahTile({super.key, required this.surah, required this.onTap});
  final Surah surah;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final meta = ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16);
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: AppColors.surfaceDim)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: SizedBox(
          height: 84,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              _badge(surah.number),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(surah.name, style: ts(Ff.inter, 16, w600, AppColors.textPrimary, lh: 24)),
                  const SizedBox(height: 4),
                  Text(surah.meaning, style: meta),
                ]),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  height: 31,
                  child: OverflowBox(
                    maxHeight: 56,
                    alignment: Alignment.centerRight,
                    child: Text(surah.arabic, textDirection: TextDirection.rtl, style: ts(Ff.amiri, 28, w400, AppColors.green800, lh: 56)),
                  ),
                ),
                const SizedBox(height: 3),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Text('verses ${surah.verses}', style: meta),
                  const SizedBox(width: 6),
                  Container(width: 4, height: 4, decoration: const BoxDecoration(color: AppColors.outline, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text(surah.place, style: meta),
                ]),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
