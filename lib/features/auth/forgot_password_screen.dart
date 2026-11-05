import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/fig_widgets.dart';
import 'auth_card_page.dart';

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
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(children: [
            FigInput(
              controller: _email,
              height: 49,
              radius: 8,
              fill: const Color(0xFFF8FAF6),
              borderColor: AppColors.divider,
              hint: 'Enter your email',
              hintStyle: ts(Ff.inter, 16, w400, AppColors.outline),
              keyboardType: TextInputType.emailAddress,
              leading: const FigIcon('container_6ca4db80', w: 36, h: 49),
            ),
            const SizedBox(height: 24),
            AuthAction(
              label: 'Send OTP',
              onTap: () => Navigator.of(context).pushNamed(
                AppRoutes.verifyOtp,
                arguments: _email.text.trim().isEmpty ? 'example12@gmail.com' : _email.text.trim(),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 1),
            child: Text('Return to Login', style: ts(Ff.inter, 14, w500, AppColors.black, lh: 21)),
          ),
        ),
      ]),
    );
  }
}
