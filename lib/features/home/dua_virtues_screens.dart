import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../data/dua_data.dart';

const _pageBg = Color(0xFFF9F6F1);
const _openFill = Color(0xFFE3ECDE);

/// Header row shared by Dua / Virtues: back (32×46) and optional EN pill.
class _Header extends StatelessWidget {
  const _Header({this.showLanguage = false});
  final bool showLanguage;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 10 + 8, 24, 18),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(onTap: () => Navigator.maybePop(context), child: const FigIcon('button_margin_35cdaed2', w: 32, h: 46)),
          if (showLanguage)
            Container(
              height: 33.1,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F8),
                border: Border.all(color: const Color(0xFFBFCCC5), width: 0.5),
                borderRadius: BorderRadius.circular(85.7),
                boxShadow: [fShadow(fc(0x000000, .2), 0, 1.1, 5.9)],
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const FigIcon('icon_9cbf6340', w: 16, h: 16),
                const SizedBox(width: 6),
                Text(AppState.instance.appLanguage.locale.languageCode.toUpperCase(),
                    style: ts(Ff.inter, 8.6, w400, AppColors.textPrimary, lh: 12.9)),
                const SizedBox(width: 8),
                const FigIcon('vector_84d0c01e', w: 6.8, h: 3.4),
              ]),
            ),
        ]),
      );
}

Widget _chip(String text, Color fill) => Container(
      width: 36.4,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: ts(Ff.inter, 9.6, w700, Colors.black, lh: 16.8, ls: -0.1)),
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
          _chip(number, open ? fc(0xFFFFFF, .5) : fc(0xE1E3DF, .5)),
          const SizedBox(width: 10),
          if (icon != null) ...[FigIcon(icon!, w: iconW, h: 16), const SizedBox(width: 10)],
          Expanded(child: Text(title, style: ts(Ff.inter, 14, w600, AppColors.textPrimary, lh: 24))),
          AnimatedRotation(
            turns: open ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const RotatedBox(quarterTurns: 1, child: FigIcon('container_f11ba571', w: 8, h: 12)),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: open ? null : Border.all(color: const Color(0xFFE9E7E4)),
        ),
        clipBehavior: Clip.antiAlias,
        padding: open ? const EdgeInsets.only(top: 8, bottom: 8) : EdgeInsets.zero,
        child: Column(children: [head, if (open) ...children]),
      ),
    );
  }
}

Widget _subRow(Widget lead, String title, VoidCallback onTap, {bool divider = true}) => Column(children: [
      const SizedBox(height: 8),
      InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 270,
          height: 24,
          child: Row(children: [lead, const SizedBox(width: 10), Text(title, style: ts(Ff.inter, 14, w600, AppColors.textPrimary, lh: 24))]),
        ),
      ),
      const SizedBox(height: 8),
      if (divider) Container(height: 1, color: _openFill),
    ]);

