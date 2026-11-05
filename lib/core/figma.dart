import 'package:flutter/material.dart';

/// Helpers that let screens be written with the exact numbers from Figma.
///
/// All sizes are logical pixels on the 390-pt design canvas (iPhone 14/15).
/// Line heights are given in px like Figma and converted to Flutter's
/// multiplier; letter spacing accepts px ([ls]) or Figma percent ([lsPct]).
abstract final class Ff {
  static const inter = 'Inter';
  static const poppins = 'Poppins';
  static const jakarta = 'PlusJakartaSans';
  static const montserrat = 'Montserrat';
  static const amiri = 'Amiri';
  static const amiriQuran = 'AmiriQuran';
  static const scheherazade = 'ScheherazadeNew';
  static const cormorant = 'CormorantGaramond';
  static const cinzel = 'Cinzel';
  static const nunito = 'Nunito';
  static const hachi = 'HachiMaruPop';
}

const FontWeight w400 = FontWeight.w400;
const FontWeight w500 = FontWeight.w500;
const FontWeight w600 = FontWeight.w600;
const FontWeight w700 = FontWeight.w700;
const FontWeight w800 = FontWeight.w800;

/// Figma text style: `ts(Ff.inter, 16, w500, color, lh: 24, ls: 0.6)`.
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
    letterSpacing: ls ?? (lsPct == null ? null : size * lsPct / 100),
    fontStyle: style,
    decoration: decoration,
    leadingDistribution: TextLeadingDistribution.even,
  );
}

/// Exported Figma icon (rendered from the vector layers at 3x).
class FigIcon extends StatelessWidget {
  const FigIcon(this.name, {super.key, required this.w, required this.h, this.color, this.fit = BoxFit.contain});
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

/// Text with a gradient fill (Figma text using the gold gradient).
class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.style, required this.gradient, this.textAlign});
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (r) => gradient.createShader(Offset.zero & r.size),
        child: Text(text, style: style, textAlign: textAlign),
      );
}

/// Figma drop shadow → BoxShadow (Figma blur radius = 2 × sigma, same as CSS).
BoxShadow fShadow(Color color, double x, double y, double blur, [double spread = 0]) =>
    BoxShadow(color: color, offset: Offset(x, y), blurRadius: blur, spreadRadius: spread);

/// Figma hex helper with alpha 0..1 (e.g. `fc(0x191C1A, .04)`).
Color fc(int rgb, [double alpha = 1]) => Color((((alpha * 255).round() & 0xff) << 24) | (rgb & 0xffffff));
