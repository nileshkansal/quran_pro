import 'package:flutter/material.dart';

/// Colour tokens pulled from the "Quran Pro App UI Design V1" Figma file.
abstract final class AppColors {
  // Brand greens
  static const Color green900 = Color(0xFF03261C);
  static const Color green800 = Color(0xFF003B29);
  static const Color green700 = Color(0xFF07543D);
  static const Color green600 = Color(0xFF0D5C46);
  static const Color green500 = Color(0xFF176B4D);
  static const Color green300 = Color(0xFF84C7A9);
  static const Color greenTint = Color(0xFFE3F1EA);
  static const Color mint = Color(0xFFDCEFE6);

  // Brand golds
  static const Color goldLight = Color(0xFFE6B75C);
  static const Color gold = Color(0xFFD4A349);
  static const Color goldDark = Color(0xFFB88628);
  static const Color goldSoft = Color(0xFFE8C177);
  static const Color goldMuted = Color(0xFFC9A45B);
  static const Color goldTint = Color(0xFFFBF1DC);

  // Neutrals
  static const Color textPrimary = Color(0xFF191C1A);
  static const Color textSecondary = Color(0xFF404944);
  static const Color textMuted = Color(0xFF707973);
  static const Color outline = Color(0xFFBFC9C2);
  static const Color divider = Color(0xFFE1E3DF);
  static const Color surface = Color(0xFFF8FAF6);
  static const Color surfaceAlt = Color(0xFFF2F4F0);
  static const Color surfaceDim = Color(0xFFECEFEB);
  static const Color cream = Color(0xFFFFF8F3);
  static const Color creamDeep = Color(0xFFFBF3EA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF0E0E10);
  static const Color error = Color(0xFFBA1A1A);

  static const LinearGradient goldGradient = LinearGradient(colors: [goldLight, gold, goldDark], stops: [0, 0.5, 1]);

  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [green700, green800],
  );

  static const LinearGradient pageGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [surface, white],
  );
}
