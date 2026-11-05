import 'package:flutter/material.dart';

import '../core/theme/theme.dart';
import 'app_icon.dart';

/// Lays children out at their exact Figma coordinates on a 390 × [designHeight]
/// canvas. On taller screens the canvas grows (bottom-anchored children follow
/// the bottom edge); on shorter screens the page scrolls, so nothing clips.
class DesignCanvas extends StatelessWidget {
  const DesignCanvas({
    super.key,
    required this.children,
    this.designHeight = AppDesign.height,
    this.background,
    this.decoration,
    this.bottomInset = true,
  });

  final List<Widget> children;
  final double designHeight;
  final Color? background;
  final Decoration? decoration;

  /// Adds the keyboard height as bottom padding so fields stay reachable.
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

/// Places a child horizontally centred on a [DesignCanvas] at Figma [top].
class CanvasCenter extends StatelessWidget {
  const CanvasCenter({super.key, required this.top, required this.child});
  final double top;
  final Widget child;

  @override
  Widget build(BuildContext context) => Positioned(top: top, left: 0, right: 0, child: Center(child: child));
}

/// Back button drawn with an exported Figma icon (pops the route by default).
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.icon = 'button_3ee2efe6', this.w = 16, this.h = 22, this.onTap});
  final String icon;
  final double w;
  final double h;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap ?? () => Navigator.maybePop(context),
        child: AppIcon(icon, w: w, h: h),
      );
}

/// The 64px translucent top bar used by most inner pages: back button,
/// Inter Bold 20 title (centred or after the back button), optional trailing.
class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.centerTitle = true,
    this.titleStyle,
    this.titleGap = AppSpacing.xxl,
    this.background,
  });

  final String title;

  /// Usually an [AppBackButton]; `null` hides it.
  final Widget? leading;
  final Widget? trailing;
  final bool centerTitle;
  final TextStyle? titleStyle;

  /// Gap between [leading] and a left-aligned title.
  final double titleGap;

  /// Defaults to the page surface at 80 %.
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final t = Text(title, style: titleStyle ?? AppTextStyles.title);
    return Container(
      height: AppSizes.headerHeight + top,
      color: background ?? AppColors.surface.o(.8),
      padding: EdgeInsets.fromLTRB(AppSpacing.page, top, AppSpacing.page, 0),
      child: centerTitle
          ? Stack(alignment: Alignment.center, children: [
              if (leading != null) Align(alignment: Alignment.centerLeft, child: leading),
              t,
              if (trailing != null) Align(alignment: Alignment.centerRight, child: trailing),
            ])
          : Row(children: [
              if (leading != null) ...[leading!, SizedBox(width: titleGap)],
              Expanded(child: t),
              ?trailing,
            ]),
    );
  }
}

/// Page shell for simple inner pages (Help, Legal, About): surface → white
/// gradient, [AppHeader] with a back button, and a padded scrolling body.
class AppSubPage extends StatelessWidget {
  const AppSubPage({
    super.key,
    required this.title,
    required this.children,
    this.back = const AppBackButton(),
    this.centerTitle = true,
    this.titleStyle,
    this.padding = AppInsets.page,
  });
  final String title;
  final List<Widget> children;
  final Widget back;
  final bool centerTitle;
  final TextStyle? titleStyle;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(gradient: AppColors.pageGradient),
          child: Column(children: [
            AppHeader(title: title, leading: back, centerTitle: centerTitle, titleStyle: titleStyle),
            Expanded(child: ListView(padding: padding, children: children)),
          ]),
        ),
      );
}

/// Material back arrow (24px) for frames that use the plain arrow.
class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key, this.onTap, this.color = AppColors.textPrimary, this.size = AppSizes.iconLg});
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
