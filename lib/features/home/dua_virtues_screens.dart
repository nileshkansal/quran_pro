import 'package:flutter/material.dart';

import '../../core/state/app_state.dart';
import '../../data/dua_data.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';
import '../../core/assets.dart';

const _pageBg = AppColors.gold04;
const _openFill = AppColors.olive10;

/// Header row shared by Dua / Virtues: back (32×46) and optional EN pill.
class _Header extends StatelessWidget {
  const _Header({this.showLanguage = false});
  final bool showLanguage;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 10 + 8, 24, 18),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(onTap: () => Navigator.maybePop(context), child: const AppIcon('button_margin_35cdaed2', w: 32, h: 46)),
          if (showLanguage)
            Container(
              height: 33.1,
              padding: AppInsets.all8,
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.outline, width: 0.5),
                borderRadius: BorderRadius.circular(85.7),
                boxShadow: [fShadow(AppColors.pureBlack.o(.2), 0, 1.1, 5.9)],
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const AppIcon('icon_9cbf6340', w: 16, h: 16),
                AppGap.h6,
                Text(AppState.instance.appLanguage.locale.languageCode.toUpperCase(),
                    style: ts(AppFonts.inter, 8.6, w400, AppColors.textPrimary, lh: 12.9)),
                AppGap.h8,
                const AppIcon('vector_84d0c01e', w: 6.8, h: 3.4),
              ]),
            ),
        ]),
      );
}

Widget _chip(String text, Color fill) => Container(
      width: 36.4,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: fill, borderRadius: AppRadius.br8),
      child: Text(text, style: ts(AppFonts.inter, 9.6, w700, AppColors.pureBlack, lh: 16.8, ls: -0.1)),
    );

/// Collapsible category card (44px row; opens into a white card with sub-rows).
class _Accordion extends StatelessWidget {
  const _Accordion({required this.number, required this.title, required this.open, required this.onToggle, required this.children, this.icon, this.iconW = 16});
  final String number;
  final String title;
  final bool open;
  final VoidCallback onToggle;
  final List<Widget> children;
  final String? icon;
  final double iconW;

  @override
  Widget build(BuildContext context) {
    final head = InkWell(
      onTap: onToggle,
      child: Container(
        height: 44,
        color: open ? _openFill : null,
        padding: const EdgeInsets.fromLTRB(8, 0, 22, 0),
        child: Row(children: [
          _chip(number, open ? AppColors.white.o(.5) : AppColors.divider.o(.5)),
          AppGap.h10,
          if (icon != null) ...[AppIcon(icon!, w: iconW, h: 16), AppGap.h10],
          Expanded(child: Text(title, style: AppTextStyles.bodySmallSemibold)),
          AnimatedRotation(
            turns: open ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const RotatedBox(quarterTurns: 1, child: AppIcon('container_f11ba571', w: 8, h: 12)),
          ),
        ]),
      ),
    );
    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: open ? null : Border.all(color: AppColors.stone200),
        ),
        clipBehavior: Clip.antiAlias,
        padding: open ? const EdgeInsets.only(top: 8, bottom: 8) : EdgeInsets.zero,
        child: Column(children: [head, if (open) ...children]),
      ),
    );
  }
}

Widget _subRow(Widget lead, String title, VoidCallback onTap, {bool divider = true}) => Column(children: [
      AppGap.v8,
      InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 270,
          height: 24,
          child: Row(children: [lead, AppGap.h10, Text(title, style: AppTextStyles.bodySmallSemibold)]),
        ),
      ),
      AppGap.v8,
      if (divider) Container(height: 1, color: _openFill),
    ]);

/// Popup card (359 wide, r40) over the blurred green backdrop.
Future<void> _showDetail(BuildContext context, Widget child) => showAppModal(
      context,
      barrier: AppBarrier.greenBlur,
      duration: const Duration(milliseconds: 240),
      child: Material(color: AppColors.white, borderRadius: AppRadius.br40, child: SizedBox(width: 359, child: child)),
    );

// ───────────────────────────── Dua ─────────────────────────────

/// Figma: Dua list (6001:4898) + "Entering the home" popup (6001:5065).
class DuaScreen extends StatefulWidget {
  const DuaScreen({super.key});

  @override
  State<DuaScreen> createState() => _DuaScreenState();
}

class _DuaScreenState extends State<DuaScreen> {
  int _open = 3;

