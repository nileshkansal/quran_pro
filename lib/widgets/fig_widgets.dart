import 'package:flutter/material.dart';

import '../core/assets.dart';
import '../core/figma.dart';
import '../core/theme/app_colors.dart';

/// Lays children out at their exact Figma coordinates on the 390×[designHeight]
/// canvas. On taller screens the canvas grows (bottom-anchored children follow
/// the bottom edge); on shorter screens the page scrolls, so nothing clips.
class FigCanvas extends StatelessWidget {
  const FigCanvas({
    super.key,
    required this.children,
    this.designHeight = 844,
    this.background,
    this.decoration,
    this.bottomInset = true,
  });

  final List<Widget> children;
  final double designHeight;
  final Color? background;
  final Decoration? decoration;
  final bool bottomInset;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      color: decoration == null ? (background ?? AppColors.white) : null,
      decoration: decoration,
      child: LayoutBuilder(
        builder: (context, c) {
          final h = c.maxHeight.isFinite ? c.maxHeight : designHeight;
          final canvasH = h < designHeight ? designHeight : h;
          return SingleChildScrollView(
            physics: h >= designHeight ? const NeverScrollableScrollPhysics() : const ClampingScrollPhysics(),
            padding: EdgeInsets.only(bottom: bottomInset ? mq.viewInsets.bottom : 0),
            child: SizedBox(
              height: canvasH,
              width: c.maxWidth,
              child: Stack(clipBehavior: Clip.none, children: children),
            ),
          );
        },
      ),
    );
  }
}

/// Places a child horizontally centred on the canvas at Figma [top].
class FigCenter extends StatelessWidget {
  const FigCenter({super.key, required this.top, required this.child});
  final double top;
  final Widget child;

  @override
  Widget build(BuildContext context) => Positioned(
        top: top,
        left: 0,
        right: 0,
        child: Center(child: child),
      );
}

/// Lantern + leaves header and misty mosque footer used by splash/onboarding/auth.
class LanternBackdrop extends StatelessWidget {
  const LanternBackdrop({super.key, this.header = true, this.footer = true, this.footerTop});
  final bool header;
  final bool footer;
  final double? footerTop;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
}

/// Figma "Decorative Divider": 61px gold line · ✳ · 61px gold line at 60% opacity.
class DecorDivider extends StatelessWidget {
  const DecorDivider({super.key, this.lineWidth = 61});
  final double lineWidth;

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: 0.6,
        child: SizedBox(
          height: 10.5,
          child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(width: lineWidth, height: 1, color: AppColors.goldSoft),
            const FigIcon('margin_091f4689', w: 26.1, h: 10.5),
            Container(width: lineWidth, height: 1, color: AppColors.goldSoft),
          ]),
        ),
      );
}

/// Figma "Line 1": 202px line with #e3d0b5 → #d0aa6f → #e3d0b5 gradient.
class GoldFadeLine extends StatelessWidget {
  const GoldFadeLine({super.key, this.width = 202});
  final double width;
  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFE3D0B5), Color(0xFFD0AA6F), Color(0xFFE3D0B5)]),
        ),
      );
}

enum FigButtonStyle { gold, outline, dark, green }

/// The design's 56px CTA ("Bismillah", "Let’s get started", "Submit"…).
class FigButton extends StatelessWidget {
  const FigButton({
    super.key,
    required this.label,
    required this.onTap,
    this.style = FigButtonStyle.gold,
    this.width,
    this.height = 56,
    this.radius = 10,
    this.textStyle,
    this.trailing,
    this.leading,
    this.gap = 8,
    this.shadow,
    this.borderColor,
  });

  final String label;
  final VoidCallback? onTap;
  final FigButtonStyle style;
  final double? width;
  final double height;
  final double radius;
  final TextStyle? textStyle;
  final Widget? trailing;
  final Widget? leading;
  final double gap;
  final List<BoxShadow>? shadow;
  final Color? borderColor;

  /// White right-arrow (16px) used on gold buttons.
  static const Widget arrowWhite = FigIcon('container_166d96fa', w: 16, h: 16);

  /// Black right-arrow (16px) used on outline buttons.
  static const Widget arrowDark = FigIcon('container_bec0d661', w: 16, h: 16);

