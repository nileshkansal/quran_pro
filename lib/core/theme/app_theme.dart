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
}
