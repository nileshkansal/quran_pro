import 'package:flutter/widgets.dart';

import 'app_colors.dart';

/// Figma drop shadow → BoxShadow (Figma blur = CSS blur radius).
BoxShadow fShadow(Color color, double x, double y, double blur, [double spread = 0]) =>
    BoxShadow(color: color, offset: Offset(x, y), blurRadius: blur, spreadRadius: spread);

/// Shadow presets used across the Figma frames.
abstract final class AppShadows {
  /// Very soft card shadow (0 4 20, black 4 %).
  static final soft = [fShadow(AppColors.pureBlack.o(.04), 0, 4, 20)];

  /// Hairline lift (0 1 2, black 5 %).
  static final xs = [fShadow(AppColors.pureBlack.o(.05), 0, 1, 2)];

  /// Tailwind `shadow-md` (buttons, raised cards).
  static final md = [fShadow(AppColors.pureBlack.o(.1), 0, 2, 4, -2), fShadow(AppColors.pureBlack.o(.1), 0, 4, 6, -1)];

  /// Tailwind `shadow-lg`.
  static final lg = [fShadow(AppColors.pureBlack.o(.1), 0, 4, 6, -4), fShadow(AppColors.pureBlack.o(.1), 0, 10, 15, -3)];

  /// Glow around floating cards (0 0 15, black 10 %).
  static final glow = [fShadow(AppColors.pureBlack.o(.1), 0, 0, 15)];
}