  @override
  Widget build(BuildContext context) {
    final isGold = style == FigButtonStyle.gold;
    final fg = style == FigButtonStyle.outline ? AppColors.black : Colors.white;
    final txt = textStyle ?? ts(Ff.poppins, 15, w500, fg, lh: 28, ls: -0.2);
    return Opacity(
      opacity: onTap == null ? 0.5 : 1,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: isGold ? AppColors.goldGradient : null,
          color: switch (style) {
            FigButtonStyle.gold => null,
            FigButtonStyle.outline => Colors.transparent,
            FigButtonStyle.dark => AppColors.black,
            FigButtonStyle.green => AppColors.green700,
          },
          border: style == FigButtonStyle.outline
              ? Border.all(color: borderColor ?? AppColors.black, width: 1)
              : (borderColor != null ? Border.all(color: borderColor!) : null),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: shadow,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(radius),
            onTap: onTap,
            child: Center(
              child: Row(mainAxisSize: MainAxisSize.min, children: [
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

/// Small pager dots: 6.1px, 4.4 gap, active #264135 (or black), inactive #d9d9d9.
class FigDots extends StatelessWidget {
  const FigDots({super.key, required this.count, required this.index, this.active = const Color(0xFF264135), this.inactive = const Color(0xFFD9D9D9)});
  final int count;
  final int index;
  final Color active;
  final Color inactive;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < count; i++) ...[
            if (i > 0) const SizedBox(width: 4.4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 6.1,
              height: 6.1,
              decoration: BoxDecoration(shape: BoxShape.circle, color: i == index ? active : inactive),
            ),
          ],
        ],
      );
}

/// Onboarding bottom bar: book icon + "Read. Understand. Live the Quran.", dots, Next.
class OnbBar extends StatelessWidget {
  const OnbBar({super.key, required this.index, required this.onNext, this.firstPage = false});
  final int index;
  final VoidCallback onNext;

  /// Page 1 uses a black Next button, white inactive dots and dark text.
  final bool firstPage;

  @override
  Widget build(BuildContext context) {
    final textColor = firstPage ? AppColors.black : const Color(0xFF264135);
    return SizedBox(
      width: 358,
      height: 41.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 119.1,
            child: Row(children: [
              FigIcon(firstPage ? 'famicons_book_outline_4baf5e02' : 'famicons_book_outline_d97af45d', w: 20.4, h: 20.4),
              const SizedBox(width: 7.7),
              Expanded(
                child: Text('Read. Understand.\nLive the Quran.', style: ts(Ff.inter, 10.3, w400, textColor, lh: 17.1)),
              ),
            ]),
          ),
          FigDots(
            count: 5,
            index: index,
            active: firstPage ? AppColors.black : const Color(0xFF264135),
            inactive: firstPage ? Colors.white : const Color(0xFFD9D9D9),
          ),
          FigButton(
            label: 'Next',
            onTap: onNext,
            width: 93,
            height: 41.9,
            style: firstPage ? FigButtonStyle.dark : FigButtonStyle.gold,
            textStyle: ts(Ff.inter, 10.1, w500, Colors.white, lh: 13.4, ls: 0.5),
            trailing: const FigIcon('container_765421ed', w: 10.1, h: 10.1),
            gap: 6.7,
            shadow: [
              fShadow(fc(0x000000, .1), 0, 1.7, 3.4, -1.7),
              fShadow(fc(0x000000, .1), 0, 3.4, 5, -0.8),
            ],
          ),
        ],
      ),
    );
  }
}

/// The QuranPro logo lockups exported from Figma.
class Logo extends StatelessWidget {
  const Logo.lockup({super.key, this.width = 163.5}) : asset = 'assets/icons/logo_lockup.png';
  const Logo.splash({super.key, this.width = 153}) : asset = AppIcons.logoFull;
  const Logo.small({super.key, this.width = 103.6}) : asset = 'assets/icons/logo_small.png';
  const Logo.icon({super.key, this.width = 119.8}) : asset = AppIcons.logoIcon;
  const Logo.wordmark({super.key, this.width = 163.5}) : asset = 'assets/icons/wordmark.png';
  final String asset;
  final double width;

  @override
  Widget build(BuildContext context) => Image.asset(asset, width: width, fit: BoxFit.contain, filterQuality: FilterQuality.medium);
}

/// Standard back arrow used in the design headers (24px, #191c1a).
class FigBack extends StatelessWidget {
  const FigBack({super.key, this.onTap, this.color = AppColors.textPrimary, this.size = 24});
  final VoidCallback? onTap;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onTap ?? () => Navigator.of(context).maybePop(),
        icon: Icon(Icons.arrow_back, color: color, size: size),
        splashRadius: 22,
      );
}

/// Figma text input: 58px, radius 10, 1px #bfc9c2 @50% border, white fill,
/// Inter 16/24 text, 48px left padding for the leading icon slot.
class FigInput extends StatelessWidget {
  const FigInput({
    super.key,
    this.controller,
    this.hint,
    this.leading,
    this.leadingWidth = 48,
    this.trailing,
    this.obscure = false,
    this.keyboardType,
    this.onChanged,
    this.height = 58,
    this.radius = 10,
    this.borderColor = const Color(0x80BFC9C2),
    this.fill = Colors.white,
    this.textStyle,
    this.hintStyle,
    this.trailingPad = 16,
  });

