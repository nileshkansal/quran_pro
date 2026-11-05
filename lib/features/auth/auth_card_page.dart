import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/figma.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/fig_widgets.dart';

/// Shared Figma layout for Forgot / Verify / Reset / Success:
/// pale gradient page, lantern header art, misty footer, and a white
/// 342-wide card whose top sits at [cardTop] on the 844 canvas.
class AuthCardPage extends StatelessWidget {
  const AuthCardPage({
    super.key,
    required this.child,
    required this.cardTop,
    this.padding = const EdgeInsets.fromLTRB(17, 32, 17, 32),
    this.radius = 20,
    this.showBack = true,
    this.backIcon = 'button_go_back_44ba8c32',
    this.silhouette = false,
  });

  final Widget child;
  final double cardTop;
  final EdgeInsets padding;
  final double radius;
  final bool showBack;
  final String backIcon;
  final bool silhouette;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FigCanvas(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF8FAF6), Colors.white]),
        ),
        children: [
          Positioned(top: 0, left: 0, width: 392, height: 287, child: Image.asset(AppImages.bgHeader, fit: BoxFit.cover)),
          if (silhouette)
            Positioned.fill(child: Opacity(opacity: 0.1, child: Image.asset(AppImages.resetBg, fit: BoxFit.fill))),
          Positioned(bottom: 0, left: 0, right: 0, height: 174, child: Image.asset(AppImages.bgFooter, fit: BoxFit.cover)),
          if (showBack)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 24,
              child: GestureDetector(onTap: () => Navigator.maybePop(context), child: FigIcon(backIcon, w: 32, h: 32)),
            ),
          Positioned(
            top: cardTop,
            left: 24,
            right: 24,
            child: Container(
              padding: padding,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(radius)),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

/// Card heading used by Forgot / Verify (Poppins SemiBold 20/40 #003b29).
class AuthTitle extends StatelessWidget {
  const AuthTitle(this.title, this.subtitle, {super.key, this.subtitleSize = 13, this.subtitleLh = 22});
  final String title;
  final String subtitle;
  final double subtitleSize;
  final double subtitleLh;

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(title, textAlign: TextAlign.center, style: ts(Ff.poppins, 20, w600, AppColors.green800, lh: 40)),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.2),
          child: Text(subtitle, textAlign: TextAlign.center, style: ts(Ff.poppins, subtitleSize, w400, AppColors.textSecondary, lh: subtitleLh)),
        ),
      ]);
}

/// 50px gold action button with a 12px arrow (Send OTP).
class AuthAction extends StatelessWidget {
  const AuthAction({super.key, required this.label, required this.onTap, this.arrow = true, this.height = 50, this.textStyle});
  final String label;
  final VoidCallback onTap;
  final bool arrow;
  final double height;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => FigButton(
        label: label,
        onTap: onTap,
        height: height,
        textStyle: textStyle ?? ts(Ff.inter, 16, w500, Colors.white, lh: 24),
        trailing: arrow ? const FigIcon('container_9d18190a', w: 12, h: 12) : null,
      );
}
