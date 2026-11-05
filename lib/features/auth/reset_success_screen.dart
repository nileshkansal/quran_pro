import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import 'auth_card_page.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Reset Password - Success" (6001:7156) — 342×384 card, r12.
class ResetSuccessScreen extends StatelessWidget {
  const ResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthCardPage(
      cardTop: 260,
      radius: 12,
      showBack: false,
      silhouette: true,
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
      child: Column(children: [
        // Success icon: 96 circle #c8a45d @20% with 64 gold disc + check.
        Container(
          width: 96,
          height: 96,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.goldMuted.o(.2), shape: BoxShape.circle),
          child: const AppIcon('background_shadow_a7590819', w: 64, h: 64),
        ),
        AppGap.v24,
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text('Password Reset Successful',
              textAlign: TextAlign.center, style: ts(AppFonts.poppins, 18, w600, AppColors.green800, lh: 28, ls: -0.2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.9),
          child: Text('Your password has been updated.\nYou can now log in with your new\ncredentials.',
              textAlign: TextAlign.center, style: ts(AppFonts.poppins, 13, w400, AppColors.textSecondary, lh: 22)),
        ),
        const SizedBox(height: 46),
        AppButton(
          label: 'Back to Login',
          height: 48,
          textStyle: AppTextStyles.bodyMedium.c(AppColors.white),
          onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.login,
            (r) => r.settings.name == AppRoutes.welcome || r.isFirst,
          ),
        ),
      ]),
    );
  }
}
