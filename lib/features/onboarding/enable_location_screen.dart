import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../widgets/fig_widgets.dart';
import '../home/prayer_sheets.dart';

/// Figma: "Enable location" (6001:2783) — 390×980 canvas.
class EnableLocationScreen extends StatelessWidget {
  const EnableLocationScreen({super.key});

  void _next(BuildContext context) => Navigator.of(context).pushNamed(AppRoutes.widgetPromo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBFA),
      body: FigCanvas(
        designHeight: 980,
        background: const Color(0xFFFCFBFA),
        children: [
          Positioned(
            top: 3,
            left: 1,
            right: 0,
            height: 498,
            child: Container(
              color: const Color(0xFFFEFBF6),
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(left: 21, top: -7, width: 346.1, height: 498.3, child: Image.asset(AppImages.locationBg, fit: BoxFit.fill)),
              ]),
            ),
          ),
          const FigCenter(top: 79, child: Logo.small(width: 103.6)),
          Positioned(top: MediaQuery.of(context).padding.top, left: 4, child: const FigBack()),
          Positioned(
            top: 504,
            left: 7,
            right: 7,
            child: Column(children: [
              SizedBox(
                width: 244,
                child: Text('Enable Location for\nPrayer Times & Qibla',
                    textAlign: TextAlign.center, style: ts(Ff.cormorant, 23, w700, const Color(0xFF03261C), lh: 33)),
              ),
              const SizedBox(height: 12.8),
              Opacity(
                opacity: 0.7,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(width: 48, height: 1, decoration: BoxDecoration(gradient: LinearGradient(colors: [fc(0xCBA14D, 0), fc(0xCBA14D)]))),
                  const SizedBox(width: 6.8),
                  Transform.rotate(angle: 0.785398, child: Container(width: 6, height: 6, color: const Color(0xFFCBA14D))),
                  const SizedBox(width: 6.8),
                  Container(width: 48, height: 1, decoration: BoxDecoration(gradient: LinearGradient(colors: [fc(0xCBA14D), fc(0xCBA14D, 0)]))),
                ]),
              ),
              const SizedBox(height: 12.8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.4),
                child: Text(
                  'QuranPro uses your location to calculate exact prayer timings, send accurate Adhan alerts, and point precisely to the Kaaba from anywhere in the world.',
                  textAlign: TextAlign.center,
                  style: ts(Ff.inter, 13.5, w400, const Color(0xFF57534E), lh: 21.9),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBFAF6),
                  border: Border.all(color: fc(0xE7E5E4, .7)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(children: [
                  _benefit('overlay_d6961cf4', 'Precise Qibla Direction', 'Live compass calibration to Mecca'),
                  const SizedBox(height: 10),
                  Container(height: 1, color: fc(0xE7E5E4, .5)),
                  const SizedBox(height: 10),
                  _benefit('background_7c6c5d11', 'Accurate Adhan Notifications', 'Adjusted to your precise local coordinates'),
                ]),
              ),
              const SizedBox(height: 24),
              FigButton(
                label: 'Allow While Using App',
                height: 48,
                borderColor: fc(0xDFB96C, .3),
                leading: const FigIcon('container_ba5fae8f', w: 16.4, h: 16.4),
                textStyle: ts(Ff.inter, 14, w600, Colors.white, lh: 20),
                shadow: [fShadow(fc(0x000000, .1), 0, 2, 4, -2), fShadow(fc(0x000000, .1), 0, 4, 6, -1)],
                onTap: () {
                  AppState.instance.update(() => AppState.instance.locationAllowed = true);
                  _next(context);
                },
              ),
              const SizedBox(height: 10),
              Material(
                color: fc(0xF5F5F4, .8),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    await showChooseLocationSheet(context);
                    if (context.mounted) _next(context);
                  },
                  child: SizedBox(
                    height: 44,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const FigIcon('container_6d1ed687', w: 12, h: 12),
                      const SizedBox(width: 6),
                      Text('Set City Manually', style: ts(Ff.inter, 12, w500, const Color(0xFF063F30), lh: 16)),
                    ]),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => _next(context),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text('Not Now', style: ts(Ff.inter, 12, w500, const Color(0xFFA8A29E), lh: 16)),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _benefit(String icon, String title, String body) => Row(children: [
        FigIcon(icon, w: 28, h: 28),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: ts(Ff.jakarta, 12, w600, const Color(0xFF292524), lh: 15)),
            Text(body, style: ts(Ff.inter, 11, w400, const Color(0xFF78716C), lh: 13.8)),
          ]),
        ),
      ]);
}
