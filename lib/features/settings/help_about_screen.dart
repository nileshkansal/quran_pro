import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/fig_widgets.dart';
import '../../widgets/sheets.dart';

/// Figma: "Help & About" (6001:837).
class HelpAboutScreen extends StatelessWidget {
  const HelpAboutScreen({super.key});

  static const _faqs = [
    ('Is QuranPro really free?', 'Yes. QuranPro is 100% free with no ads, subscriptions or paywalled chapters.'),
    ('Can I read offline?', 'The Arabic text and your selected translation are available offline once downloaded.'),
    ('How is my daily target calculated?', 'The Quran is divided into short summary sections, and your plan spreads them across the minutes you choose each day.'),
    ('How do I change the reciter?', 'Go to Settings → Audio & Recitation and pick a Qari from the list.'),
  ];

  void _faq(BuildContext context) => showAppSheet(
        context,
        builder: (ctx) => ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            Text('FAQ', style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
            const SizedBox(height: 8),
            for (final f in _faqs)
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(f.$1, style: ts(Ff.inter, 16, w500, AppColors.textPrimary, lh: 24)),
                childrenPadding: const EdgeInsets.only(bottom: 12),
                expandedAlignment: Alignment.centerLeft,
                children: [Text(f.$2, style: ts(Ff.inter, 14, w400, AppColors.textSecondary, lh: 20))],
              ),
          ],
        ),
      );

  void _contact(BuildContext context) => showAppSheet(
        context,
        builder: (ctx) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Contact Support', style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
            const SizedBox(height: 8),
            Text('Write to us at support@quranpro.app — we usually reply within 48 hours.',
                style: ts(Ff.inter, 16, w400, AppColors.textSecondary, lh: 24)),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    void go(String r, [Object? a]) => Navigator.of(context).pushNamed(r, arguments: a);
    return FigSubPage(
      title: 'Help & About',
      children: [
        GestureDetector(
          onTap: () => go(AppRoutes.about),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: figCard(),
            child: Column(children: [
              Container(
                width: 96,
                height: 96,
                alignment: Alignment.center,
                decoration: const BoxDecoration(gradient: AppColors.goldGradient, shape: BoxShape.circle),
                child: const FigIcon('container_a21a53dc', w: 44, h: 32),
              ),
              const SizedBox(height: 8 + 16),
              Text('QuranPro', style: ts(Ff.amiri, 32, w700, AppColors.green800, lh: 56)),
              const SizedBox(height: 4),
              Text('Version 1.0.0', style: ts(Ff.inter, 16, w400, AppColors.textSecondary, lh: 24)),
              const SizedBox(height: 16 + 2.5),
              Text(
                'Providing a digital sanctuary for reflection\nand study, designed with modern utility and\ntraditional reverence.',
                textAlign: TextAlign.center,
                style: ts(Ff.inter, 14, w400, AppColors.textSecondary, lh: 20),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 40),
        const _Caption('HELP & SUPPORT'),
        const SizedBox(height: 12),
        _Group(rows: [
          ('container_b9b5b2b9', 20, 20, 'FAQ', () => _faq(context)),
          ('container_c132147e', 20, 20, 'How to Use', () => go(AppRoutes.onboarding, true)),
          ('container_19806e25', 20, 18, 'Contact Support', () => _contact(context)),
          ('icon_b1a5146a', 20, 19, 'Feedback', () => go(AppRoutes.feedback)),
        ]),
        const SizedBox(height: 24),
        const _Caption('LEGAL & INFO'),
        const SizedBox(height: 12),
        _Group(rows: [
          ('container_aad0b9b4', 16, 20, 'Privacy Policy', () => go(AppRoutes.privacy)),
          ('container_3770251f', 18, 19, 'Terms of Use', () => go(AppRoutes.terms)),
        ]),
        const SizedBox(height: 122),
      ],
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(text, style: ts(Ff.inter, 12, w500, AppColors.green500, lh: 16, ls: 1.2)),
      );
}

typedef _HelpRow = (String icon, double w, double h, String label, VoidCallback onTap);

class _Group extends StatelessWidget {
  const _Group({required this.rows});
  final List<_HelpRow> rows;

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: figCard(),
        child: Material(
          type: MaterialType.transparency,
          child: Column(children: [
            for (var i = 0; i < rows.length; i++)
              InkWell(
                onTap: rows[i].$5,
                child: Container(
                  height: i < rows.length - 1 ? 57 : 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: i < rows.length - 1 ? Border(bottom: BorderSide(color: fc(0xBFC9C2, .2))) : null,
                  ),
                  child: Row(children: [
                    SizedBox(width: 20, child: Center(child: FigIcon(rows[i].$1, w: rows[i].$2, h: rows[i].$3))),
                    const SizedBox(width: 16),
                    Expanded(child: Text(rows[i].$4, style: ts(Ff.inter, 16, w400, AppColors.textPrimary, lh: 24))),
                    const FigIcon('container_b38512cd', w: 7.4, h: 12),
                  ]),
                ),
              ),
          ]),
        ),
      );
}
