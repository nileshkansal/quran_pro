import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../home/prayer_sheets.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Enable location" (6001:2783) — 390×980 canvas.
class EnableLocationScreen extends StatelessWidget {
  const EnableLocationScreen({super.key});

  void _next(BuildContext context) => Navigator.of(context).pushNamed(AppRoutes.widgetPromo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: DesignCanvas(
        designHeight: 980,
        background: AppColors.background,
        children: [
          Positioned(
            top: 3,
            left: 1,
            right: 0,
            height: 498,
            child: Container(
              color: AppColors.cream,
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(left: 21, top: -7, width: 346.1, height: 498.3, child: Image.asset(AppImages.locationBg, fit: BoxFit.fill)),
              ]),
            ),
          ),
          const CanvasCenter(top: 79, child: Logo.small(width: 103.6)),
          Positioned(top: MediaQuery.of(context).padding.top, left: 4, child: const ArrowBackButton()),
          Positioned(
            top: 504,
            left: 7,
            right: 7,
            child: Column(children: [
              SizedBox(
                width: 244,
                child: Text('Enable Location for\nPrayer Times & Qibla',
                    textAlign: TextAlign.center, style: ts(AppFonts.cormorant, 23, w700, AppColors.green900, lh: 33)),
              ),
              const SizedBox(height: 12.8),
              Opacity(
                opacity: 0.7,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(width: 48, height: 1, decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.gold45.o(0), AppColors.gold45]))),
                  const SizedBox(width: 6.8),
                  Transform.rotate(angle: 0.785398, child: Container(width: 6, height: 6, color: AppColors.gold45)),
                  const SizedBox(width: 6.8),
                  Container(width: 48, height: 1, decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.gold45, AppColors.gold45.o(0)]))),
                ]),
              ),
              const SizedBox(height: 12.8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.4),
                child: Text(
                  'QuranPro uses your location to calculate exact prayer timings, send accurate Adhan alerts, and point precisely to the Kaaba from anywhere in the world.',
                  textAlign: TextAlign.center,
                  style: ts(AppFonts.inter, 13.5, w400, AppColors.stone600, lh: 21.9),
                ),
              ),
              AppGap.v16,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.stone200.o(.7)),
                  borderRadius: AppRadius.br16,
                ),
                child: Column(children: [
                  _benefit('overlay_d6961cf4', 'Precise Qibla Direction', 'Live compass calibration to Mecca'),
                  AppGap.v10,
                  Container(height: 1, color: AppColors.stone200.o(.5)),
                  AppGap.v10,
                  _benefit('background_7c6c5d11', 'Accurate Adhan Notifications', 'Adjusted to your precise local coordinates'),
                ]),
              ),
              AppGap.v24,
              AppButton(
                label: 'Allow While Using App',
                height: 48,
                borderColor: AppColors.gold35.o(.3),
                leading: const AppIcon('container_ba5fae8f', w: 16.4, h: 16.4),
                textStyle: ts(AppFonts.inter, 14, w600, AppColors.white, lh: 20),
                shadow: AppShadows.md,
                onTap: () {
                  AppState.instance.update(() => AppState.instance.locationAllowed = true);
                  _next(context);
                },
              ),
              AppGap.v10,
              Material(
                color: AppColors.neutral100.o(.8),
                borderRadius: AppRadius.br10,
                child: InkWell(
                  borderRadius: AppRadius.br10,
                  onTap: () async {
                    await showChooseLocationSheet(context);
                    if (context.mounted) _next(context);
                  },
                  child: SizedBox(
                    height: 44,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const AppIcon('container_6d1ed687', w: 12, h: 12),
                      AppGap.h6,
                      Text('Set City Manually', style: AppTextStyles.caption.c(AppColors.green88)),
                    ]),
                  ),
                ),
              ),
              AppGap.v4,
              GestureDetector(
                onTap: () => _next(context),
                child: Padding(
                  padding: AppInsets.all4,
                  child: Text('Not Now', style: AppTextStyles.caption.c(AppColors.stone400)),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _benefit(String icon, String title, String body) => Row(children: [
        AppIcon(icon, w: 28, h: 28),
        AppGap.h10,
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: ts(AppFonts.jakarta, 12, w600, AppColors.stone800, lh: 15)),
            Text(body, style: ts(AppFonts.inter, 11, w400, AppColors.stone500, lh: 13.8)),
          ]),
        ),
      ]);
}
