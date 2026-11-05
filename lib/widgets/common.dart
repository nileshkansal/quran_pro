import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/assets.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import 'buttons.dart';

/// Page with the lantern/leaf header art and the misty mosque footer —
/// the backdrop used by splash, onboarding and auth screens.
class DecoratedPage extends StatelessWidget {
  const DecoratedPage({
    super.key,
    required this.child,
    this.showHeader = true,
    this.showFooter = true,
    this.headerHeight = 287,
    this.footerHeight = 174,
    this.scrollable = false,
    this.footerOpacity = 1,
  });

  final Widget child;
  final bool showHeader;
  final bool showFooter;
  final double headerHeight;
  final double footerHeight;
  final bool scrollable;
  final double footerOpacity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (showHeader)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: headerHeight,
              child: Image.asset(AppImages.bgHeader, fit: BoxFit.cover, alignment: Alignment.topCenter),
            ),
          if (showFooter)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: footerHeight,
              child: Opacity(
                opacity: footerOpacity,
                child: Image.asset(AppImages.bgFooter, fit: BoxFit.cover, alignment: Alignment.bottomCenter),
              ),
            ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}

/// Centered top bar: back arrow, green bold title, optional action.
class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key, required this.title, this.onBack, this.trailing, this.showBack = true, this.titleColor = AppColors.green800});

  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;
  final bool showBack;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: showBack
                ? IconButton(
                    onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                  )
                : null,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.title.copyWith(color: titleColor),
            ),
          ),
          SizedBox(width: 56, child: trailing),
        ],
      ),
    );
  }
}

/// Left-aligned brand bar used on Home ("QuranPro" + bell).
class BrandBar extends StatelessWidget {
  const BrandBar({super.key, this.title = 'QuranPro', this.trailing});
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 12, 8),
      child: Row(
        children: [
          Expanded(child: Text(title, style: AppText.title)),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class QuranProLogo extends StatelessWidget {
  const QuranProLogo({super.key, this.width = 153, this.iconOnly = false});
  final double width;
  final bool iconOnly;

  @override
  Widget build(BuildContext context) {
    return Image.asset(iconOnly ? AppIcons.logoIcon : AppIcons.logoFull, width: width, fit: BoxFit.contain);
  }
}

/// Thin gold line with a star in the middle.
class OrnamentDivider extends StatelessWidget {
  const OrnamentDivider({super.key, this.width = 153});
  final double width;

  @override
  Widget build(BuildContext context) => Image.asset(AppIcons.divider, width: width);
}

/// Wide divider: line – ★ – line (used on login / profile).
class StarDivider extends StatelessWidget {
  const StarDivider({super.key, this.color = AppColors.goldSoft});
  final Color color;

  @override
  Widget build(BuildContext context) {
    final line = Expanded(child: Container(height: 1, color: color.withValues(alpha: 0.6)));
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.star_rounded, size: 16, color: color),
        ),
        line,
      ],
    );
  }
}

class PageDots extends StatelessWidget {
  const PageDots({super.key, required this.count, required this.index, this.activeColor = AppColors.black});
  final int count;
  final int index;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 6,
          height: 6,
          decoration: BoxDecoration(shape: BoxShape.circle, color: active ? activeColor : AppColors.outline),
        );
      }),
    );
  }
}

/// iOS-style green toggle used in Settings / Goals / Audio.
class AppToggle extends StatelessWidget {
  const AppToggle({super.key, required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 46,
        height: 28,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: value ? AppColors.green700 : AppColors.surfaceDim,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: value ? AppColors.green700 : AppColors.outline),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 3, offset: Offset(0, 1))],
            ),
          ),
        ),
      ),
    );
  }
}

/// Radio indicator (filled ring when selected).
class RadioDot extends StatelessWidget {
  const RadioDot({super.key, required this.selected, this.color = AppColors.green700, this.size = 20});
  final bool selected;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: selected ? color : AppColors.textSecondary, width: 2),
      ),
      padding: const EdgeInsets.all(3),
      child: selected
          ? DecoratedBox(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            )
          : null,
    );
  }
}

/// Generic white rounded card with soft shadow.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color = Colors.white,
    this.radius = 16,
    this.border,
    this.onTap,
    this.shadow = true,
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double radius;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final bool shadow;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      decoration: BoxDecoration(
        color: gradient == null ? color : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
        border: border,
        boxShadow: shadow ? const [BoxShadow(color: Color(0x0F000000), blurRadius: 16, offset: Offset(0, 4))] : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
    return box;
  }
}

