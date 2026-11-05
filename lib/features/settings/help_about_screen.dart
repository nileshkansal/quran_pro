import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

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
            Text('FAQ', style: AppTextStyles.title),
            AppGap.v8,
            for (final f in _faqs)
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(f.$1, style: AppTextStyles.bodyMedium),
                childrenPadding: const EdgeInsets.only(bottom: 12),
                expandedAlignment: Alignment.centerLeft,
                children: [Text(f.$2, style: AppTextStyles.bodySmall)],
              ),
          ],
        ),
      );

  void _contact(BuildContext context) => showAppSheet(
        context,
        builder: (ctx) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Contact Support', style: AppTextStyles.title),
            AppGap.v8,
            Text('Write to us at support@quranpro.app — we usually reply within 48 hours.',
                style: AppTextStyles.body),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    void go(String r, [Object? a]) => Navigator.of(context).pushNamed(r, arguments: a);
    return AppSubPage(
      title: 'Help & About',
      children: [
        GestureDetector(
          onTap: () => go(AppRoutes.about),
          child: Container(
            padding: AppInsets.all24,
            decoration: AppDecorations.card(),
            child: Column(children: [
              Container(
                width: 96,
                height: 96,
                alignment: Alignment.center,
                decoration: const BoxDecoration(gradient: AppColors.goldGradient, shape: BoxShape.circle),
                child: const AppIcon('container_a21a53dc', w: 44, h: 32),
              ),
              const SizedBox(height: 8 + 16),
              Text('QuranPro', style: ts(AppFonts.amiri, 32, w700, AppColors.green800, lh: 56)),
              AppGap.v4,
              Text('Version 1.0.0', style: AppTextStyles.body),
              const SizedBox(height: 16 + 2.5),
              Text(
                'Providing a digital sanctuary for reflection\nand study, designed with modern utility and\ntraditional reverence.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall,
              ),
            ]),
          ),
        ),
        AppGap.v40,
        const _Caption('HELP & SUPPORT'),
        AppGap.v12,
        _Group(rows: [
          ('container_b9b5b2b9', 20, 20, 'FAQ', () => _faq(context)),
          ('container_c132147e', 20, 20, 'How to Use', () => go(AppRoutes.onboarding, true)),
          ('container_19806e25', 20, 18, 'Contact Support', () => _contact(context)),
          ('icon_b1a5146a', 20, 19, 'Feedback', () => go(AppRoutes.feedback)),
        ]),
        AppGap.v24,
        const _Caption('LEGAL & INFO'),
        AppGap.v12,
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
        child: Text(text, style: ts(AppFonts.inter, 12, w500, AppColors.green500, lh: 16, ls: 1.2)),
      );
}

typedef _HelpRow = (String icon, double w, double h, String label, VoidCallback onTap);

class _Group extends StatelessWidget {
  const _Group({required this.rows});
  final List<_HelpRow> rows;

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: AppDecorations.card(),
        child: Material(
          type: MaterialType.transparency,
          child: Column(children: [
            for (var i = 0; i < rows.length; i++)
              InkWell(
                onTap: rows[i].$5,
                child: Container(
                  height: i < rows.length - 1 ? 57 : 56,
                  padding: AppInsets.h16,
                  decoration: BoxDecoration(
                    border: i < rows.length - 1 ? Border(bottom: BorderSide(color: AppColors.outline.o(.2))) : null,
                  ),
                  child: Row(children: [
                    SizedBox(width: 20, child: Center(child: AppIcon(rows[i].$1, w: rows[i].$2, h: rows[i].$3))),
                    AppGap.h16,
                    Expanded(child: Text(rows[i].$4, style: AppTextStyles.body.c(AppColors.textPrimary))),
                    const AppIcon('container_b38512cd', w: 7.4, h: 12),
                  ]),
                ),
              ),
          ]),
        ),
      );
}
