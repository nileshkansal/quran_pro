import 'package:flutter/material.dart';

/// An icon exported from its Figma vector node (`assets/icons/fig/<name>.png`,
/// rendered @3x). Pass the Figma size in [w] × [h]; [color] re-tints it.
class AppIcon extends StatelessWidget {
  const AppIcon(this.name, {super.key, required this.w, required this.h, this.color, this.fit = BoxFit.contain});

  /// Square icon: `AppIcon.square('bell', 24)`.
  const AppIcon.square(this.name, double size, {super.key, this.color, this.fit = BoxFit.contain})
      : w = size,
        h = size;

  final String name;
  final double w;
  final double h;
  final Color? color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => Image.asset(
        'assets/icons/fig/$name.png',
        width: w,
        height: h,
        fit: fit,
        color: color,
        filterQuality: FilterQuality.medium,
      );
}

/// Text painted with a gradient (Figma text filled with the gold gradient).
class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.style, required this.gradient, this.textAlign, this.softWrap = true});
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign? textAlign;

  /// `false` keeps the text on one line even if it is wider than its box.
  final bool softWrap;

  @override
  Widget build(BuildContext context) => ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (r) => gradient.createShader(Offset.zero & r.size),
        child: Text(text, style: style, textAlign: textAlign, softWrap: softWrap, overflow: softWrap ? null : TextOverflow.visible),
      );
}