/// Circle background with an icon (used for list leading icons).
class IconBubble extends StatelessWidget {
  const IconBubble({
    super.key,
    required this.icon,
    this.size = 40,
    this.color = AppColors.green700,
    this.background = AppColors.surfaceAlt,
    this.iconSize,
  });
  final IconData icon;
  final double size;
  final Color color;
  final Color background;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(icon, color: color, size: iconSize ?? size * 0.5),
    );
  }
}

/// Text field styled like the Figma inputs (rounded, light border, leading icon).
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.icon,
    this.obscure = false,
    this.suffix,
    this.keyboardType,
    this.onChanged,
    this.filled = false,
    this.maxLines = 1,
    this.maxLength,
    this.height,
  });

  final TextEditingController? controller;
  final String? hint;
  final IconData? icon;
  final bool obscure;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool filled;
  final int maxLines;
  final int? maxLength;
  final double? height;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: c, width: 1.3),
    );
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLines: maxLines,
      maxLength: maxLength,
      style: const TextStyle(fontSize: 15, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w400),
        prefixIcon: icon == null ? null : Icon(icon, color: AppColors.textSecondary, size: 22),
        suffixIcon: suffix,
        filled: true,
        fillColor: filled ? AppColors.surfaceAlt : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        enabledBorder: border(AppColors.divider),
        focusedBorder: border(AppColors.goldSoft),
        border: border(AppColors.divider),
      ),
    );
  }
}

/// Label above a field in uppercase (e.g. "FULL NAME").
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 4),
    child: Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.6, color: AppColors.textSecondary),
    ),
  );
}

/// Circular progress ring painted manually (stable across Flutter versions).
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 92,
    this.stroke = 8,
    this.color = AppColors.gold,
    this.track = AppColors.surfaceDim,
    this.child,
  });
  final double progress;
  final double size;
  final double stroke;
  final Color color;
  final Color track;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: progress.clamp(0, 1)),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        builder: (context, v, _) => CustomPaint(
          painter: _RingPainter(v, stroke, color, track),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.progress, this.stroke, this.color, this.track);
  final double progress;
  final double stroke;
  final Color color;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final r = rect.deflate(stroke / 2);
    final base = Paint()
      ..color = track
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawArc(r, 0, math.pi * 2, false, base);
    final fg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;
    canvas.drawArc(r, -math.pi / 2, math.pi * 2 * progress, false, fg);
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) => old.progress != progress || old.color != color;
}

/// Rounded horizontal progress bar.
class LinearBar extends StatelessWidget {
  const LinearBar({
    super.key,
    required this.value,
    this.height = 6,
    this.color = AppColors.gold,
    this.track = AppColors.surfaceDim,
    this.gradient,
  });
  final double value;
  final double height;
  final Color color;
  final Color track;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned.fill(child: ColoredBox(color: track)),
            FractionallySizedBox(
              widthFactor: value.clamp(0, 1),
              child: Container(
                decoration: BoxDecoration(color: gradient == null ? color : null, gradient: gradient),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The 8-point "verse number" badge.
class VerseBadge extends StatelessWidget {
  const VerseBadge(this.number, {super.key, this.size = 32, this.color = AppColors.textPrimary});
  final int number;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(AppIcons.verseBadge, width: size, height: size, color: color),
          Text(
            '$number',
            style: TextStyle(fontSize: size * 0.4, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}

/// Small pill chip.
class Pill extends StatelessWidget {
  const Pill(this.text, {super.key, this.color = AppColors.green700, this.background = AppColors.greenTint, this.icon, this.fontSize = 11});
  final String text;
  final Color color;
  final Color background;
  final IconData? icon;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: fontSize + 2, color: color), const SizedBox(width: 4)],
          Text(
            text,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}

/// Bottom "Read. Understand. Live the Quran." footer with dots and Next (onboarding).
class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({super.key, required this.index, required this.count, required this.onNext, this.dark = false});
  final int index;
  final int count;
  final VoidCallback onNext;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.menu_book_outlined, size: 22, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        const Expanded(
          child: Text('Read. Understand.\nLive the Quran.', style: TextStyle(fontSize: 11, height: 1.45, color: AppColors.textSecondary)),
        ),
        PageDots(count: count, index: index),
        const SizedBox(width: 24),
        SizedBox(
          width: 96,
          child: dark
              ? SizedBox(
                  height: 44,
                  child: Material(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: onNext,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                )
              : GoldButton(label: 'Next', icon: Icons.arrow_forward, onPressed: onNext, height: 44, fontSize: 13, radius: 10),
        ),
      ],
    );
  }
}

void showComingSoon(BuildContext context, String feature) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text('$feature – coming soon')));
}