  void _detail(DuaItem d) {
    _showDetail(
      context,
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 24.3, 16, 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            AppGap.h24,
            Expanded(child: Text(d.title, textAlign: TextAlign.center, style: AppTextStyles.bodySemibold)),
            GestureDetector(onTap: () => Navigator.pop(context), child: const AppIcon('circle_x_0bdf2e26', w: 24, h: 24)),
          ]),
          AppGap.v20,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 11),
            decoration: const BoxDecoration(color: _openFill, borderRadius: AppRadius.br20),
            child: Column(children: [
              for (final (i, l) in d.arabicLines.indexed)
                Text(l,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: ts(AppFonts.amiriQuran, i == 1 ? 20.5 : 21, w400, i == 1 ? AppColors.textPrimary : AppColors.green87, lh: i == 1 ? 48.8 : 34.1)),
            ]),
          ),
          AppGap.v20,
          SizedBox(
            width: double.infinity,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Meaning', style: AppTextStyles.bodySmallSemibold),
              AppGap.v6,
              Text(d.meaning, style: ts(AppFonts.inter, 14.2, w500, AppColors.slateGray600, lh: 21.2)),
              AppGap.v20,
              Text('Reference', style: ts(AppFonts.inter, 9.7, w600, AppColors.textPrimary, lh: 16.7)),
              const SizedBox(height: 3),
              Text(d.reference, style: ts(AppFonts.inter, 9.8, w500, AppColors.slateGray600, lh: 14.7)),
            ]),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 219 + MediaQuery.of(context).padding.top,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                  child: Image.asset(AppImages.duaHeader, fit: BoxFit.cover),
                ),
              ),
            ),
            Column(children: [
              const _Header(showLanguage: true),
              const SizedBox(height: 27),
              Text('وَقَالَ رَبُّكُمُ ادْعُونِي أَسْتَجِبْ لَكُمْ',
                  textDirection: TextDirection.rtl, style: ts(AppFonts.amiri, 16, w700, AppColors.pureBlack, lh: 28, ls: -0.2)),
              const SizedBox(height: 13),
              Text('“And your Lord says,  ‘Call upon Me, I will respond to you.’”\n(Qur’an 40:60)',
                  textAlign: TextAlign.center, style: AppTextStyles.bodySmall.c(AppColors.textPrimary)),
              const SizedBox(height: 27),
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: Column(children: [
              for (final (i, c) in kDuaCategories.indexed) ...[
                if (i > 0) AppGap.v6,
                _Accordion(
                  number: '${i + 1}',
                  title: c.title,
                  open: _open == i,
                  onToggle: () => setState(() => _open = _open == i ? -1 : i),
                  children: c.items.isEmpty
                      ? [_subRow(_chip('${i + 1}.1', AppColors.surfaceAlt), 'Coming soon', () {}, divider: false)]
                      : [
                          for (final (j, d) in c.items.indexed)
                            _subRow(_chip('${i + 1}.${j + 1}', AppColors.surfaceAlt), d.title, () => _detail(d), divider: j < c.items.length - 1),
                        ],
                ),
              ],
            ]),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── Virtues ─────────────────────────────

/// Figma: Virtues of Deeds (6001:5210) + "Praying in Congregation" popup (6001:5334).
class VirtuesScreen extends StatefulWidget {
  const VirtuesScreen({super.key});

  @override
  State<VirtuesScreen> createState() => _VirtuesScreenState();
}

class _VirtuesScreenState extends State<VirtuesScreen> {
  int _open = 0;

  void _detail(VirtueItem v) {
    _showDetail(
      context,
      Padding(
        padding: const EdgeInsets.fromLTRB(27, 30, 27, 29),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(v.title, textAlign: TextAlign.center, style: AppTextStyles.bodySemibold)),
            GestureDetector(onTap: () => Navigator.pop(context), child: const AppIcon('circle_x_0bdf2e26', w: 24, h: 24)),
          ]),
          AppGap.v30,
          Text('Hadith', style: AppTextStyles.bodySemibold),
          AppGap.v6,
          Text(v.narrator, style: AppTextStyles.caption.c(AppColors.slateGray600)),
          AppGap.v6,
          Text(v.hadith, style: ts(AppFonts.inter, 14.2, w500, AppColors.slateGray600, lh: 21.2)),
          AppGap.v30,
          Text('Source', style: ts(AppFonts.inter, 9.7, w600, AppColors.textPrimary, lh: 16.7)),
          const SizedBox(height: 3),
          Text(v.source, style: ts(AppFonts.inter, 9.8, w500, AppColors.slateGray600, lh: 14.7)),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _Header(),
          Padding(
            padding: AppInsets.h16,
            child: Column(children: [
              SizedBox(
                height: 113,
                child: Row(children: [
                  Expanded(
                    child: Padding(
                      padding: AppInsets.v8,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                        Text('Virtues of Deeds', maxLines: 1, softWrap: false, overflow: TextOverflow.visible,
                            style: ts(AppFonts.inter, 20, w700, AppColors.emerald900, lh: 32, ls: -0.6)),
                        AppGap.v2,
                        Text('Small deeds. \nGreat rewards.', style: AppTextStyles.jakartaCaption.c(AppColors.grey58)),
                      ]),
                    ),
                  ),
                  SizedBox(width: 256, height: 113, child: Image.asset(AppImages.virtuesHeader, fit: BoxFit.cover)),
                ]),
              ),
              AppGap.v30,
              for (final (i, c) in kVirtueCategories.indexed) ...[
                if (i > 0) AppGap.v6,
                _Accordion(
                  number: '${i + 1}',
                  title: c.title,
                  icon: c.icon,
                  iconW: c.iconW,
                  open: _open == i,
                  onToggle: () => setState(() => _open = _open == i ? -1 : i),
                  children: c.items.isEmpty
                      ? [_subRow(_chip('${i + 1}.1', AppColors.surfaceAlt), 'Coming soon', () {}, divider: false)]
                      : [
                          for (final (j, v) in c.items.indexed)
                            _subRow(AppIcon(v.icon, w: 36.4, h: 24), v.title, () => _detail(v), divider: j < c.items.length - 1),
                        ],
                ),
              ],
              AppGap.v32,
            ]),
          ),
        ],
      ),
    );
  }
}
