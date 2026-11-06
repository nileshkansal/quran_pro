import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show OverflowBoxFit;

import '../../core/assets.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock_data.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

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
          gradient: AppColors.pageGradient,
        ),
        child: Stack(children: [
          Positioned(top: top - 7, left: 71, width: 249, height: 166, child: Image.asset(AppImages.mosqueSilhouette, fit: BoxFit.cover)),
          Column(children: [
            // Header: 62px row, 24px padding, back · title · search.
            Padding(
              padding: EdgeInsets.fromLTRB(24, top + 10 + 8, 24, 8 + 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(onTap: () => Navigator.maybePop(context), child: const AppIcon('button_margin_35cdaed2', w: 32, h: 46)),
                Text('Quran Sanctuary', style: AppTextStyles.titleTight),
                const AppIcon('button_margin_437cb4d7', w: 32, h: 34),
              ]),
            ),
            const SizedBox(height: 21),
            _segmented(),
            AppGap.v24,
            Padding(
              padding: AppInsets.h24,
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: AppColors.white, border: Border.all(color: AppColors.outline), borderRadius: AppRadius.pill),
                child: Row(children: [
                  AppGap.h12,
                  const AppIcon('container_256d4634', w: 18, h: 18),
                  AppGap.h10,
                  Expanded(
                    child: TextField(
                      controller: _q,
                      onChanged: (v) => setState(() => _query = v.trim()),
                      cursorColor: AppColors.green700,
                      style: AppTextStyles.body.c(AppColors.textPrimary),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: _juz ? 'Search Juz' : 'Search Surah',
                        hintStyle: AppTextStyles.body.c(AppColors.textPrimary),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _q.clear();
                      _query = '';
                    }),
                    child: const Padding(padding: AppInsets.all8, child: AppIcon('container_f58cf768', w: 8.2, h: 8.2)),
                  ),
                  AppGap.h4,
                ]),
              ),
            ),
            AppGap.v24,
            Expanded(
              child: _juz
                  ? ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: juz.length,
                      separatorBuilder: (_, _) => AppGap.v6,
                      itemBuilder: (_, i) => _card(
                        height: 67,
                        child: Row(children: [
                          _badge(juz[i]),
                          AppGap.h16,
                          Expanded(child: Text('Juz ${juz[i]}', style: AppTextStyles.bodySemibold)),
                          const AppIcon('ic_round_navigate_next_541b0af5', w: 24, h: 24),
                        ]),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: surahs.length,
                      separatorBuilder: (_, _) => AppGap.v12,
                      itemBuilder: (_, i) => SurahTile(surah: surahs[i], onTap: _open),
                    ),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _card({required double height, required Widget child}) => Material(
        color: AppColors.white,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.br20, side: BorderSide(color: AppColors.surfaceDim)),
        child: InkWell(
          borderRadius: AppRadius.br20,
          onTap: _open,
          child: SizedBox(height: height, child: Padding(padding: AppInsets.all16, child: child)),
        ),
      );

  Widget _segmented() => Container(
        width: 320,
        height: 42,
        padding: AppInsets.all4,
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          border: Border.all(color: AppColors.surfaceDim),
          borderRadius: AppRadius.pill,
        ),
        child: Stack(children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            alignment: _juz ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(width: 151, height: 32, decoration: const BoxDecoration(gradient: AppColors.goldGradient, borderRadius: AppRadius.pill)),
          ),
          Row(children: [
            for (final (i, l) in ['Surahs', 'Juz'].indexed) ...[
              if (i > 0) AppGap.h8,
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
                    child: Text(l, style: ts(AppFonts.inter, 12, w500, (i == 1) == _juz ? AppColors.white : AppColors.textSecondary, lh: 16, ls: 0.6)),
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
        Image.asset(AppIcons.verseBadge, width: 32, height: 32, color: AppColors.pureBlack),
        Text('$n', style: ts(AppFonts.inter, n > 99 ? 11 : 16, w500, AppColors.pureBlack, lh: 21.3, ls: n > 9 ? 0 : 0.8)),
      ]),
    );

/// Surah card: 84px, r20, #ecefeb border.
class SurahTile extends StatelessWidget {
  const SurahTile({super.key, required this.surah, required this.onTap});
  final Surah surah;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final meta = AppTextStyles.caption;
    return Material(
      color: AppColors.white,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.br20, side: BorderSide(color: AppColors.surfaceDim)),
      child: InkWell(
        borderRadius: AppRadius.br20,
        onTap: onTap,
        child: SizedBox(
          height: 84,
          child: Padding(
            padding: AppInsets.all16,
            child: Row(children: [
              _badge(surah.number),
              AppGap.h16,
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(surah.name, style: AppTextStyles.bodySemibold),
                  AppGap.v4,
                  Text(surah.meaning, style: meta),
                ]),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  height: 31,
                  child: OverflowBox(
                    maxHeight: 56,
                    fit: OverflowBoxFit.deferToChild,
                    alignment: Alignment.centerRight,
                    child: Text(surah.arabic, textDirection: TextDirection.rtl, style: ts(AppFonts.amiri, 28, w400, AppColors.green800, lh: 56)),
                  ),
                ),
                const SizedBox(height: 3),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Text('verses ${surah.verses}', style: meta),
                  AppGap.h6,
                  Container(width: 4, height: 4, decoration: const BoxDecoration(color: AppColors.outline, shape: BoxShape.circle)),
                  AppGap.h6,
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
