import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppFonts {
  static const String inter = 'Inter';
  static const String arabic = 'Amiri';
  static const String quran = 'AmiriQuran';
}

/// Shared text styles. All sizes match the Figma frames (390pt wide).
abstract final class AppText {
  static const TextStyle h1 = TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.green800, height: 1.25);
  static const TextStyle h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.3);
  static const TextStyle h3 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.3);
  static const TextStyle title = TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.green800);
  static const TextStyle body = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textSecondary, height: 1.5);
  static const TextStyle bodyStrong = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle label = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textMuted);
  static const TextStyle caption = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textMuted);
  static const TextStyle overline = TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: AppColors.green500);
  static const TextStyle button = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white);
  static const TextStyle arabic = TextStyle(
    fontFamily: AppFonts.arabic,
    fontSize: 22,
    height: 1.9,
    color: AppColors.green800,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle quran = TextStyle(fontFamily: AppFonts.quran, fontSize: 21, height: 2.1, color: AppColors.textPrimary);
}

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
      scaffoldBackgroundColor: AppColors.surface,
      splashFactory: InkRipple.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: AppText.title,
      ),
      dividerColor: AppColors.divider,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.green700),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating, backgroundColor: AppColors.green800),
    );
  }
}
