import 'package:flutter/widgets.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

/// Builds a [TextStyle] from Figma values: line height in px ([lh]) and
/// letter spacing in px ([ls]) or Figma percent ([lsPct]).
///
/// Use a named style from [AppTextStyles] whenever one fits; call [ts] only
/// for one-off Figma styles.
TextStyle ts(
  String family,
  double size,
  FontWeight weight,
  Color color, {
  double? lh,
  double? ls,
  double? lsPct,
  FontStyle? style,
  TextDecoration? decoration,
}) {
  return TextStyle(
    fontFamily: family,
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: lh == null ? null : lh / size,
    // Always explicit so nothing is inherited from the Material theme.
    letterSpacing: ls ?? (lsPct == null ? 0 : size * lsPct / 100),
    fontStyle: style,
    decoration: decoration,
    leadingDistribution: TextLeadingDistribution.even,
    // Latin UI fonts have no Arabic glyphs: Arabic words inside them
    // (e.g. reciter names) fall back to Amiri instead of a system font.
    fontFamilyFallback: const [AppFonts.amiri],
  );
}

/// The app's type scale (the styles that repeat across Figma frames).
///
/// Each style has a default colour. Override it with `.c(color)`:
/// `AppTextStyles.title.c(AppColors.textPrimary)`.
abstract final class AppTextStyles {
  // ── Inter ────────────────────────────────────────────────────────────────
  /// 20 / 28 Bold, −0.2: page and section titles.
  static final title = ts(AppFonts.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.2);

  /// 20 / 28 Bold, −0.5: legal page titles.
  static final titleTight = ts(AppFonts.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.5);

  /// 18 / 26 Bold: card headings.
  static final heading = ts(AppFonts.inter, 18, w700, AppColors.textPrimary, lh: 26);

  /// 18 / 28 Regular: large intro paragraphs.
  static final lead = ts(AppFonts.inter, 18, w400, AppColors.textSecondary, lh: 28);

  /// 16 / 24 Regular.
  static final body = ts(AppFonts.inter, 16, w400, AppColors.textSecondary, lh: 24);

  /// 16 / 24 Medium: list rows, field values.
  static final bodyMedium = ts(AppFonts.inter, 16, w500, AppColors.textPrimary, lh: 24);

  /// 16 / 24 SemiBold.
  static final bodySemibold = ts(AppFonts.inter, 16, w600, AppColors.textPrimary, lh: 24);

  /// 16 / 28 Medium, −0.2: primary button label.
  static final button = ts(AppFonts.inter, 16, w500, AppColors.white, lh: 28, ls: -0.2);

  /// 16 / 24 SemiBold, +0.4: dialog button label.
  static final buttonWide = ts(AppFonts.inter, 16, w600, AppColors.white, lh: 24, ls: 0.4);

  /// 14 / 20 Regular.
  static final bodySmall = ts(AppFonts.inter, 14, w400, AppColors.textSecondary, lh: 20);

  /// 14 / 24 SemiBold.
  static final bodySmallSemibold = ts(AppFonts.inter, 14, w600, AppColors.textPrimary, lh: 24);

  /// 12 / 16 Medium, +0.6: field labels, captions, small buttons.
  static final label = ts(AppFonts.inter, 12, w500, AppColors.textSecondary, lh: 16, ls: 0.6);

  /// 12 / 16 Regular, +0.6.
  static final labelRegular = ts(AppFonts.inter, 12, w400, AppColors.textSecondary, lh: 16, ls: 0.6);

  /// 12 / 16 Medium.
  static final caption = ts(AppFonts.inter, 12, w500, AppColors.textSecondary, lh: 16);

  /// 12 / 16 SemiBold.
  static final captionSemibold = ts(AppFonts.inter, 12, w600, AppColors.textPrimary, lh: 16);

  /// 12 / 24 SemiBold.
  static final captionTall = ts(AppFonts.inter, 12, w600, AppColors.textPrimary, lh: 24);

  // ── Plus Jakarta Sans (Audio & Recitation, My Goals) ─────────────────────
  static final jakartaTitle = ts(AppFonts.jakarta, 14, w700, AppColors.textPrimary, lh: 20);
  static final jakartaBody = ts(AppFonts.jakarta, 14, w500, AppColors.stone800, lh: 20);
  static final jakartaCaption = ts(AppFonts.jakarta, 12, w400, AppColors.textSecondary, lh: 16);
  static final jakartaCaptionMedium = ts(AppFonts.jakarta, 12, w500, AppColors.textSecondary, lh: 16);
  static final jakartaCaptionSemibold = ts(AppFonts.jakarta, 12, w600, AppColors.green600, lh: 16);
  static final jakartaCaptionBold = ts(AppFonts.jakarta, 12, w700, AppColors.textPrimary, lh: 16);
  static final jakartaSmall = ts(AppFonts.jakarta, 11, w400, AppColors.textMuted, lh: 16.5);
}

/// `style.c(color)` — the same text style in another colour.
extension TextStyleColor on TextStyle {
  TextStyle c(Color color) => copyWith(color: color);
}