  final double trailingPad;
  final TextEditingController? controller;
  final String? hint;
  final Widget? leading;
  final double leadingWidth;
  final Widget? trailing;
  final bool obscure;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final double height;
  final double radius;
  final Color borderColor;
  final Color fill;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor),
      ),
      child: Row(children: [
        SizedBox(width: leadingWidth, child: leading == null ? null : Align(alignment: Alignment.centerLeft, child: leading)),
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            onChanged: onChanged,
            cursorColor: AppColors.green700,
            style: textStyle ?? ts(Ff.inter, 16, w400, AppColors.textPrimary, lh: 24),
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: hint,
              hintStyle: hintStyle ?? ts(Ff.inter, 16, w400, const Color(0xFF9AA19D), lh: 24),
            ),
          ),
        ),
        if (trailing != null) trailing!,
        SizedBox(width: trailingPad),
      ]),
    );
  }
}

/// Circular progress ring with a gold gradient arc (Daily target / recitation).
class GoldRing extends StatelessWidget {
  const GoldRing({
    super.key,
    required this.progress,
    required this.size,
    required this.trackWidth,
    required this.arcWidth,
    this.trackColor = const Color(0xFFE6E9E5),
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
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
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

  @override
  void paint(Canvas canvas, Size size) {
    final r = (Offset.zero & size).deflate(inset + (aw > tw ? aw : tw) / 2);
    canvas.drawArc(r, 0, 6.283185307, false, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = tw
      ..color = track);
    if (p <= 0) return;
    canvas.drawArc(
      r,
      -1.5707963,
      6.283185307 * p,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = aw
        ..strokeCap = StrokeCap.round
        ..shader = const SweepGradient(
          startAngle: -1.5707963,
          endAngle: 4.712389,
          colors: [AppColors.goldLight, AppColors.gold, AppColors.goldDark],
          transform: GradientRotation(-1.5707963),
        ).createShader(r),
    );
  }

  @override
  bool shouldRepaint(covariant _GoldRingPainter o) => o.p != p;
}

/// "or continue with" divider (48px lines #bfc9c2, Inter Medium 12 / ls .6).
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 48, height: 1, color: AppColors.outline),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('or continue with', style: ts(Ff.inter, 12, w500, AppColors.textMuted, lh: 16, ls: 0.6)),
        ),
        Container(width: 48, height: 1, color: AppColors.outline),
      ]);
}

/// Google / Apple social buttons (163×48, r12).
class SocialRow extends StatelessWidget {
  const SocialRow({super.key, required this.onGoogle, required this.onApple, this.labelColor = const Color(0xFF075B45)});
  final VoidCallback onGoogle;
  final VoidCallback onApple;
  final Color labelColor;

  Widget _btn(String icon, double iw, String label, VoidCallback onTap) => Expanded(
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0x80BFC9C2)),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onTap,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FigIcon(icon, w: iw, h: iw),
                const SizedBox(width: 10),
                Text(label, style: ts(Ff.inter, 12, w600, labelColor, lh: 16, ls: 0.6)),
              ]),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Row(children: [
        _btn('akar_icons_google_fill_f3ff3ac3', 24, 'Google', onGoogle),
        const SizedBox(width: 16),
        _btn('ant_design_apple_filled_5d1e4d04', 16, 'Apple', onApple),
      ]);
}

/// Standard sub-page shell used by the Help / Legal / Feedback / About frames:
/// #f8faf6 → white page gradient, 64px translucent header with a back icon and
/// an Inter Bold 20 title (centred or leading, per frame).
class FigSubPage extends StatelessWidget {
  const FigSubPage({
    super.key,
    required this.title,
    required this.children,
    this.backIcon = 'button_3ee2efe6',
    this.backW = 16,
    this.backH = 22,
    this.centerTitle = true,
    this.titleColor = const Color(0xFF003B29),
    this.titleLs = -0.2,
    this.padding = const EdgeInsets.all(24),
  });
  final String title;
  final List<Widget> children;
  final String backIcon;
  final double backW;
  final double backH;
  final bool centerTitle;
  final Color titleColor;
  final double titleLs;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final t = Text(title, style: ts(Ff.inter, 20, w700, titleColor, lh: 28, ls: titleLs));
    final back = GestureDetector(onTap: () => Navigator.maybePop(context), child: FigIcon(backIcon, w: backW, h: backH));
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF8FAF6), Colors.white]),
        ),
        child: Column(children: [
          Container(
            height: 64 + top,
            color: fc(0xF8FAF6, .8),
            padding: EdgeInsets.fromLTRB(24, top, 24, 0),
            child: centerTitle
                ? Stack(alignment: Alignment.center, children: [Align(alignment: Alignment.centerLeft, child: back), t])
                : Row(children: [back, const SizedBox(width: 24), t]),
          ),
          Expanded(child: ListView(padding: padding, children: children)),
        ]),
      ),
    );
  }
}

/// White r20 card with the soft 0,4 b20 shadow used across settings pages.
BoxDecoration figCard({double radius = 20, Color? border}) => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      border: border == null ? null : Border.all(color: border),
      boxShadow: [fShadow(fc(0x000000, .04), 0, 4, 20)],
    );
