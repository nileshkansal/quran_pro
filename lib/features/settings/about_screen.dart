import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/figma.dart';
import '../../widgets/fig_widgets.dart';

/// Figma: "About Quranpro" (6031:2).
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _ink = Color(0xFF1F1B14);
  static const _body = Color(0xFF4F4537);
  static const _sand = Color(0xFFFCF2E7);
  static const _goldText = Color(0xFFFFDEAA);

  static List<BoxShadow> get _soft => [fShadow(fc(0x000000, .05), 0, 1, 2)];

  @override
  Widget build(BuildContext context) {
    return FigSubPage(
      title: 'About Quranpro',
      backIcon: 'button_margin_2fc59631',
      backW: 32,
      backH: 46,
      centerTitle: false,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      children: [
        // Hero: image with a left-to-right dark green fade.
        Container(
          height: 176,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: _sand, borderRadius: BorderRadius.circular(12), boxShadow: _soft),
          child: Stack(fit: StackFit.expand, children: [
            Image.asset(AppImages.aboutHero, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [fc(0x0D261E, .8), fc(0x0D261E, .3), fc(0x0D261E, 0)]),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16 + 18.4,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('TIMELESS GUIDANCE', style: ts(Ff.inter, 10, w600, _goldText, lh: 14, ls: 1)),
                const SizedBox(height: 2.5),
                Text('Preserving Sacred Words for Every\nScreen', style: ts(Ff.inter, 18, w700, Colors.white, lh: 26)),
              ]),
            ),
          ]),
        ),
        const SizedBox(height: 24 - 8),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: _sand, borderRadius: BorderRadius.circular(12), boxShadow: _soft),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('OUR SACRED INTENT', style: ts(Ff.inter, 10, w600, const Color(0xFF7D5700), lh: 14, ls: 0.5)),
                const SizedBox(height: 3),
                Text('Built for the Global Ummah', style: ts(Ff.inter, 18, w700, _ink, lh: 26)),
              ]),
            ),
            const SizedBox(height: 15),
            Text(
              "Created with sincere devotion to make daily\nengagement with the Holy Qur'an an\neffortless, deeply reflective, and spiritually\ntransformative habit — completely free from\nadvertisements, paywalls, or commercial\ndistractions.",
              style: ts(Ff.inter, 14, w400, _body, lh: 22.8),
            ),
            const SizedBox(height: 15 + 5.1),
            for (final (i, f) in const [
              ('100% Free Forever (Sadaqah Jariyah)', 'No subscription tiers, banner sponsorships,\nor paywalled chapters.'),
              ('Distraction-Free & Privacy First', 'Zero behavioral trackers, intrusive analytics,\nor noisy notifications.'),
              ('Scholarly Verification', 'Faithfully cross-checked against standard\ncanonical Uthmani manuscripts.'),
            ].indexed) ...[
              if (i > 0) const SizedBox(height: 8),
              Container(
                height: 68,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: _soft),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(f.$1, style: ts(Ff.inter, 12, w600, _ink, lh: 16)),
                  Text(f.$2, style: ts(Ff.inter, 12, w400, _body, lh: 18)),
                ]),
              ),
            ],
          ]),
        ),
        const SizedBox(height: 24 - 15),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF0D261E),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [fShadow(fc(0x000000, .1), 0, 2, 4, -2), fShadow(fc(0x000000, .1), 0, 4, 6, -1)],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('RIGOROUS AUTHENTICATION', style: ts(Ff.inter, 10, w600, _goldText, lh: 14, ls: 0.5)),
                const SizedBox(height: 7),
                Text('Scholarly Sanad & Review', style: ts(Ff.inter, 18, w700, Colors.white, lh: 26)),
              ]),
            ),
            const SizedBox(height: 15),
            Text(
              'Every ayah, tashkeel mark, stop sign (Waqf),\nand transliteration is verified against the\nauthoritative King Fahd Complex for the\nPrinting of the Holy Quran (Madinah Mushaf).',
              style: ts(Ff.inter, 14, w400, const Color(0xFFF1E7DC), lh: 22.8),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16.9),
              decoration: BoxDecoration(color: fc(0xC3ECD9, .1), borderRadius: BorderRadius.circular(8)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const Icon(Icons.verified_user, size: 18, color: _goldText),
                  const SizedBox(width: 4),
                  Text('Certified Audit Complete', style: ts(Ff.inter, 12, w600, _goldText, lh: 16)),
                ]),
                const SizedBox(height: 4),
                // The Figma frame carries Lorem Ipsum here; replace with the
                // client's audit statement when it is supplied.
                Text(
                  'The Quran text is sourced from the Quran.com API (Uthmani & Indo-Pak) and reviewed against the Madinah Mushaf before every release.',
                  style: ts(Ff.inter, 12, w400, const Color(0xFFEBE1D6), lh: 18),
                ),
              ]),
            ),
          ]),
        ),
      ],
    );
  }
}
