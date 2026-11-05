import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import 'auth_card_page.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Forgot Password - Request (OTP)" (6001:7015)
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthCardPage(
      cardTop: 259,
      child: Column(children: [
        const AuthTitle('Forgot Password', 'Enter your phone number to receive\na one-time password (OTP) to reset\nyour password.'),
        AppGap.v12,
        Padding(
          padding: AppInsets.v12,
          child: Column(children: [
            AppTextField(
              controller: _email,
              height: 49,
              radius: 8,
              fill: AppColors.surface,
              borderColor: AppColors.divider,
              hint: 'Enter your email',
              hintStyle: ts(AppFonts.inter, 16, w400, AppColors.outline),
              keyboardType: TextInputType.emailAddress,
              leading: const AppIcon('container_6ca4db80', w: 36, h: 49),
            ),
            AppGap.v24,
            AuthAction(
              label: 'Send OTP',
              onTap: () => Navigator.of(context).pushNamed(
                AppRoutes.verifyOtp,
                arguments: _email.text.trim().isEmpty ? 'example12@gmail.com' : _email.text.trim(),
              ),
            ),
          ]),
        ),
        AppGap.v12,
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 1),
            child: Text('Return to Login', style: ts(AppFonts.inter, 14, w500, AppColors.black, lh: 21)),
          ),
        ),
      ]),
    );
  }
}
