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
/// * System font scaling and the accessibility "bold text" setting are disabled: with a pixel-perfect canvas a larger
///   system font would overflow fixed Figma boxes. Quran text size is
///   controlled in-app (Reading Settings → Font Size).
class DesignScale extends StatelessWidget {
  const DesignScale({
    super.key,
    required this.child,
    this.designWidth = 390,
    this.maxScale = 1.25,
    this.background = AppColors.surface,
  });

  final Widget child;
  final double designWidth;
  final double maxScale;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    if (size.isEmpty) return child;

    // Phones: scale = width / 390, so the canvas fills the width exactly.
    // Tablets: the scale is capped and the 390 canvas is centred.
    final scale = math.min(size.width / designWidth, maxScale);
    final w = designWidth;
    final h = size.height / scale;

    EdgeInsets s(EdgeInsets e) => e / scale;
    final data = mq.copyWith(
      size: Size(w, h),
      devicePixelRatio: mq.devicePixelRatio * scale,
      padding: s(mq.padding),
      viewPadding: s(mq.viewPadding),
      viewInsets: s(mq.viewInsets),
      systemGestureInsets: s(mq.systemGestureInsets),
      textScaler: TextScaler.noScaling,
      // Android/Samsung "Bold font" makes every Text bold (wider) and would
      // overflow the fixed Figma boxes, like a larger system font.
      boldText: false,
    );

    return ColoredBox(
      color: background,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: w * scale,
          height: size.height,
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
    );
  }
}
