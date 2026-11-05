import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/routes/app_routes.dart';
import 'auth_card_page.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Forgot Password - OTP Verification" (6001:7051)
class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});
  final String email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _c = List.generate(6, (_) => TextEditingController());
  final _f = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    for (final n in _f) {
      n.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final c in _c) {
      c.dispose();
    }
    for (final n in _f) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthCardPage(
      cardTop: 281,
      padding: const EdgeInsets.fromLTRB(19, 32, 19, 32),
      backIcon: 'button_go_back_cee1985f',
      child: Column(children: [
        AuthTitle('Verify your Email', 'Enter the 6-digit code sent to\n${widget.email}', subtitleSize: 14, subtitleLh: 24),
        AppGap.v12,
        Padding(
          padding: AppInsets.v12,
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              for (var i = 0; i < 6; i++)
                SizedBox(
                  width: i == 0 || i == 5 ? 44 : 43,
                  height: 56,
                  child: _box(i),
                ),
            ]),
            AppGap.v24,
            AuthAction(label: 'Verify', onTap: () => Navigator.of(context).pushNamed(AppRoutes.resetPassword)),
          ]),
        ),
        AppGap.v12,
        GestureDetector(
          onTap: () => Navigator.of(context).popUntil((r) => r.settings.name == AppRoutes.login || r.isFirst),
          child: GradientText('Return to Login', style: ts(AppFonts.inter, 14, w500, AppColors.white, lh: 21), gradient: AppColors.goldGradient),
        ),
      ]),
    );
  }

  Widget _box(int i) {
    final focused = _f[i].hasFocus;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.br8,
        border: focused ? null : Border.all(color: AppColors.outline),
        gradient: null,
        boxShadow: focused ? [const BoxShadow(color: AppColors.green700, spreadRadius: 1)] : null,
      ),
      foregroundDecoration: focused
          ? BoxDecoration(borderRadius: AppRadius.br8, border: Border.all(color: AppColors.gold))
          : null,
      alignment: Alignment.center,
      child: TextField(
        controller: _c[i],
        focusNode: _f[i],
        autofocus: i == 0,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        cursorColor: AppColors.green700,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(1)],
        style: ts(AppFonts.inter, 20, w600, AppColors.textPrimary, lh: 24),
        decoration: const InputDecoration(isCollapsed: true, border: InputBorder.none, counterText: ''),
        onChanged: (v) {
          if (v.isNotEmpty && i < 5) _f[i + 1].requestFocus();
          if (v.isEmpty && i > 0) _f[i - 1].requestFocus();
        },
      ),
    );
  }
}
