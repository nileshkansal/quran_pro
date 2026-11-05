import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Primary gold gradient CTA used across the design ("Bismillah", "Next", ...).
class GoldButton extends StatelessWidget {
  const GoldButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.leadingIcon,
    this.height = 54,
    this.radius = 12,
    this.fontSize = 16,
    this.expand = true,
    this.trailingCircle = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? leadingIcon;
  final double height;
  final double radius;
  final double fontSize;
  final bool expand;

  /// Renders the arrow inside a black circle on the right (Reading Settings "Next").
  final bool trailingCircle;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[Icon(leadingIcon, color: Colors.white, size: fontSize + 2), const SizedBox(width: 8)],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        if (icon != null && !trailingCircle) ...[const SizedBox(width: 6), Icon(icon, color: Colors.white, size: fontSize + 2)],
      ],
    );
    return Opacity(
      opacity: onPressed == null ? 0.55 : 1,
      child: Container(
        height: height,
        width: expand ? double.infinity : null,
        decoration: BoxDecoration(
          gradient: AppColors.goldGradient,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [BoxShadow(color: AppColors.goldDark.withValues(alpha: 0.25), blurRadius: 14, offset: const Offset(0, 6))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(radius),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: trailingCircle
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        content,
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(color: AppColors.black, shape: BoxShape.circle),
                            child: Icon(icon ?? Icons.arrow_forward, size: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  : content,
            ),
          ),
        ),
      ),
    );
  }
}

/// White button with a dark/gold outline ("I already have an account", "Cancel").
class OutlineAppButton extends StatelessWidget {
  const OutlineAppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.leadingIcon,
    this.height = 54,
    this.radius = 12,
    this.borderColor = AppColors.textPrimary,
    this.textColor = AppColors.textPrimary,
    this.fontSize = 16,
    this.background = Colors.white,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? leadingIcon;
  final double height;
  final double radius;
  final Color borderColor;
  final Color textColor;
  final double fontSize;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: borderColor, width: 1.5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[Icon(leadingIcon, color: textColor, size: fontSize + 4), const SizedBox(width: 10)],
              Text(
                label,
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500, color: textColor),
              ),
              if (icon != null) ...[const SizedBox(width: 8), Icon(icon, color: textColor, size: fontSize + 4)],
            ],
          ),
        ),
      ),
    );
  }
}

/// Solid dark green button (e.g. "Continue Reading", "Recite Now").
class GreenButton extends StatelessWidget {
  const GreenButton({super.key, required this.label, required this.onPressed, this.leadingIcon, this.height = 46, this.fontSize = 14});

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Material(
        color: AppColors.green700,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null) ...[Icon(leadingIcon, size: fontSize + 4, color: Colors.white), const SizedBox(width: 6)],
                Text(
                  label,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: fontSize),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Small rounded "Google"/"Apple" social login button.
class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.label, required this.leading, required this.onPressed});

  final String label;
  final Widget leading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.divider),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leading,
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.green700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
