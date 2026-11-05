import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "About Quranpro" (6031:2).
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _ink = AppColors.gold90;
  static const _body = AppColors.gold74;
  static const _sand = AppColors.gold05;
  static const _goldText = AppColors.gold17;

  static List<BoxShadow> get _soft => AppShadows.xs;

  @override
  Widget build(BuildContext context) {
    return AppSubPage(
      title: 'About Quranpro',
      back: const AppBackButton(icon: 'button_margin_2fc59631', w: 32, h: 46),
      centerTitle: false,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      children: [
        // Hero: image with a left-to-right dark green fade.
        Container(
          height: 176,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: _sand, borderRadius: AppRadius.br12, boxShadow: _soft),
          child: Stack(fit: StackFit.expand, children: [
            Image.asset(AppImages.aboutHero, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.green90.o(.8), AppColors.green90.o(.3), AppColors.green90.o(0)]),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16 + 18.4,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('TIMELESS GUIDANCE', style: ts(AppFonts.inter, 10, w600, _goldText, lh: 14, ls: 1)),
                const SizedBox(height: 2.5),
                Text('Preserving Sacred Words for Every\nScreen', style: AppTextStyles.heading.c(AppColors.white)),
              ]),
            ),
          ]),
        ),
        const SizedBox(height: 24 - 8),
        Container(
          padding: AppInsets.all24,
          decoration: BoxDecoration(color: _sand, borderRadius: AppRadius.br12, boxShadow: _soft),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('OUR SACRED INTENT', style: ts(AppFonts.inter, 10, w600, AppColors.gold75, lh: 14, ls: 0.5)),
                const SizedBox(height: 3),
                Text('Built for the Global Ummah', style: AppTextStyles.heading.c(_ink)),
              ]),
            ),
            AppGap.v15,
            Text(
              "Created with sincere devotion to make daily\nengagement with the Holy Qur'an an\neffortless, deeply reflective, and spiritually\ntransformative habit — completely free from\nadvertisements, paywalls, or commercial\ndistractions.",
              style: ts(AppFonts.inter, 14, w400, _body, lh: 22.8),
            ),
            const SizedBox(height: 15 + 5.1),
            for (final (i, f) in const [
              ('100% Free Forever (Sadaqah Jariyah)', 'No subscription tiers, banner sponsorships,\nor paywalled chapters.'),
              ('Distraction-Free & Privacy First', 'Zero behavioral trackers, intrusive analytics,\nor noisy notifications.'),
              ('Scholarly Verification', 'Faithfully cross-checked against standard\ncanonical Uthmani manuscripts.'),
            ].indexed) ...[
              if (i > 0) AppGap.v8,
              Container(
                height: 68,
                width: double.infinity,
                padding: AppInsets.all8,
                decoration: BoxDecoration(color: AppColors.white, borderRadius: AppRadius.br8, boxShadow: _soft),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(f.$1, style: AppTextStyles.captionSemibold.c(_ink)),
                  Text(f.$2, style: ts(AppFonts.inter, 12, w400, _body, lh: 18)),
                ]),
              ),
            ],
          ]),
        ),
        const SizedBox(height: 24 - 15),
        Container(
          padding: AppInsets.all24,
          decoration: BoxDecoration(
            color: AppColors.green90,
            borderRadius: AppRadius.br12,
            boxShadow: AppShadows.md,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('RIGOROUS AUTHENTICATION', style: ts(AppFonts.inter, 10, w600, _goldText, lh: 14, ls: 0.5)),
                const SizedBox(height: 7),
                Text('Scholarly Sanad & Review', style: AppTextStyles.heading.c(AppColors.white)),
              ]),
            ),
            AppGap.v15,
            Text(
              'Every ayah, tashkeel mark, stop sign (Waqf),\nand transliteration is verified against the\nauthoritative King Fahd Complex for the\nPrinting of the Holy Quran (Madinah Mushaf).',
              style: ts(AppFonts.inter, 14, w400, AppColors.gold10, lh: 22.8),
            ),
            AppGap.v15,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16.9),
              decoration: BoxDecoration(color: AppColors.green15.o(.1), borderRadius: AppRadius.br8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const Icon(Icons.verified_user, size: 18, color: _goldText),
                  AppGap.h4,
                  Text('Certified Audit Complete', style: AppTextStyles.captionSemibold.c(_goldText)),
                ]),
                AppGap.v4,
                // The Figma frame carries Lorem Ipsum here; replace with the
                // client's audit statement when it is supplied.
                Text(
                  'The Quran text is sourced from the Quran.com API (Uthmani & Indo-Pak) and reviewed against the Madinah Mushaf before every release.',
                  style: ts(AppFonts.inter, 12, w400, AppColors.gold13, lh: 18),
                ),
              ]),
            ),
          ]),
        ),
      ],
    );
  }
}
