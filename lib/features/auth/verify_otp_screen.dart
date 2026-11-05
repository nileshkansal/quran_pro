import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import 'auth_card_page.dart';

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
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              for (var i = 0; i < 6; i++)
                SizedBox(
                  width: i == 0 || i == 5 ? 44 : 43,
                  height: 56,
                  child: _box(i),
                ),
            ]),
            const SizedBox(height: 24),
            AuthAction(label: 'Verify', onTap: () => Navigator.of(context).pushNamed(AppRoutes.resetPassword)),
          ]),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Navigator.of(context).popUntil((r) => r.settings.name == AppRoutes.login || r.isFirst),
          child: GradientText('Return to Login', style: ts(Ff.inter, 14, w500, Colors.white, lh: 21), gradient: AppColors.goldGradient),
        ),
      ]),
    );
  }

  Widget _box(int i) {
    final focused = _f[i].hasFocus;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF6),
        borderRadius: BorderRadius.circular(8),
        border: focused ? null : Border.all(color: AppColors.outline),
        gradient: null,
        boxShadow: focused ? [const BoxShadow(color: Color(0xFF07543D), spreadRadius: 1)] : null,
      ),
      foregroundDecoration: focused
          ? BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.gold))
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
        style: ts(Ff.inter, 20, w600, AppColors.textPrimary, lh: 24),
        decoration: const InputDecoration(isCollapsed: true, border: InputBorder.none, counterText: ''),
        onChanged: (v) {
          if (v.isNotEmpty && i < 5) _f[i + 1].requestFocus();
          if (v.isEmpty && i > 0) _f[i - 1].requestFocus();
        },
      ),
    );
  }
}
