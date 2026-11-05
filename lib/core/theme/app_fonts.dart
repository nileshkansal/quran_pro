import 'package:flutter/widgets.dart';

/// Font families bundled in `assets/fonts` (declared in pubspec.yaml).
///
/// Substitutions for Figma fonts that cannot be bundled:
/// Satoshi → [inter], Noto Serif / Liberation Serif → [amiri],
/// Playfair Display italic → [cormorant] italic.
abstract final class AppFonts {
  /// Primary UI font.
  static const String inter = 'Inter';
  static const String poppins = 'Poppins';
  static const String jakarta = 'PlusJakartaSans';
  static const String montserrat = 'Montserrat';
  static const String nunito = 'Nunito';

  /// Arabic / Quran text (Uthmani).
  static const String amiri = 'Amiri';
  static const String amiriQuran = 'AmiriQuran';

  /// Arabic / Quran text (Indo-Pak script).
  static const String scheherazade = 'ScheherazadeNew';

  /// Decorative serif and display fonts.
  static const String cormorant = 'CormorantGaramond';
  static const String cinzel = 'Cinzel';
  static const String hachi = 'HachiMaruPop';
}

/// Font-weight shorthands matching Figma's numeric weights.
const FontWeight w400 = FontWeight.w400;
const FontWeight w500 = FontWeight.w500;
const FontWeight w600 = FontWeight.w600;
const FontWeight w700 = FontWeight.w700;
const FontWeight w800 = FontWeight.w800;
