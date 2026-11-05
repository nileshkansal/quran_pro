import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/figma.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/common.dart';
import '../../widgets/fig_widgets.dart';

/// Figma: "Edit Profile" — Personal Information (6001:589).
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final s = AppState.instance;
  late final _name = TextEditingController(text: s.fullName);
  late final _email = TextEditingController(text: s.email);

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  void _save() {
    final parts = _name.text.trim().split(RegExp(r'\s+'));
    s.update(() {
      s.firstName = parts.first;
      s.lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      s.email = _email.text.trim();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
    Navigator.pop(context);
  }

  Widget _field(String label, TextEditingController c, {TextInputType? type}) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16, ls: 0.6)),
        const SizedBox(height: 4),
        FigInput(
          controller: c,
          keyboardType: type,
          height: 49,
          radius: 8,
          leadingWidth: 12,
          trailingPad: 12,
          borderColor: fc(0xBFC9C2, .3),
          textStyle: ts(Ff.inter, 16, w400, const Color(0xFF6B7280)),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FigCanvas(
        designHeight: 838,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF8FAF6), Colors.white]),
        ),
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top + 24 + 32,
            left: 24,
            right: 24,
            child: Column(children: [
              SizedBox(
                height: 38,
                width: double.infinity,
                child: Stack(alignment: Alignment.center, children: [
                  Text('Personal Information', style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2)),
                  Positioned(
                    left: 0,
                    child: GestureDetector(onTap: () => Navigator.maybePop(context), child: const FigIcon('button_c12c7392', w: 32, h: 38)),
                  ),
                ]),
              ),
              const SizedBox(height: 16 + 24),
              SizedBox(
                width: 128,
                height: 128,
                child: Stack(children: [
                  Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0xFFE6E9E5), spreadRadius: 4)]),
                    child: ClipOval(child: Image.asset(AppImages.avatar, width: 128, height: 128, fit: BoxFit.cover)),
                  ),
                  Positioned(
                    left: 100.3,
                    top: 97.5,
                    child: GestureDetector(
                      onTap: () => showComingSoon(context, 'Photo picker'),
                      child: const FigIcon('button_9fda2055', w: 27.7, h: 30.5),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 24 + 16),
              _field('FULL NAME', _name),
              const SizedBox(height: 16),
              _field('EMAIL ADDRESS', _email, type: TextInputType.emailAddress),
            ]),
          ),
          Positioned(
            top: 626,
            left: 24,
            child: FigButton(
              label: 'Save Changes',
              onTap: _save,
              width: 177,
              height: 60,
              radius: 12,
              textStyle: ts(Ff.inter, 18, w700, Colors.white, lh: 28),
              shadow: [fShadow(fc(0x000000, .1), 0, 2, 4, -2), fShadow(fc(0x000000, .1), 0, 4, 6, -1)],
            ),
          ),
        ],
      ),
    );
  }
}
