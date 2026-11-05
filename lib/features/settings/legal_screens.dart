import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';


TextStyle get _body => ts(AppFonts.inter, 18, w400, AppColors.textSecondary, lh: 29.3);
Widget get _rule => Container(height: 1, color: AppColors.outline.o(.1));

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
    return AppSubPage(
      title: 'Privacy Policy',
      titleStyle: AppTextStyles.titleTight,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 136),
      children: [
        const Center(child: Opacity(opacity: .8, child: AppIcon('icon_c0f28894', w: 24, h: 30))),
        AppGap.v16,
        Text(
          'We are committed to maintaining the\nsanctity of your digital space. This\npolicy outlines our thoughtful approach\nto your data.',
          textAlign: TextAlign.center,
          style: AppTextStyles.lead,
        ),
        AppGap.v40,
        Container(
          padding: AppInsets.all24,
          decoration: AppDecorations.card(radius: 12, border: AppColors.outline.o(.1)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (final (i, s) in _sections.indexed) ...[
              if (i > 0) ...[AppGap.v24, _rule, AppGap.v24],
              Row(children: [
                SizedBox(width: 20, child: Center(child: AppIcon(s.$1, w: s.$2, h: s.$3))),
                AppGap.h8,
                Text(s.$4, style: AppTextStyles.title),
              ]),
              AppGap.v12,
              Text(s.$5, style: _body),
            ],
          ]),
        ),
        const SizedBox(height: 40 + 24),
        Text('Last updated: October 24, 2023', textAlign: TextAlign.center, style: AppTextStyles.label.c(AppColors.textMuted)),
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
    return AppSubPage(
      title: 'Terms & Conditions',
      titleStyle: AppTextStyles.titleTight,
      back: const AppBackButton(icon: 'button_go_back_margin_b2016837', w: 32, h: 40),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 96 + 40),
      children: [
        Text('Terms of Service', textAlign: TextAlign.center, style: ts(AppFonts.inter, 32, w600, AppColors.green800, lh: 56)),
        AppGap.v12,
        Text('Last updated: October 24, 2023', textAlign: TextAlign.center, style: AppTextStyles.body),
        const SizedBox(height: 12 + 12),
        Center(child: Container(width: 96, height: 1, color: AppColors.outline.o(.3))),
        AppGap.v24,
        Container(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          decoration: AppDecorations.card(radius: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (final (i, s) in _sections.indexed) ...[
              if (i > 0) ...[AppGap.v24, _rule, AppGap.v24],
              Text(s.$1, style: AppTextStyles.title.c(AppColors.green500)),
              AppGap.v12,
              Text(s.$2, style: _body),
            ],
            AppGap.v12,
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                border: Border.all(color: AppColors.outline.o(.2)),
                borderRadius: AppRadius.br8,
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const AppIcon('icon_9fbd7377', w: 20, h: 20),
                AppGap.h12,
                Expanded(
                  child: Text(
                    'For any legal inquiries or concerns\nregarding these terms, please\ncontact our support team via the\nFeedback section or at\nlegal@quranpro.example.com.',
                    style: AppTextStyles.label,
                  ),
                ),
              ]),
            ),
            AppGap.v24,
            Center(
              child: AppButton(
                label: 'I Understand',
                width: 151.9,
                height: 40,
                leading: const AppIcon('container_a4a806a5', w: 15, h: 15),
                textStyle: AppTextStyles.label.c(AppColors.white),
                onTap: () => Navigator.maybePop(context),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
