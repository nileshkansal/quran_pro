import 'package:flutter/material.dart';

import '../core/assets.dart';
import '../core/theme/theme.dart';
import 'app_icon.dart';

/// Lantern + leaves header and misty mosque footer (splash, onboarding, auth).
class LanternBackdrop extends StatelessWidget {
  const LanternBackdrop({super.key, this.header = true, this.footer = true, this.footerTop});
  final bool header;
  final bool footer;

  /// Figma top of the footer art; `null` pins it to the bottom edge.
  final double? footerTop;

  @override
  Widget build(BuildContext context) => Stack(children: [
        if (header)
          Positioned(
            top: 0,
            left: -1,
            right: -1,
            height: 287,
            child: Image.asset(AppImages.bgHeader, fit: BoxFit.cover, alignment: Alignment.topCenter),
          ),
        if (footer)
          Positioned(
            bottom: footerTop == null ? 0 : null,
            top: footerTop,
            left: 0,
            right: 0,
            height: 174,
            child: Image.asset(AppImages.bgFooter, fit: BoxFit.cover),
          ),
      ]);
}

/// Figma "Decorative Divider": gold line · ✳ · gold line at 60 % opacity.
/// Lines shrink if the space is narrower than [lineWidth].
class DecorDivider extends StatelessWidget {
  const DecorDivider({super.key, this.lineWidth = 61});
  final double lineWidth;

  @override
  Widget build(BuildContext context) {
    Widget line() => Flexible(child: Container(width: lineWidth, height: 1, color: AppColors.goldSoft));
    return Opacity(
      opacity: 0.6,
      child: SizedBox(
        height: 10.5,
        child: Row(mainAxisSize: MainAxisSize.min, children: [line(), const AppIcon('margin_091f4689', w: 26.1, h: 10.5), line()]),
      ),
    );
  }
}

/// Full-width line · ornament · line (auth and profile headers).
class OrnamentDivider extends StatelessWidget {
  const OrnamentDivider({super.key, required this.icon, this.iconW = 40, this.iconH = 16, this.lineColor});
  final String icon;
  final double iconW;
  final double iconH;

  /// Defaults to muted gold at 30 %.
  final Color? lineColor;

  @override
  Widget build(BuildContext context) {
    final line = Expanded(child: Container(height: 1, color: lineColor ?? AppColors.goldMuted.o(.3)));
    return Row(children: [line, AppIcon(icon, w: iconW, h: iconH), line]);
  }
}

/// Figma "Line 1": a 1px line fading gold → deeper gold → gold.
class GoldFadeLine extends StatelessWidget {
  const GoldFadeLine({super.key, this.width = 202});
  final double width;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: 1,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.gold20, AppColors.gold37, AppColors.gold20])),
      );
}

/// "or continue with" divider.
class OrDivider extends StatelessWidget {
  const OrDivider({super.key, this.text = 'or continue with'});
  final String text;

  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 48, height: 1, color: AppColors.outline),
        Padding(padding: AppInsets.h12, child: Text(text, style: AppTextStyles.label.c(AppColors.textMuted))),
        Container(width: 48, height: 1, color: AppColors.outline),
      ]);
}

/// The QuranPro logo lockups exported from Figma.
class Logo extends StatelessWidget {
  const Logo.lockup({super.key, this.width = 163.5}) : asset = AppIcons.logoLockup;
  const Logo.splash({super.key, this.width = 153}) : asset = AppIcons.logoFull;
  const Logo.small({super.key, this.width = 103.6}) : asset = AppIcons.logoSmall;
  const Logo.icon({super.key, this.width = 119.8}) : asset = AppIcons.logoIcon;
  const Logo.wordmark({super.key, this.width = 163.5}) : asset = AppIcons.wordmark;
  final String asset;
  final double width;

  @override
  Widget build(BuildContext context) => Image.asset(asset, width: width, fit: BoxFit.contain, filterQuality: FilterQuality.medium);
}

/// Page indicator dots (6.1px, 4.4 gap).
class PagerDots extends StatelessWidget {
  const PagerDots({super.key, required this.count, required this.index, this.active = AppColors.green80, this.inactive = AppColors.grey15});
  final int count;
  final int index;
  final Color active;
  final Color inactive;

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) const SizedBox(width: 4.4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 6.1,
            height: 6.1,
            decoration: BoxDecoration(shape: BoxShape.circle, color: i == index ? active : inactive),
          ),
        ],
      ]);
}

/// Circular progress ring with a gold gradient arc (daily target, journey).
class GoldRing extends StatelessWidget {
  const GoldRing({
    super.key,
    required this.progress,
    required this.size,
    required this.trackWidth,
    required this.arcWidth,
    this.trackColor = AppColors.grey09,
    this.inset = 0,
    this.child,
  });
  final double progress;
  final double size;
  final double trackWidth;
  final double arcWidth;
  final Color trackColor;
  final double inset;
  final Widget? child;

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: size,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: progress.clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (_, v, _) => CustomPaint(
            painter: _GoldRingPainter(v, trackWidth, arcWidth, trackColor, inset),
            child: Center(child: child),
          ),
        ),
      );
}

class _GoldRingPainter extends CustomPainter {
  _GoldRingPainter(this.p, this.tw, this.aw, this.track, this.inset);
  final double p, tw, aw, inset;
  final Color track;

  static const _start = -1.5707963;
  static const _full = 6.283185307;

  @override
  void paint(Canvas canvas, Size size) {
    final r = (Offset.zero & size).deflate(inset + (aw > tw ? aw : tw) / 2);
    canvas.drawArc(r, 0, _full, false, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = tw
      ..color = track);
    if (p <= 0) return;
    canvas.drawArc(
      r,
      _start,
      _full * p,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = aw
        ..strokeCap = StrokeCap.round
        ..shader = const SweepGradient(
          startAngle: _start,
          endAngle: 4.712389,
          colors: [AppColors.goldLight, AppColors.gold, AppColors.goldDark],
          transform: GradientRotation(_start),
        ).createShader(r),
    );
  }

  @override
  bool shouldRepaint(covariant _GoldRingPainter o) => o.p != p;
}
