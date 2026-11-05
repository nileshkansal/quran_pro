import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Login" (6001:2902) — 390×863 canvas.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(text: 'john.doe@mail.com');
  final _pass = TextEditingController(text: 'password');
  bool _agree = true;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_agree) {
      showAppSnackBar(context, 'Please accept the Terms and Privacy Policy');
      return;
    }
    AppState.instance.update(() {
      AppState.instance.loggedIn = true;
      AppState.instance.email = _email.text.trim();
    });
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: DesignCanvas(
        designHeight: 863,
        background: AppColors.background,
        children: [
          const Positioned.fill(child: LanternBackdrop()),
          if (Navigator.of(context).canPop()) Positioned(top: MediaQuery.of(context).padding.top + 4, left: 8, child: const ArrowBackButton()),
          Positioned(
            top: 80,
            left: 24,
            right: 24,
            child: Column(children: [
              const Logo.small(width: 103.6),
              const SizedBox(height: 34),
              Text('Welcome', textAlign: TextAlign.center, style: ts(AppFonts.poppins, 23, w600, AppColors.textPrimary, lh: 39)),
              AppGap.v12,
              SizedBox(
                width: 260,
                child: Text('Enter your Email to continue your\nspiritual journey.',
                    textAlign: TextAlign.center, style: ts(AppFonts.poppins, 15, w400, AppColors.textSecondary, lh: 25)),
              ),
              AppGap.v24,
              const OrnamentDivider(icon: 'margin_0880d223'),
              const SizedBox(height: 24 + 30),
              AppTextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                leadingWidth: 58,
                leading: const Padding(padding: EdgeInsets.only(left: 22), child: AppIcon('icon_f77ea78e', w: 16, h: 16)),
                trailingPad: 40,
              ),
              AppGap.v20,
              AppTextField(
                controller: _pass,
                obscure: true,
                leadingWidth: 64,
                leading: const Padding(padding: EdgeInsets.only(left: 23), child: AppIcon('icon_6883af38', w: 16, h: 21)),
                trailingPad: 40,
              ),
              AppGap.v20,
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
                  child: Text('Forget Password?', style: ts(AppFonts.poppins, 14, w500, AppColors.textPrimary, lh: 24)),
                ),
              ),
              AppGap.v20,
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                GestureDetector(
                  onTap: () => setState(() => _agree = !_agree),
                  child: Opacity(opacity: _agree ? 1 : 0.35, child: const AppIcon('ci_checkbox_check_f688d29a', w: 24, h: 24)),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.terms),
                    child: Text('By continuing, you agree to our Terms and Privacy Policy. ',
                        style: ts(AppFonts.inter, 10, w500, AppColors.textMuted, lh: 17, ls: 0.6)),
                  ),
                ),
              ]),
              AppGap.v20,
              AppButton(label: 'Submit', onTap: _submit, textStyle: AppTextStyles.button),
              AppGap.v15,
              const SizedBox(height: 24, child: OrDivider()),
              AppGap.v15,
              SocialButtons(onGoogle: _submit, onApple: _submit),
              AppGap.v15,
              GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.createProfile),
                child: Text('Don’t have an account? Register',
                    textAlign: TextAlign.center, style: AppTextStyles.label.c(AppColors.textMuted)),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
