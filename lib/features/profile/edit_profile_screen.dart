import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/theme.dart';
import '../../core/utils/formatters.dart';
import '../../widgets/widgets.dart';

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
    final (first, last) = Formatters.splitName(_name.text);
    s.update(() {
      s.firstName = first;
      s.lastName = last;
      s.email = _email.text.trim();
    });
    showAppSnackBar(context, 'Profile updated');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DesignCanvas(
        designHeight: 838,
        decoration: const BoxDecoration(
          gradient: AppColors.pageGradient,
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
                  Text('Personal Information', style: AppTextStyles.title),
                  Positioned(
                    left: 0,
                    child: GestureDetector(onTap: () => Navigator.maybePop(context), child: const AppIcon('button_c12c7392', w: 32, h: 38)),
                  ),
                ]),
              ),
              const SizedBox(height: 16 + 24),
              SizedBox(
                width: 128,
                height: 128,
                child: Stack(children: [
                  Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppColors.grey09, spreadRadius: 4)]),
                    child: ClipOval(child: Image.asset(AppImages.avatar, width: 128, height: 128, fit: BoxFit.cover)),
                  ),
                  Positioned(
                    left: 100.3,
                    top: 97.5,
                    child: GestureDetector(
                      onTap: () => showComingSoon(context, 'Photo picker'),
                      child: const AppIcon('button_9fda2055', w: 27.7, h: 30.5),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 24 + 16),
              AppLabeledField(label: 'FULL NAME', controller: _name),
              AppGap.v16,
              AppLabeledField(label: 'EMAIL ADDRESS', controller: _email, keyboardType: TextInputType.emailAddress),
            ]),
          ),
          Positioned(
            top: 626,
            left: 24,
            child: AppButton(
              label: 'Save Changes',
              onTap: _save,
              width: 177,
              height: 60,
              radius: 12,
              textStyle: ts(AppFonts.inter, 18, w700, AppColors.white, lh: 28),
              shadow: AppShadows.md,
            ),
          ),
        ],
      ),
    );
  }
}
