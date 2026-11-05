import 'package:flutter/material.dart';

/// Every colour used in the app, taken from the "Quran Pro App UI Design V1"
/// Figma file. Screens must use these tokens — never `Color(0x…)` literals.
///
/// Brand and core tokens have semantic names. Screen-specific Figma shades
/// are named `<family><darkness %>` (e.g. `gold63` = a gold that is 63 %
/// dark) or by their Tailwind name when the designer used a Tailwind colour
/// (`stone800`, `emerald500`). Transparent variants: `AppColors.green800.o(.2)`.
abstract final class AppColors {
  static const Color transparent = Color(0x00000000);

  // Brand greens
  static const Color green900 = Color(0xFF03261C);
  static const Color green800 = Color(0xFF003B29);
  static const Color green700 = Color(0xFF07543D);
  static const Color green600 = Color(0xFF0D5C46);
  static const Color green500 = Color(0xFF176B4D);
  static const Color green300 = Color(0xFF84C7A9);

  // Brand golds
  static const Color goldLight = Color(0xFFE6B75C);
  static const Color gold = Color(0xFFD4A349);
  static const Color goldDark = Color(0xFFB88628);
  static const Color goldSoft = Color(0xFFE8C177);
  static const Color goldMuted = Color(0xFFC9A45B);

  // Core neutrals & surfaces
  static const Color textPrimary = Color(0xFF191C1A);
  static const Color textSecondary = Color(0xFF404944);
  static const Color textMuted = Color(0xFF707973);
  static const Color outline = Color(0xFFBFC9C2);
  static const Color divider = Color(0xFFE1E3DF);
  static const Color surface = Color(0xFFF8FAF6);
  static const Color surfaceAlt = Color(0xFFF2F4F0);
  static const Color surfaceDim = Color(0xFFECEFEB);
  static const Color cream = Color(0xFFFFF8F3);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF0E0E10);
  static const Color error = Color(0xFFBA1A1A);

  // Background
  static const Color background = Color(0xFFFCFBFA);

  // Greens (screen-specific Figma shades)
  static const Color emerald50 = Color(0xFFECFDF5);
  static const Color emerald500 = Color(0xFF10B981);
  static const Color emerald900 = Color(0xFF064E3B);
  static const Color green15 = Color(0xFFC3ECD9);
  static const Color green20 = Color(0xFFA4F3CC);
  static const Color green30 = Color(0xFF91D4B6);
  static const Color green31 = Color(0xFF89D6B1);
  static const Color green73 = Color(0xFF207153);
  static const Color green72 = Color(0xFF0A853A);
  static const Color green79 = Color(0xFF0D5C3A);
  static const Color green80 = Color(0xFF264135);
  static const Color green81 = Color(0xFF006345);
  static const Color green82 = Color(0xFF075B45);
  static const Color green83 = Color(0xFF1A3830);
  static const Color green84 = Color(0xFF064A3A);
  static const Color green85 = Color(0xFF004D3A);
  static const Color green87 = Color(0xFF19332C);
  static const Color green86 = Color(0xFF014630);
  static const Color green88 = Color(0xFF063F30);
  static const Color green89 = Color(0xFF0D3829);
  static const Color green90 = Color(0xFF0D261E);
  static const Color green91 = Color(0xFF022C22);
  static const Color olive10 = Color(0xFFE3ECDE);

  // Golds, ambers & warm browns
  static const Color amber50 = Color(0xFFFFFBEB);
  static const Color amber100 = Color(0xFFFEF3C7);
  static const Color amber200 = Color(0xFFFDE68A);
  static const Color amber300 = Color(0xFFFCD34D);
  static const Color gold04 = Color(0xFFFAF5EE);
  static const Color gold05 = Color(0xFFFCF2E7);
  static const Color gold07 = Color(0xFFF3F1E8);
  static const Color gold06 = Color(0xFFFAF3E0);
  static const Color gold09 = Color(0xFFF9EDDC);
  static const Color gold08 = Color(0xFFF0EEE4);
  static const Color gold12 = Color(0xFFF4EDE0);
  static const Color gold11 = Color(0xFFF8EAD4);
  static const Color gold10 = Color(0xFFEFE7DC);
  static const Color gold13 = Color(0xFFE8E2D5);
  static const Color gold17 = Color(0xFFFFDEAA);
  static const Color gold18 = Color(0xFFFFDEA3);
  static const Color gold19 = Color(0xFFE7D3B5);
  static const Color gold21 = Color(0xFFEED9AD);
  static const Color gold20 = Color(0xFFE3D0B5);
  static const Color gold24 = Color(0xFFE6D39D);
  static const Color gold35 = Color(0xFFDFB96C);
  static const Color gold36 = Color(0xFFD9B46B);
  static const Color gold37 = Color(0xFFD0AA6F);
  static const Color gold41 = Color(0xFFC5A869);
  static const Color gold45 = Color(0xFFCBA14D);
  static const Color gold48 = Color(0xFFC99A3E);
  static const Color gold53 = Color(0xFFBE8C30);
  static const Color gold63 = Color(0xFFAE790E);
  static const Color gold74 = Color(0xFF4F4537);
  static const Color gold75 = Color(0xFF7D5700);
  static const Color gold81 = Color(0xFF5F4504);
  static const Color gold90 = Color(0xFF1F1B14);

  // Greys (stone / neutral / gray / slate scales)
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  static const Color grey02 = Color(0xFFFBF7F2);
  static const Color grey04 = Color(0xFFF0F6F4);
  static const Color grey07 = Color(0xFFF1F6EC);
  static const Color grey06 = Color(0xFFEBF4F0);
  static const Color grey09 = Color(0xFFE6E9E5);
  static const Color grey15 = Color(0xFFD9D9D9);
  static const Color grey38 = Color(0xFF9AA19D);
  static const Color grey46 = Color(0xFF8B8787);
  static const Color grey49 = Color(0xFF8C847A);
  static const Color grey58 = Color(0xFF657069);
  static const Color grey66 = Color(0xFF5F5850);
  static const Color grey84 = Color(0xFF27272A);
  static const Color grey91 = Color(0xFF18181B);
  static const Color grey95 = Color(0xFF0D0C0A);
  static const Color grey96 = Color(0xFF09090B);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral900 = Color(0xFF171717);
  static const Color pureBlack = Color(0xFF000000);
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate700 = Color(0xFF334155);
  static const Color slateGray600 = Color(0xFF4A5568);
  static const Color stone200 = Color(0xFFE7E5E4);
  static const Color stone300 = Color(0xFFD6D3D1);
  static const Color stone400 = Color(0xFFA8A29E);
  static const Color stone500 = Color(0xFF78716C);
  static const Color stone600 = Color(0xFF57534E);
  static const Color stone700 = Color(0xFF44403C);
  static const Color stone800 = Color(0xFF292524);

  // Other accents
  static const Color blue85 = Color(0xFF1C252E);
  static const Color purple59 = Color(0xFF9814BE);

  // Gradients
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

/// `AppColors.outline.o(.3)` — the colour at 30 % opacity (Figma fill opacity).
extension ColorOpacity on Color {
  Color o(double opacity) => withValues(alpha: opacity);
}