/// Popup card (359 wide, r40) over a blurred #03261c @60% backdrop.
Future<void> _showDetail(BuildContext context, Widget child) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'close',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (ctx, a, _) => Stack(children: [
      Positioned.fill(
        child: GestureDetector(
          onTap: () => Navigator.pop(ctx),
          child: FadeTransition(
            opacity: a,
            child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), child: Container(color: fc(0x03261C, .6))),
          ),
        ),
      ),
      Center(
        child: ScaleTransition(
          scale: Tween(begin: 0.95, end: 1.0).animate(a),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(width: 359, child: child),
          ),
        ),
      ),
    ]),
  );
}

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
            const SizedBox(width: 24),
            Expanded(child: Text(d.title, textAlign: TextAlign.center, style: ts(Ff.inter, 16, w600, AppColors.textPrimary, lh: 24))),
            GestureDetector(onTap: () => Navigator.pop(context), child: const FigIcon('circle_x_0bdf2e26', w: 24, h: 24)),
          ]),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 11),
            decoration: BoxDecoration(color: _openFill, borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              for (final (i, l) in d.arabicLines.indexed)
                Text(l,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: ts(Ff.amiriQuran, i == 1 ? 20.5 : 21, w400, i == 1 ? const Color(0xFF171A1C) : const Color(0xFF19332C), lh: i == 1 ? 48.8 : 34.1)),
            ]),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Meaning', style: ts(Ff.inter, 14, w600, AppColors.textPrimary, lh: 24)),
              const SizedBox(height: 6),
              Text(d.meaning, style: ts(Ff.inter, 14.2, w500, const Color(0xFF4A5568), lh: 21.2)),
              const SizedBox(height: 20),
              Text('Reference', style: ts(Ff.inter, 9.7, w600, AppColors.textPrimary, lh: 16.7)),
              const SizedBox(height: 3),
              Text(d.reference, style: ts(Ff.inter, 9.8, w500, const Color(0xFF4A5568), lh: 14.7)),
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
                  child: Image.asset('assets/images/dua_header.jpg', fit: BoxFit.cover),
                ),
              ),
            ),
            Column(children: [
              const _Header(showLanguage: true),
              const SizedBox(height: 27),
              Text('وَقَالَ رَبُّكُمُ ادْعُونِي أَسْتَجِبْ لَكُمْ',
                  textDirection: TextDirection.rtl, style: ts(Ff.amiri, 16, w700, Colors.black, lh: 28, ls: -0.2)),
              const SizedBox(height: 13),
              Text('“And your Lord says,  ‘Call upon Me, I will respond to you.’”\n(Qur’an 40:60)',
                  textAlign: TextAlign.center, style: ts(Ff.inter, 14, w400, AppColors.textPrimary, lh: 20)),
              const SizedBox(height: 27),
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: Column(children: [
              for (final (i, c) in kDuaCategories.indexed) ...[
                if (i > 0) const SizedBox(height: 6),
                _Accordion(
                  number: '${i + 1}',
                  title: c.title,
                  open: _open == i,
                  onToggle: () => setState(() => _open = _open == i ? -1 : i),
                  children: c.items.isEmpty
                      ? [_subRow(_chip('${i + 1}.1', const Color(0xFFF0F1EF)), 'Coming soon', () {}, divider: false)]
                      : [
                          for (final (j, d) in c.items.indexed)
                            _subRow(_chip('${i + 1}.${j + 1}', const Color(0xFFF0F1EF)), d.title, () => _detail(d), divider: j < c.items.length - 1),
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
            Expanded(child: Text(v.title, textAlign: TextAlign.center, style: ts(Ff.inter, 16, w600, AppColors.textPrimary, lh: 24))),
            GestureDetector(onTap: () => Navigator.pop(context), child: const FigIcon('circle_x_0bdf2e26', w: 24, h: 24)),
          ]),
          const SizedBox(height: 30),
          Text('Hadith', style: ts(Ff.inter, 16, w600, AppColors.textPrimary, lh: 24)),
          const SizedBox(height: 6),
          Text(v.narrator, style: ts(Ff.inter, 12, w500, const Color(0xFF4A5568), lh: 16)),
          const SizedBox(height: 6),
          Text(v.hadith, style: ts(Ff.inter, 14.2, w500, const Color(0xFF4A5568), lh: 21.2)),
          const SizedBox(height: 30),
          Text('Source', style: ts(Ff.inter, 9.7, w600, AppColors.textPrimary, lh: 16.7)),
          const SizedBox(height: 3),
          Text(v.source, style: ts(Ff.inter, 9.8, w500, const Color(0xFF4A5568), lh: 14.7)),
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              SizedBox(
                height: 113,
                child: Row(children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                        Text('Virtues of Deeds', maxLines: 1, softWrap: false, overflow: TextOverflow.visible,
                            style: ts(Ff.inter, 20, w700, const Color(0xFF064E3B), lh: 32, ls: -0.6)),
                        const SizedBox(height: 2),
                        Text('Small deeds. \nGreat rewards.', style: ts(Ff.jakarta, 12, w400, const Color(0xFF657069), lh: 16)),
                      ]),
                    ),
                  ),
                  SizedBox(width: 256, height: 113, child: Image.asset('assets/images/virtues_header.jpg', fit: BoxFit.cover)),
                ]),
              ),
              const SizedBox(height: 30),
              for (final (i, c) in kVirtueCategories.indexed) ...[
                if (i > 0) const SizedBox(height: 6),
                _Accordion(
                  number: '${i + 1}',
                  title: c.title,
                  icon: c.icon,
                  iconW: c.iconW,
                  open: _open == i,
                  onToggle: () => setState(() => _open = _open == i ? -1 : i),
                  children: c.items.isEmpty
                      ? [_subRow(_chip('${i + 1}.1', const Color(0xFFF0F1EF)), 'Coming soon', () {}, divider: false)]
                      : [
                          for (final (j, v) in c.items.indexed)
                            _subRow(FigIcon(v.icon, w: 36.4, h: 24), v.title, () => _detail(v), divider: j < c.items.length - 1),
                        ],
                ),
              ],
              const SizedBox(height: 32),
            ]),
          ),
        ],
      ),
    );
  }
}
