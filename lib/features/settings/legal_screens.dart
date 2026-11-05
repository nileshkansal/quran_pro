import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/fig_widgets.dart';

TextStyle get _body => ts(Ff.inter, 18, w400, AppColors.textSecondary, lh: 29.3);
Widget get _rule => Container(height: 1, color: fc(0xBFC9C2, .1));

/// Figma: "Privacy Policy" (6001:1297).
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const _sections = [
    ('container_b2d8bf98', 20.0, 18.0, '1. Introduction',
        'Your privacy is sacred to us. We\nunderstand that your spiritual\njourney is deeply personal. Our\napplication is designed to be a\nsanctuary, and we treat any\ninformation you share with the\nutmost respect and\nconfidentiality.'),
    ('container_e6a2bde0', 18.0, 18.0, '2. Data Collection',
        'We only collect what is strictly\nnecessary to facilitate your\nspiritual journey. This primarily\nincludes reading progress,\nbookmark data, and personal\nreflections, which are stored\nlocally on your device whenever\npossible.'),
    ('container_33fb187f', 18.0, 18.0, '3. Usage',
        'The minimal data we gather is\nused exclusively to personalize\nyour reading experience, such as\nmaintaining daily streaks and\nsuggesting relevant verses based\non your past engagement. We\nnever sell or share your data with\nthird parties.'),
    ('container_531caf93', 16.0, 21.0, '4. Security',
        'Protecting your reflections and\nprogress is our priority. Any data\nsynced across devices is\ntransmitted using industry-\nstandard encryption protocols,\nensuring that your personal notes\nremain private and secure.'),
    ('container_392cb4b6', 20.0, 16.0, '5. Contact',
        'If you have any questions or\nconcerns regarding our privacy\npractices, please do not hesitate\nto reach out. You can contact our\ndedicated support team directly\nthrough the application or via\nemail at privacy@quranpro.app.'),
  ];

  @override
  Widget build(BuildContext context) {
    return FigSubPage(
      title: 'Privacy Policy',
      titleLs: -0.5,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 136),
      children: [
        const Center(child: Opacity(opacity: .8, child: FigIcon('icon_c0f28894', w: 24, h: 30))),
        const SizedBox(height: 16),
        Text(
          'We are committed to maintaining the\nsanctity of your digital space. This\npolicy outlines our thoughtful approach\nto your data.',
          textAlign: TextAlign.center,
          style: ts(Ff.inter, 18, w400, AppColors.textSecondary, lh: 28),
        ),
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: figCard(radius: 12, border: fc(0xBFC9C2, .1)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (final (i, s) in _sections.indexed) ...[
              if (i > 0) ...[const SizedBox(height: 24), _rule, const SizedBox(height: 24)],
              Row(children: [
                SizedBox(width: 20, child: Center(child: FigIcon(s.$1, w: s.$2, h: s.$3))),
                const SizedBox(width: 8),
                Text(s.$4, style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
              ]),
              const SizedBox(height: 12),
              Text(s.$5, style: _body),
            ],
          ]),
        ),
        const SizedBox(height: 40 + 24),
        Text('Last updated: October 24, 2023', textAlign: TextAlign.center, style: ts(Ff.inter, 12, w500, AppColors.textMuted, lh: 16, ls: 0.6)),
      ],
    );
  }
}

/// Figma: "Terms & Conditions" (6001:1353).
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  static const _sections = [
    ('1. Acceptance of Terms',
        'By accessing or using the\nQuranPro application, you agree\nto be bound by these Terms and\nConditions and our Privacy Policy.\nIf you do not agree to these terms,\nplease do not use the application.\nThese terms constitute a legally\nbinding agreement between you\nand QuranPro.'),
    ('2. User Conduct',
        'You agree to use QuranPro in a\nmanner consistent with its\npurpose of spiritual reflection and\nstudy. Respectful engagement\nwith the community and content is\nrequired. You must not use the\napplication for any unlawful\npurpose, to solicit others to\nperform illegal acts, or to violate\nany international, federal, or state\nregulations.'),
    ('3. Intellectual Property',
        'The design, logos, and interface\nof QuranPro are the exclusive\nproperty of QuranPro. We ask that\nyou respect the sanctity of the\ntext and the app design. You may\nnot reproduce, distribute, or\ncreate derivative works without\nexplicit written permission. The\nsacred texts provided are derived\nfrom recognized public domain or\nlicensed sources.'),
    ('4. Limitation of Liability',
        'QuranPro is provided "as is"\nwithout warranties of any kind.\nWe shall not be liable for any\nindirect, incidental, special,\nconsequential, or punitive\ndamages, or any loss of profits or\nrevenues, whether incurred\ndirectly or indirectly, resulting\nfrom your access to or use of, or\ninability to access or use the\nservices.'),
    ('5. Updates to Terms',
        'We reserve the right to modify\nthese terms at any time. We will\nnotify you of any changes by\nposting the new Terms and\nConditions on this page and\nupdating the "Last updated" date.\nYour continued use of the\napplication after such\nmodifications will constitute your\nacknowledgment of the modified\nTerms.'),
  ];

  @override
  Widget build(BuildContext context) {
    return FigSubPage(
      title: 'Terms & Conditions',
      titleLs: -0.5,
      backIcon: 'button_go_back_margin_b2016837',
      backW: 32,
      backH: 40,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 96 + 40),
      children: [
        Text('Terms of Service', textAlign: TextAlign.center, style: ts(Ff.inter, 32, w600, AppColors.green800, lh: 56)),
        const SizedBox(height: 12),
        Text('Last updated: October 24, 2023', textAlign: TextAlign.center, style: ts(Ff.inter, 16, w400, AppColors.textSecondary, lh: 24)),
        const SizedBox(height: 12 + 12),
        Center(child: Container(width: 96, height: 1, color: fc(0xBFC9C2, .3))),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          decoration: figCard(radius: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (final (i, s) in _sections.indexed) ...[
              if (i > 0) ...[const SizedBox(height: 24), _rule, const SizedBox(height: 24)],
              Text(s.$1, style: ts(Ff.inter, 20, w700, AppColors.green500, lh: 28, ls: -0.2)),
              const SizedBox(height: 12),
              Text(s.$2, style: _body),
            ],
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                border: Border.all(color: fc(0xBFC9C2, .2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const FigIcon('icon_9fbd7377', w: 20, h: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'For any legal inquiries or concerns\nregarding these terms, please\ncontact our support team via the\nFeedback section or at\nlegal@quranpro.example.com.',
                    style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16, ls: 0.6),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 24),
            Center(
              child: FigButton(
                label: 'I Understand',
                width: 151.9,
                height: 40,
                leading: const FigIcon('container_a4a806a5', w: 15, h: 15),
                textStyle: ts(Ff.inter, 12, w500, Colors.white, lh: 16, ls: 0.6),
                onTap: () => Navigator.maybePop(context),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
