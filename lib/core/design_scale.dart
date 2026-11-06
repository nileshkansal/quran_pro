import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/theme/theme.dart';

/// Renders the whole app on a fixed 390-dp-wide Figma canvas and scales it
/// uniformly to the phone's real width, so every screen keeps the exact
/// Figma proportions on 360-dp, 393-dp, 412-dp and 430-dp phones alike.
///
/// * Layout always happens at [designWidth] (unless the scale is clamped on
///   tablets, where the phone-width canvas is centred instead).
/// * `MediaQuery` size, paddings and insets are converted into design units
///   so SafeArea, keyboard insets and bottom sheets keep working.
/// * System font scaling and the accessibility "bold text" setting are
///   disabled: with a pixel-perfect canvas they would overflow fixed Figma
///   boxes. Quran text size is controlled in-app (Reading Settings → Font Size).
/// * Android 15+ draws every app edge-to-edge, with the system navigation bar
///   (3 buttons or gesture handle) on top of the app. The app is laid out
///   above that bar and the bar area is filled with [navigationBarColor], so
///   no screen, button or sheet is ever covered by the system buttons.
class DesignScale extends StatelessWidget {
  const DesignScale({
    super.key,
    required this.child,
    this.designWidth = AppDesign.width,
    this.maxScale = 1.25,
    this.background = AppColors.surface,
    this.navigationBarColor = AppColors.cream,
  });

  final Widget child;
  final double designWidth;
  final double maxScale;
  final Color background;

  /// Fill behind the system navigation bar (matches the bottom tab bar).
  final Color navigationBarColor;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    if (size.isEmpty) return child;

    // Space taken by the system navigation bar (0 while the keyboard is up,
    // because the keyboard inset already covers it).
    final navBar = mq.padding.bottom;
    final appHeight = size.height - navBar;

    // Phones: scale = width / 390, so the canvas fills the width exactly.
    // Tablets: the scale is capped and the 390 canvas is centred.
    final scale = math.min(size.width / designWidth, maxScale);
    final w = designWidth;
    final h = appHeight / scale;

    EdgeInsets s(EdgeInsets e) => e / scale;
    final data = mq.copyWith(
      size: Size(w, h),
      devicePixelRatio: mq.devicePixelRatio * scale,
      // The bottom inset is consumed here, so screens see 0 at the bottom.
      padding: s(mq.padding.copyWith(bottom: 0)),
      viewPadding: s(mq.viewPadding.copyWith(bottom: math.max(0, mq.viewPadding.bottom - navBar))),
      viewInsets: s(mq.viewInsets.copyWith(bottom: math.max(0, mq.viewInsets.bottom - navBar))),
      systemGestureInsets: s(mq.systemGestureInsets),
      textScaler: TextScaler.noScaling,
      // Android/Samsung "Bold font" makes every Text bold (wider) and would
      // overflow the fixed Figma boxes, like a larger system font.
      boldText: false,
    );

    return ColoredBox(
      color: background,
      child: Column(children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: w * scale,
              height: appHeight,
              child: FittedBox(
                fit: BoxFit.fill,
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: w,
                  height: h,
                  child: MediaQuery(data: data, child: child),
                ),
              ),
            ),
          ),
        ),
        if (navBar > 0) SizedBox(height: navBar, width: double.infinity, child: ColoredBox(color: navigationBarColor)),
      ]),
    );
  }
}
