import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Notifications" (6001:2590)
class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  void _go(BuildContext context, bool allow) {
    AppState.instance.update(() => AppState.instance.notificationsAllowed = allow);
    Navigator.of(context).pushNamed(AppRoutes.enableLocation);
  }

  @override
  Widget build(BuildContext context) {
    final cardTitle = ts(AppFonts.inter, 10.2, w500, AppColors.pureBlack, lh: 14.3);
    final cardBody = ts(AppFonts.inter, 10.2, w400, AppColors.pureBlack.o(.6), lh: 14.3);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: DesignCanvas(
        background: AppColors.background,
        children: [
          const Positioned.fill(child: LanternBackdrop(footerTop: 700)),
          Positioned(
            top: 160,
            left: 16,
            right: 16,
            child: Column(children: [
              const DecorDivider(),
              AppGap.v15,
              SizedBox(
                width: 323,
                child: Text('150+ Unique Motivational Notifications',
                    textAlign: TextAlign.center, style: ts(AppFonts.poppins, 22, w500, AppColors.textPrimary, lh: 34)),
              ),
              const SizedBox(height: 18),
              Text(
                'We make sure you don’t receive the same notification again for 6 months.',
                textAlign: TextAlign.center,
                style: ts(AppFonts.hachi, 13, w400, AppColors.textSecondary, lh: 24),
              ),
              const SizedBox(height: 37),
              _card(63, 'splash_screen_447064c1', Text('There are 1,140 minutes in a day.  Can you spend 5 minutes for the Quran?',
                  style: ts(AppFonts.inter, 10.2, w400, AppColors.pureBlack, lh: 14.3)), center: true, textWidth: 199),
              AppGap.v10,
              _card(81, 'splash_screen_7f686245', Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                SizedBox(width: 146, child: Text('Quran will be your intercessor on the day of judgement!', style: cardTitle)),
                AppGap.v8,
                Text('How strong is your relationship with Quran.', style: cardBody),
              ])),
              AppGap.v10,
              _card(81, 'splash_screen_31f8a9f0', Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Text('All of humanity and jinn together could never produce a book like the Qur’an.', style: cardTitle),
                AppGap.v8,
                Text('Why not read it now?', style: cardBody),
              ]), textWidth: 276),
            ]),
          ),
          Positioned(
            bottom: 38,
            left: 23,
            right: 16,
            child: Column(children: [
              AppButton(
                label: 'Allow  Notification',
                onTap: () => _go(context, true),
                leading: const AppIcon('notification_01_23c31fe8', w: 22, h: 22),
                gap: 10,
                textStyle: AppTextStyles.button,
              ),
              const SizedBox(height: 7),
              AppButton(
                label: 'Don’t allow',
                onTap: () => _go(context, false),
                variant: AppButtonVariant.outline,
                borderColor: AppColors.pureBlack.o(.5),
                leading: const AppIcon('notification_off_01_b0ab84e5', w: 24, h: 24),
                gap: 10,
                textStyle: AppTextStyles.button.c(AppColors.pureBlack),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _card(double h, String icon, Widget text, {bool center = false, double textWidth = 208}) => Container(
        height: h,
        width: 358,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [fShadow(AppColors.pureBlack.o(.1), 0, 0, 12)],
        ),
        padding: EdgeInsets.fromLTRB(13, center ? 13 : 14.4, 13, 0),
        alignment: Alignment.topLeft,
        child: Row(crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start, children: [
          Container(
            width: 36.8,
            height: 36.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.2),
              boxShadow: [fShadow(AppColors.pureBlack.o(.2), 0, 2, 14.3)],
            ),
            child: AppIcon(icon, w: 36.8, h: 36.8),
          ),
          const SizedBox(width: 8.2),
          SizedBox(width: textWidth, height: center ? null : 52, child: center ? text : Align(alignment: Alignment.centerLeft, child: text)),
        ]),
      );
}
