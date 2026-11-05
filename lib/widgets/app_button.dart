import 'package:flutter/material.dart';

import '../core/theme/theme.dart';
import 'app_icon.dart';

/// Visual variants of [AppButton].
enum AppButtonVariant {
  /// Gold gradient fill, white text (primary CTA).
  gold,

  /// Transparent with a 1px border (secondary CTA).
  outline,

  /// Near-black fill (onboarding page 1).
  dark,

  /// Brand green fill.
  green,

  /// Error-red fill for destructive actions.
  danger,
}

/// The design's call-to-action button ("Bismillah", "Submit", "Save Changes").
///
/// Defaults: 56 high, full width, radius 10, gold gradient, Poppins 15 label.
/// Every Figma variation is a parameter, so screens never rebuild a button.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.variant = AppButtonVariant.gold,
    this.width,
    this.height = AppSizes.buttonHeight,
    this.radius = AppSizes.buttonRadius,
    this.textStyle,
    this.leading,
    this.trailing,
    this.gap = AppSpacing.sm,
    this.shadow,
    this.borderColor,
    this.loading = false,
  });

  /// Fully rounded (stadium) button, e.g. the Delete Account dialog actions.
  const AppButton.pill({
    super.key,
    required this.label,
    required this.onTap,
    this.variant = AppButtonVariant.gold,
    this.width,
    this.height = AppSizes.buttonHeight,
    this.textStyle,
    this.leading,
    this.trailing,
    this.gap = AppSpacing.sm,
    this.shadow,
    this.borderColor,
    this.loading = false,
  }) : radius = AppRadius.full;

  final String label;

  /// `null` disables the button (rendered at 50 % opacity).
  final VoidCallback? onTap;
  final AppButtonVariant variant;
  final double? width;
  final double height;
  final double radius;
  final TextStyle? textStyle;
  final Widget? leading;
  final Widget? trailing;
  final double gap;
  final List<BoxShadow>? shadow;
  final Color? borderColor;

  /// Shows a spinner instead of the label and ignores taps.
  final bool loading;


  /// White right arrow (16px) used on gold buttons.
  static const Widget arrowWhite = AppIcon('container_166d96fa', w: 16, h: 16);

  /// Dark right arrow (16px) used on outline buttons.
  static const Widget arrowDark = AppIcon('container_bec0d661', w: 16, h: 16);

  @override
  Widget build(BuildContext context) {
    final outline = variant == AppButtonVariant.outline;
    final fg = outline ? AppColors.black : AppColors.white;
    final txt = textStyle ?? ts(AppFonts.poppins, 15, w500, fg, lh: 28, ls: -0.2);
    final br = BorderRadius.circular(radius);
    final enabled = onTap != null && !loading;
    return Opacity(
      opacity: onTap == null ? 0.5 : 1,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: variant == AppButtonVariant.gold ? AppColors.goldGradient : null,
          color: switch (variant) {
            AppButtonVariant.gold => null,
            AppButtonVariant.outline => AppColors.transparent,
            AppButtonVariant.dark => AppColors.black,
            AppButtonVariant.green => AppColors.green700,
            AppButtonVariant.danger => AppColors.error,
          },
          border: outline
              ? Border.all(color: borderColor ?? AppColors.black)
              : (borderColor != null ? Border.all(color: borderColor!) : null),
          borderRadius: br,
          boxShadow: shadow,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: br,
            onTap: enabled ? onTap : null,
            child: Center(
              child: loading
                  ? SizedBox.square(dimension: 22, child: CircularProgressIndicator(strokeWidth: 2.4, color: txt.color))
                  : Row(mainAxisSize: MainAxisSize.min, children: [
                      if (leading != null) ...[leading!, SizedBox(width: gap)],
                      Flexible(child: Text(label, textAlign: TextAlign.center, style: txt, overflow: TextOverflow.ellipsis)),
                      if (trailing != null) ...[SizedBox(width: gap), trailing!],
                    ]),
            ),
          ),
        ),
      ),
    );
  }
}

/// Round icon button (white disc with a hairline border), e.g. My Goals header.
class AppCircleIconButton extends StatelessWidget {
  const AppCircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 40,
    this.background = AppColors.white,
    this.borderColor = AppColors.stone200,
  });
  final Widget icon;
  final VoidCallback onTap;
  final double size;
  final Color background;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) => Material(
        color: background,
        shape: CircleBorder(side: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!)),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox.square(dimension: size, child: Center(child: icon)),
        ),
      );
}

/// Tappable text (e.g. "Forget Password?", "Register", "Recalculate target").
class AppTextLink extends StatelessWidget {
  const AppTextLink(this.text, {super.key, required this.onTap, required this.style, this.trailing});
  final String text;
  final VoidCallback onTap;
  final TextStyle style;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(mainAxisSize: MainAxisSize.min, children: [Text(text, style: style), ?trailing]),
      );
}

/// Google / Apple sign-in buttons (two 48-high outlined buttons, r12).
class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key, required this.onGoogle, required this.onApple, this.labelColor = AppColors.green82});
  final VoidCallback onGoogle;
  final VoidCallback onApple;
  final Color labelColor;

  Widget _btn(String icon, double iw, String label, VoidCallback onTap) => Expanded(
        child: Material(
          color: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.br12, side: BorderSide(color: AppColors.outline.o(.5))),
          child: InkWell(
            borderRadius: AppRadius.br12,
            onTap: onTap,
            child: SizedBox(
              height: 48,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                AppIcon.square(icon, iw),
                AppGap.h10,
                Text(label, style: AppTextStyles.label.copyWith(fontWeight: w600, color: labelColor)),
              ]),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Row(children: [
        _btn('akar_icons_google_fill_f3ff3ac3', 24, 'Google', onGoogle),
        AppGap.h16,
        _btn('ant_design_apple_filled_5d1e4d04', 16, 'Apple', onApple),
      ]);
}
