import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_text_styles.dart';

/// Material theme built from the design tokens.
abstract final class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.green700,
      primary: AppColors.green700,
      secondary: AppColors.gold,
      surface: AppColors.white,
      error: AppColors.error,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: AppFonts.inter,
      // Material 3's default type geometry adds letter spacing (0.1–0.5) and
      // line heights (1.2–1.5) to every Text. Figma styles that don't set
      // them would inherit those values and render wider/taller than the
      // design, so the geometry is replaced with neutral values.
      typography: Typography.material2021(englishLike: _neutralGeometry, dense: _neutralGeometry, tall: _neutralGeometry),
      scaffoldBackgroundColor: AppColors.surface,
      splashFactory: InkRipple.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: AppTextStyles.title,
      ),
      dividerColor: AppColors.divider,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.green700, selectionHandleColor: AppColors.green700),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.green800,
        contentTextStyle: AppTextStyles.bodySmall.c(AppColors.white),
      ),
    );
  }

  static TextStyle _geo(double size, FontWeight weight) => TextStyle(
        fontSize: size,
        fontWeight: weight,
        letterSpacing: 0,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );

  static final TextTheme _neutralGeometry = TextTheme(
    displayLarge: _geo(57, FontWeight.w400),
    displayMedium: _geo(45, FontWeight.w400),
    displaySmall: _geo(36, FontWeight.w400),
    headlineLarge: _geo(32, FontWeight.w400),
    headlineMedium: _geo(28, FontWeight.w400),
    headlineSmall: _geo(24, FontWeight.w400),
    titleLarge: _geo(22, FontWeight.w400),
    titleMedium: _geo(16, FontWeight.w500),
    titleSmall: _geo(14, FontWeight.w500),
    labelLarge: _geo(14, FontWeight.w500),
    labelMedium: _geo(12, FontWeight.w500),
    labelSmall: _geo(11, FontWeight.w500),
    bodyLarge: _geo(16, FontWeight.w400),
    bodyMedium: _geo(14, FontWeight.w400),
    bodySmall: _geo(12, FontWeight.w400),
  );
}
