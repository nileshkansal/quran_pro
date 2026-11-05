import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/fig_widgets.dart';

/// Figma: "Notifications" (6001:2590)
class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  void _go(BuildContext context, bool allow) {
    AppState.instance.update(() => AppState.instance.notificationsAllowed = allow);
    Navigator.of(context).pushNamed(AppRoutes.enableLocation);
  }

  @override
  Widget build(BuildContext context) {
    final cardTitle = ts(Ff.inter, 10.2, w500, Colors.black, lh: 14.3);
    final cardBody = ts(Ff.inter, 10.2, w400, fc(0x000000, .6), lh: 14.3);
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBFA),
      body: FigCanvas(
        background: const Color(0xFFFCFBFA),
        children: [
          const Positioned.fill(child: LanternBackdrop(footerTop: 700)),
          Positioned(
            top: 160,
            left: 16,
            right: 16,
            child: Column(children: [
              const DecorDivider(),
              const SizedBox(height: 15),
              SizedBox(
                width: 323,
                child: Text('150+ Unique Motivational Notifications',
                    textAlign: TextAlign.center, style: ts(Ff.poppins, 22, w500, AppColors.textPrimary, lh: 34)),
              ),
              const SizedBox(height: 18),
              Text(
                'We make sure you don’t receive the same notification again for 6 months.',
                textAlign: TextAlign.center,
                style: ts(Ff.hachi, 13, w400, AppColors.textSecondary, lh: 24),
              ),
              const SizedBox(height: 37),
              _card(63, 'splash_screen_447064c1', Text('There are 1,140 minutes in a day.  Can you spend 5 minutes for the Quran?',
                  style: ts(Ff.inter, 10.2, w400, Colors.black, lh: 14.3)), center: true, textWidth: 199),
              const SizedBox(height: 10),
              _card(81, 'splash_screen_7f686245', Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                SizedBox(width: 146, child: Text('Quran will be your intercessor on the day of judgement!', style: cardTitle)),
                const SizedBox(height: 8),
                Text('How strong is your relationship with Quran.', style: cardBody),
              ])),
              const SizedBox(height: 10),
              _card(81, 'splash_screen_31f8a9f0', Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Text('All of humanity and jinn together could never produce a book like the Qur’an.', style: cardTitle),
                const SizedBox(height: 8),
                Text('Why not read it now?', style: cardBody),
              ]), textWidth: 276),
            ]),
          ),
          Positioned(
            bottom: 38,
            left: 23,
            right: 16,
            child: Column(children: [
              FigButton(
                label: 'Allow  Notification',
                onTap: () => _go(context, true),
                leading: const FigIcon('notification_01_23c31fe8', w: 22, h: 22),
                gap: 10,
                textStyle: ts(Ff.inter, 16, w500, Colors.white, lh: 28, ls: -0.2),
              ),
              const SizedBox(height: 7),
              FigButton(
                label: 'Don’t allow',
                onTap: () => _go(context, false),
                style: FigButtonStyle.outline,
                borderColor: fc(0x000000, .5),
                leading: const FigIcon('notification_off_01_b0ab84e5', w: 24, h: 24),
                gap: 10,
                textStyle: ts(Ff.inter, 16, w500, Colors.black, lh: 28, ls: -0.2),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [fShadow(fc(0x000000, .1), 0, 0, 12)],
        ),
        padding: EdgeInsets.fromLTRB(13, center ? 13 : 14.4, 13, 0),
        alignment: Alignment.topLeft,
        child: Row(crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start, children: [
          Container(
            width: 36.8,
            height: 36.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.2),
              boxShadow: [fShadow(fc(0x000000, .2), 0, 2, 14.3)],
            ),
            child: FigIcon(icon, w: 36.8, h: 36.8),
          ),
          const SizedBox(width: 8.2),
          SizedBox(width: textWidth, height: center ? null : 52, child: center ? text : Align(alignment: Alignment.centerLeft, child: text)),
        ]),
      );
}
