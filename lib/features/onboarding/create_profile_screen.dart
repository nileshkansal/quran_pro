import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/theme.dart';
import '../../core/utils/validators.dart';
import '../../widgets/widgets.dart';
import '../../core/assets.dart';

/// Figma: "Create Profile" (6001:2283) — 390×874 canvas.
class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _first = TextEditingController(text: 'John');
  final _last = TextEditingController(text: 'Doe');
  final _email = TextEditingController(text: 'john.doe@mail.com');
  final _pass = TextEditingController(text: 'Abcdef@1234');
  final _confirm = TextEditingController(text: 'Abcdef@1234');

  @override
  void initState() {
    super.initState();
    for (final c in [_first, _last, _email, _pass, _confirm]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final c in [_first, _last, _email, _pass, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  int get _strength => Validators.passwordStrength(_pass.text);

  bool get _emailOk => Validators.isEmail(_email.text);
  bool get _match => _pass.text.isNotEmpty && _pass.text == _confirm.text;
  bool get _valid => Validators.isNotBlank(_first.text) && _emailOk && _strength >= 3 && _match;

  void _save() {
    final s = AppState.instance;
    s.update(() {
      s.firstName = _first.text.trim();
      s.lastName = _last.text.trim();
      s.email = _email.text.trim();
      s.loggedIn = true;
    });
    Navigator.of(context).pushNamed(AppRoutes.dailyRecitation);
  }

  Widget _check(bool ok, String icon, double w) => AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: ok ? 1 : 0.25,
        child: AppIcon(icon, w: w, h: 58),
      );

  @override
  Widget build(BuildContext context) {
    const strengthLabel = ['Weak password', 'Weak password', 'Fair password', 'Good password', 'Strong password'];
    return Scaffold(
      backgroundColor: AppColors.background,
      body: DesignCanvas(
        designHeight: 874,
        background: AppColors.background,
        children: [
          Positioned(top: 0, left: -1, right: -1, height: 287, child: Image.asset(AppImages.bgHeader, fit: BoxFit.cover)),
          Positioned(bottom: 0, left: 0, right: 0, height: 174, child: Image.asset(AppImages.bgFooter, fit: BoxFit.cover)),
          Positioned(
            top: 44,
            left: 24,
            right: 24,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              // Header 342×115 (+40 bottom padding)
              SizedBox(
                height: 115,
                child: Stack(children: [
                  Positioned.fill(
                    child: Column(children: [
                      AppGap.v8,
                      Text('Create Profile', textAlign: TextAlign.center, style: ts(AppFonts.inter, 25, w600, AppColors.textPrimary, lh: 39)),
                      AppGap.v4,
                      Text('Let\'s get to know you better',
                          textAlign: TextAlign.center, style: AppTextStyles.body),
                      AppGap.v24,
                      const OrnamentDivider(icon: 'margin_c8bdf5c5'),
                    ]),
                  ),
                  Positioned(
                    left: 0,
                    top: 4,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: const AppIcon('button_d356ffee', w: 40, h: 40),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 57),
              AppTextField(
                controller: _first,
                leading: const AppIcon('container_565af903', w: 32, h: 58),
                trailing: _check(Validators.isNotBlank(_first.text), 'container_a06b8df4', 33),
                trailingPad: 0,
              ),
              AppGap.v16,
              AppTextField(
                controller: _last,
                leading: const AppIcon('container_565af903', w: 32, h: 58),
                trailing: _check(Validators.isNotBlank(_last.text), 'container_b3fff93d', 36),
                trailingPad: 0,
              ),
              AppGap.v16,
              AppTextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                leading: const AppIcon('container_2c0f2338', w: 36, h: 58),
                trailing: _check(_emailOk, 'container_b3fff93d', 36),
                trailingPad: 0,
              ),
              AppGap.v16,
              AppPasswordField(
                controller: _pass,
                leading: const AppIcon('container_1757eac2', w: 32, h: 58),
                toggleBuilder: (_) => const AppIcon('button_1371b78a', w: 38, h: 53),
              ),
              AppGap.v8,
              SizedBox(
                height: 16,
                child: Row(children: [
                  for (var i = 0; i < 4; i++) ...[
                    if (i > 0) AppGap.h4,
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 50.9,
                      height: 6,
                      decoration: BoxDecoration(
                        // Design shows 2 of 4 bars lit for "Strong password".
                        gradient: i < (_strength / 2).ceil() ? AppColors.goldGradient : null,
                        color: i < (_strength / 2).ceil() ? null : AppColors.divider,
                        borderRadius: AppRadius.pill,
                      ),
                    ),
                  ],
                  AppGap.h12,
                  GradientText(strengthLabel[_strength],
                      style: AppTextStyles.label.c(AppColors.white), gradient: AppColors.goldGradient),
                ]),
              ),
              AppGap.v16,
              AppTextField(
                controller: _confirm,
                obscure: true,
                radius: 16,
                borderColor: AppColors.outline.o(.3),
                leadingWidth: 64,
                leading: const Padding(padding: EdgeInsets.only(left: 23), child: AppIcon('icon_6883af38', w: 16, h: 21)),
                trailing: _check(_match, 'container_ca446278', 36),
                trailingPad: 0,
              ),
              AppGap.v8,
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 5.5, 4, 2.5),
                child: Text(
                  _match ? 'Passwords match' : 'Passwords do not match',
                  style: ts(AppFonts.inter, 12, w500, _match ? AppColors.green82 : AppColors.error, lh: 16, ls: 0.6),
                ),
              ),
              AppGap.v8,
              AppButton(
                label: 'Save & Continue',
                onTap: _valid ? _save : null,
                textStyle: AppTextStyles.button,
              ),
              AppGap.v15,
              const SizedBox(height: 24, child: OrDivider()),
              AppGap.v15,
              SocialButtons(onGoogle: _save, onApple: _save),
              AppGap.v15,
              GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
                child: Text('Already have an account? Login',
                    textAlign: TextAlign.center, style: AppTextStyles.label.c(AppColors.textMuted)),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
