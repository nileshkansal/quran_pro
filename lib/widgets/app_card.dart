import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../core/theme/theme.dart';
import 'app_icon.dart';

/// Reusable box decorations.
abstract final class AppDecorations {
  /// White card with the soft 0 4 20 shadow (Help, Legal, Feedback).
  static BoxDecoration card({double radius = AppRadius.r20, Color? border, Color color = AppColors.white}) => BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: border == null ? null : Border.all(color: border),
        boxShadow: AppShadows.soft,
      );

  /// Flat white card with a hairline border (Quran lists, My Goals).
  static BoxDecoration outlined({double radius = AppRadius.r16, Color border = AppColors.surfaceDim, Color color = AppColors.white}) =>
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(radius), border: Border.all(color: border));
}

/// White content card ([AppDecorations.card]) with padding.
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.padding = AppInsets.all24, this.radius = AppRadius.r20, this.border, this.onTap});
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? border;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(padding: padding, decoration: AppDecorations.card(radius: radius, border: border), child: child);
    return onTap == null ? card : GestureDetector(onTap: onTap, child: card);
  }
}

/// Frosted card: white @70 %, 1px white @50 % border, backdrop blur
/// (Profile and Settings sections).
class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.child, this.height, this.radius = AppRadius.r20, this.blur = 5});
  final Widget child;
  final double? height;
  final double radius;
  final double blur;

  @override
  Widget build(BuildContext context) {
    final br = BorderRadius.circular(radius);
    final card = Container(
      height: height,
      decoration: BoxDecoration(color: AppColors.white.o(.7), border: Border.all(color: AppColors.white.o(.5)), borderRadius: br),
      child: Material(type: MaterialType.transparency, child: child),
    );
    return ClipRRect(
      borderRadius: br,
      child: blur > 0 ? BackdropFilter(filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur), child: card) : card,
    );
  }
}

/// 56–57px card header: 32px icon tile + Inter Bold 20 title, bottom rule.
class CardHeader extends StatelessWidget {
  const CardHeader({super.key, required this.icon, required this.title, this.background, this.showDivider = true, this.onTap});
  final String icon;
  final String title;
  final Color? background;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final header = Container(
      height: showDivider ? 57 : 56,
      padding: AppInsets.h16,
      decoration: BoxDecoration(
        color: background ?? AppColors.white.o(.5),
        border: showDivider ? const Border(bottom: BorderSide(color: AppColors.divider)) : null,
      ),
      child: Row(children: [
        AppIcon.square(icon, 32),
        AppGap.h12,
        Expanded(child: Text(title, style: AppTextStyles.title)),
      ]),
    );
    return onTap == null ? header : InkWell(onTap: onTap, child: header);
  }
}

/// Settings-style row: 20px icon, label, chevron (40 high).
class AppListRow extends StatelessWidget {
  const AppListRow({super.key, required this.icon, required this.label, required this.onTap, this.iconW = 20, this.iconH = 20, this.height = 40});
  final String icon;
  final String label;
  final VoidCallback onTap;
  final double iconW;
  final double iconH;
  final double height;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: AppRadius.br8,
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: AppInsets.all8,
            child: Row(children: [
              SizedBox(width: 20, child: Center(child: AppIcon(icon, w: iconW, h: iconH))),
              AppGap.h16,
              Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
              const AppChevron(),
            ]),
          ),
        ),
      );
}

/// The design's right chevron (7.4 × 12).
class AppChevron extends StatelessWidget {
  const AppChevron({super.key});
  @override
  Widget build(BuildContext context) => const AppIcon('container_b38512cd', w: 7.4, h: 12);
}
