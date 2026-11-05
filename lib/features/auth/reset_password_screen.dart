import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import 'auth_card_page.dart';
import '../../core/theme/theme.dart';
import '../../core/utils/validators.dart';
import '../../widgets/widgets.dart';

/// Figma: "Reset Password - New Password" (6001:7096)
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _p1 = TextEditingController();
  final _p2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _p1.addListener(() => setState(() {}));
    _p2.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _p1.dispose();
    _p2.dispose();
    super.dispose();
  }

  int get _strength => Validators.passwordStrength(_p1.text);

  Widget _label(String t) => SizedBox(
        width: double.infinity,
        child: Text(t, style: AppTextStyles.label),
      );

  Widget _field(TextEditingController c, String hint, String lead, double leadW) => AppPasswordField(
        controller: c,
        height: 49,
        radius: AppRadius.r8,
        fill: AppColors.surface,
        borderColor: AppColors.divider,
        hint: hint,
        hintStyle: ts(AppFonts.inter, 16, w400, AppColors.outline),
        leadingWidth: 40,
        leading: AppIcon(lead, w: leadW, h: 49),
        toggleBuilder: (_) => const AppIcon('container_8b8819de', w: 34, h: 49),
      );

  @override
  Widget build(BuildContext context) {
    // Segment colours from the design: red · gold · green · grey.
    const segColors = [AppColors.error, AppColors.goldSoft, AppColors.green500, AppColors.green800];
    const names = ['Too short', 'Weak', 'Fair', 'Good', 'Strong'];
    final lit = _p1.text.isEmpty ? 3 : _strength.clamp(1, 4);
    return AuthCardPage(
      cardTop: 260,
      padding: AppInsets.all24,
      backIcon: 'button_c40105e5',
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text('Reset Password', style: ts(AppFonts.poppins, 20, w600, AppColors.textPrimary, lh: 28, ls: -0.2)),
        ),
        Text('Create a new secure password for\nyour account.',
            textAlign: TextAlign.center, style: AppTextStyles.body),
        AppGap.v24,
        _label('NEW PASSWORD'),
        AppGap.v8,
        _field(_p1, 'Enter new password', 'container_0abfae6c', 28),
        AppGap.v24,
        Row(children: [
          Text('Password Strength:', style: AppTextStyles.label),
          const Spacer(),
          Text(_p1.text.isEmpty ? 'Strong' : names[_strength], style: AppTextStyles.label.c(AppColors.green500)),
        ]),
        AppGap.v8,
        ClipRRect(
          borderRadius: AppRadius.pill,
          child: Row(children: [
            for (var i = 0; i < 4; i++) ...[
              if (i > 0) AppGap.h4,
              Expanded(child: Container(height: 6, color: i < lit ? segColors[i] : AppColors.divider)),
            ],
          ]),
        ),
        AppGap.v24,
        _label('CONFIRM NEW PASSWORD'),
        AppGap.v8,
        _field(_p2, 'Confirm new password', 'container_d3e0e10a', 31),
        if (_p2.text.isNotEmpty && _p2.text != _p1.text)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Align(alignment: Alignment.centerLeft, child: Text('Passwords do not match', style: ts(AppFonts.inter, 11, w500, AppColors.error))),
          ),
        const SizedBox(height: 8 + 24),
        AuthAction(
          label: 'Update Password',
          height: 42,
          arrow: false,
          textStyle: AppTextStyles.label.c(AppColors.white),
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.resetSuccess),
        ),
      ]),
    );
  }
}
