import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/fig_widgets.dart';

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
  bool _show = false;

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

  int get _strength {
    final p = _pass.text;
    var s = 0;
    if (p.length >= 8) s++;
    if (RegExp(r'[A-Z]').hasMatch(p) && RegExp(r'[a-z]').hasMatch(p)) s++;
    if (RegExp(r'\d').hasMatch(p)) s++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(p)) s++;
    return s;
  }

  bool get _emailOk => RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(_email.text);
  bool get _match => _pass.text.isNotEmpty && _pass.text == _confirm.text;
  bool get _valid => _first.text.trim().isNotEmpty && _emailOk && _strength >= 3 && _match;

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
        child: FigIcon(icon, w: w, h: 58),
      );

  @override
  Widget build(BuildContext context) {
    const strengthLabel = ['Weak password', 'Weak password', 'Fair password', 'Good password', 'Strong password'];
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBFA),
      body: FigCanvas(
        designHeight: 874,
        background: const Color(0xFFFCFBFA),
        children: [
          Positioned(top: 0, left: -1, right: -1, height: 287, child: Image.asset('assets/images/bg_header.jpg', fit: BoxFit.cover)),
          Positioned(bottom: 0, left: 0, right: 0, height: 174, child: Image.asset('assets/images/bg_footer.png', fit: BoxFit.cover)),
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
                      const SizedBox(height: 8),
                      Text('Create Profile', textAlign: TextAlign.center, style: ts(Ff.inter, 25, w600, AppColors.textPrimary, lh: 39)),
                      const SizedBox(height: 4),
                      Text('Let\'s get to know you better',
                          textAlign: TextAlign.center, style: ts(Ff.inter, 16, w400, AppColors.textSecondary, lh: 24)),
                      const SizedBox(height: 32),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Expanded(child: Container(height: 1, color: fc(0xC9A45B, .3))),
                        const FigIcon('margin_c8bdf5c5', w: 40, h: 16),
                        Expanded(child: Container(height: 1, color: fc(0xC9A45B, .3))),
                      ]),
                    ]),
                  ),
                  Positioned(
                    left: 0,
                    top: 4,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: const FigIcon('button_d356ffee', w: 40, h: 40),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 57),
              FigInput(
                controller: _first,
                leading: const FigIcon('container_565af903', w: 32, h: 58),
                trailing: _check(_first.text.trim().isNotEmpty, 'container_a06b8df4', 33),
                trailingPad: 0,
              ),
              const SizedBox(height: 16),
              FigInput(
                controller: _last,
                leading: const FigIcon('container_565af903', w: 32, h: 58),
                trailing: _check(_last.text.trim().isNotEmpty, 'container_b3fff93d', 36),
                trailingPad: 0,
              ),
              const SizedBox(height: 16),
              FigInput(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                leading: const FigIcon('container_2c0f2338', w: 36, h: 58),
                trailing: _check(_emailOk, 'container_b3fff93d', 36),
                trailingPad: 0,
              ),
              const SizedBox(height: 16),
              FigInput(
                controller: _pass,
                obscure: !_show,
                leading: const FigIcon('container_1757eac2', w: 32, h: 58),
                trailing: GestureDetector(
                  onTap: () => setState(() => _show = !_show),
                  child: const FigIcon('button_1371b78a', w: 38, h: 53),
                ),
                trailingPad: 0,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 16,
                child: Row(children: [
                  for (var i = 0; i < 4; i++) ...[
                    if (i > 0) const SizedBox(width: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 50.9,
                      height: 6,
                      decoration: BoxDecoration(
                        // Design shows 2 of 4 bars lit for "Strong password".
                        gradient: i < (_strength / 2).ceil() ? AppColors.goldGradient : null,
                        color: i < (_strength / 2).ceil() ? null : AppColors.divider,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ],
                  const SizedBox(width: 12),
                  GradientText(strengthLabel[_strength],
                      style: ts(Ff.inter, 12, w500, Colors.white, lh: 16, ls: 0.6), gradient: AppColors.goldGradient),
                ]),
              ),
              const SizedBox(height: 16),
              FigInput(
                controller: _confirm,
                obscure: true,
                radius: 16,
                borderColor: fc(0xBFC9C2, .3),
                leadingWidth: 64,
                leading: const Padding(padding: EdgeInsets.only(left: 23), child: FigIcon('icon_6883af38', w: 16, h: 21)),
                trailing: _check(_match, 'container_ca446278', 36),
                trailingPad: 0,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 5.5, 4, 2.5),
                child: Text(
                  _match ? 'Passwords match' : 'Passwords do not match',
                  style: ts(Ff.inter, 12, w500, _match ? const Color(0xFF075B45) : AppColors.error, lh: 16, ls: 0.6),
                ),
              ),
              const SizedBox(height: 8),
              FigButton(
                label: 'Save & Continue',
                onTap: _valid ? _save : null,
                textStyle: ts(Ff.inter, 16, w500, Colors.white, lh: 28, ls: -0.2),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 24, child: OrDivider()),
              const SizedBox(height: 15),
              SocialRow(onGoogle: _save, onApple: _save),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
                child: Text('Already have an account? Login',
                    textAlign: TextAlign.center, style: ts(Ff.inter, 12, w500, AppColors.textMuted, lh: 16, ls: 0.6)),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
