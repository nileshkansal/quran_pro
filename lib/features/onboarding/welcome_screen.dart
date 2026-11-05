import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Welcome screen" (6001:1640)
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: DesignCanvas(
        background: AppColors.background,
        children: [
          const Positioned.fill(child: LanternBackdrop()),
          // 362×388.5 group at (14, 131.2), centred column, gap 15.
          Positioned(
            top: 138.7,
            left: 14,
            right: 14,
            child: Column(children: [
              const Logo.icon(width: 119.8),
              const SizedBox(height: 9),
              Text('Welcome to', textAlign: TextAlign.center, style: ts(AppFonts.inter, 18, w400, AppColors.pureBlack)),
              const SizedBox(height: 9),
              const Logo.wordmark(width: 163.5),
              AppGap.v15,
              const DecorDivider(),
              AppGap.v15,
              SizedBox(
                width: 323,
                child: Text(
                  'Your place to read the Qur’an with understanding.',
                  textAlign: TextAlign.center,
                  style: ts(AppFonts.poppins, 17, w500, AppColors.black, lh: 27, ls: -0.2),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'We help you make the Qur’an a part of your everyday life — reading with understanding and discovering guidance in every verse.',
                textAlign: TextAlign.center,
                style: ts(AppFonts.poppins, 12, w400, AppColors.textSecondary, lh: 24),
              ),
            ]),
          ),
          // Buttons 341×125 at (25, 595), gap 13.
          Positioned(
            top: 595,
            left: 25,
            right: 24,
            child: Column(children: [
              AppButton(
                label: 'I already have an account',
                variant: AppButtonVariant.outline,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.login),
                trailing: AppButton.arrowDark,
              ),
              const SizedBox(height: 13),
              AppButton(
                label: 'Let’s get started',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.onboarding),
                trailing: AppButton.arrowWhite,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
