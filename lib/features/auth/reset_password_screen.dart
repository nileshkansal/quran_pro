import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/fig_widgets.dart';
import 'auth_card_page.dart';

/// Figma: "Reset Password - New Password" (6001:7096)
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _p1 = TextEditingController();
  final _p2 = TextEditingController();
  bool _show1 = false;
  bool _show2 = false;

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

  int get _strength {
    final p = _p1.text;
    var s = 0;
    if (p.length >= 8) s++;
    if (RegExp(r'[A-Z]').hasMatch(p)) s++;
    if (RegExp(r'\d').hasMatch(p)) s++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(p)) s++;
    return s;
  }

  Widget _label(String t) => SizedBox(
        width: double.infinity,
        child: Text(t, style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16, ls: 0.6)),
      );

  Widget _field(TextEditingController c, String hint, String lead, double leadW, bool show, VoidCallback toggle) => FigInput(
        controller: c,
        height: 49,
        radius: 8,
        obscure: !show,
        fill: const Color(0xFFF8FAF6),
        borderColor: AppColors.divider,
        hint: hint,
        hintStyle: ts(Ff.inter, 16, w400, AppColors.outline),
        leadingWidth: 40,
        leading: FigIcon(lead, w: leadW, h: 49),
        trailing: GestureDetector(onTap: toggle, child: const FigIcon('container_8b8819de', w: 34, h: 49)),
        trailingPad: 0,
      );

  @override
  Widget build(BuildContext context) {
    // Segment colours from the design: red · gold · green · grey.
    const segColors = [AppColors.error, AppColors.goldSoft, AppColors.green500, AppColors.green800];
    const names = ['Too short', 'Weak', 'Fair', 'Good', 'Strong'];
    final lit = _p1.text.isEmpty ? 3 : _strength.clamp(1, 4);
    return AuthCardPage(
      cardTop: 260,
      padding: const EdgeInsets.all(24),
      backIcon: 'button_c40105e5',
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text('Reset Password', style: ts(Ff.poppins, 20, w600, AppColors.textPrimary, lh: 28, ls: -0.2)),
        ),
        Text('Create a new secure password for\nyour account.',
            textAlign: TextAlign.center, style: ts(Ff.inter, 16, w400, AppColors.textSecondary, lh: 24)),
        const SizedBox(height: 24),
        _label('NEW PASSWORD'),
        const SizedBox(height: 8),
        _field(_p1, 'Enter new password', 'container_0abfae6c', 28, _show1, () => setState(() => _show1 = !_show1)),
        const SizedBox(height: 24),
        Row(children: [
          Text('Password Strength:', style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16, ls: 0.6)),
          const Spacer(),
          Text(_p1.text.isEmpty ? 'Strong' : names[_strength], style: ts(Ff.inter, 12, w500, AppColors.green500, lh: 16, ls: 0.6)),
        ]),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: Row(children: [
            for (var i = 0; i < 4; i++) ...[
              if (i > 0) const SizedBox(width: 4),
              Expanded(child: Container(height: 6, color: i < lit ? segColors[i] : AppColors.divider)),
            ],
          ]),
        ),
        const SizedBox(height: 24),
        _label('CONFIRM NEW PASSWORD'),
        const SizedBox(height: 8),
        _field(_p2, 'Confirm new password', 'container_d3e0e10a', 31, _show2, () => setState(() => _show2 = !_show2)),
        if (_p2.text.isNotEmpty && _p2.text != _p1.text)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Align(alignment: Alignment.centerLeft, child: Text('Passwords do not match', style: ts(Ff.inter, 11, w500, AppColors.error))),
          ),
        const SizedBox(height: 8 + 24),
        AuthAction(
          label: 'Update Password',
          height: 42,
          arrow: false,
          textStyle: ts(Ff.inter, 12, w500, Colors.white, lh: 16, ls: 0.6),
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.resetSuccess),
        ),
      ]),
    );
  }
}
