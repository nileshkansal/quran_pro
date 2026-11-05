import 'package:flutter/widgets.dart';

/// Design canvas: every Figma frame is 390 × 844 pt (iPhone 14/15).
/// [DesignScale] scales this canvas to the real screen width.
abstract final class AppDesign {
  static const double width = 390;
  static const double height = 844;
}

/// Spacing scale (Figma auto-layout gaps and paddings).
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double s6 = 6;
  static const double sm = 8;
  static const double s10 = 10;
  static const double md = 12;
  static const double s15 = 15;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double s30 = 30;
  static const double xxxl = 32;
  static const double huge = 40;

  /// Default horizontal page padding.
  static const double page = 24;
}

/// Ready-made gaps for Rows / Columns: `AppGap.v16`, `AppGap.h8`.
abstract final class AppGap {
  static const v2 = SizedBox(height: 2);
  static const v4 = SizedBox(height: 4);
  static const v6 = SizedBox(height: 6);
  static const v8 = SizedBox(height: 8);
  static const v10 = SizedBox(height: 10);
  static const v12 = SizedBox(height: 12);
  static const v14 = SizedBox(height: 14);
  static const v15 = SizedBox(height: 15);
  static const v16 = SizedBox(height: 16);
  static const v20 = SizedBox(height: 20);
  static const v24 = SizedBox(height: 24);
  static const v30 = SizedBox(height: 30);
  static const v32 = SizedBox(height: 32);
  static const v40 = SizedBox(height: 40);

  static const h2 = SizedBox(width: 2);
  static const h4 = SizedBox(width: 4);
  static const h6 = SizedBox(width: 6);
  static const h8 = SizedBox(width: 8);
  static const h10 = SizedBox(width: 10);
  static const h12 = SizedBox(width: 12);
  static const h14 = SizedBox(width: 14);
  static const h15 = SizedBox(width: 15);
  static const h16 = SizedBox(width: 16);
  static const h20 = SizedBox(width: 20);
  static const h24 = SizedBox(width: 24);
}

/// Common paddings.
abstract final class AppInsets {
  static const all2 = EdgeInsets.all(2);
  static const all4 = EdgeInsets.all(4);
  static const all8 = EdgeInsets.all(8);
  static const all10 = EdgeInsets.all(10);
  static const all16 = EdgeInsets.all(16);
  static const all20 = EdgeInsets.all(20);
  static const all24 = EdgeInsets.all(24);
  static const h4 = EdgeInsets.symmetric(horizontal: 4);
  static const h8 = EdgeInsets.symmetric(horizontal: 8);
  static const h12 = EdgeInsets.symmetric(horizontal: 12);
  static const h14 = EdgeInsets.symmetric(horizontal: 14);
  static const h16 = EdgeInsets.symmetric(horizontal: 16);
  static const h24 = EdgeInsets.symmetric(horizontal: 24);
  static const v8 = EdgeInsets.symmetric(vertical: 8);
  static const v12 = EdgeInsets.symmetric(vertical: 12);

  /// Standard page padding (24 all round).
  static const page = all24;
}

/// Corner radii: `AppRadius.r12` (double) / `AppRadius.br12` (BorderRadius).
abstract final class AppRadius {
  static const double r4 = 4;
  static const double r6 = 6;
  static const double r8 = 8;
  static const double r10 = 10;
  static const double r12 = 12;
  static const double r16 = 16;
  static const double r20 = 20;
  static const double r24 = 24;
  static const double r40 = 40;
  static const double full = 9999;

  static const br4 = BorderRadius.all(Radius.circular(r4));
  static const br6 = BorderRadius.all(Radius.circular(r6));
  static const br8 = BorderRadius.all(Radius.circular(r8));
  static const br10 = BorderRadius.all(Radius.circular(r10));
  static const br12 = BorderRadius.all(Radius.circular(r12));
  static const br16 = BorderRadius.all(Radius.circular(r16));
  static const br20 = BorderRadius.all(Radius.circular(r20));
  static const br24 = BorderRadius.all(Radius.circular(r24));
  static const br40 = BorderRadius.all(Radius.circular(r40));

  /// Fully rounded (pill / stadium).
  static const pill = BorderRadius.all(Radius.circular(full));
}

/// Fixed component sizes from the Figma components.
abstract final class AppSizes {
  /// Primary button height.
  static const double buttonHeight = 56;
  static const double buttonRadius = AppRadius.r10;

  /// Text-field height and radius.
  static const double inputHeight = 58;
  static const double inputRadius = AppRadius.r10;

  /// Top app bar (below the status bar).
  static const double headerHeight = 64;

  /// Bottom navigation bar.
  static const double bottomNavHeight = 78;

  /// Switch track.
  static const double switchWidth = 44;
  static const double switchHeight = 24;

  /// Icons.
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double iconBadge = 32;
}
