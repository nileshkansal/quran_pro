import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show OverflowBoxFit;

import '../core/theme/theme.dart';
import 'app_button.dart';

/// Backdrop styles used by the Figma dialogs and sheets.
enum AppBarrier {
  /// Ink at 35 % (confirmation dialogs).
  dim,

  /// Black at 40 % (Tafsir / Share).
  black,

  /// Deep green at 60 % over a light blur (Qibla, Prayer Times, Dua popups).
  greenBlur,
}

/// Shows [child] over a [barrier]: centred with a fade + scale, or slid up
/// from the bottom when [bottom] is true. Base for every dialog and custom
/// sheet in the app.
Future<T?> showAppModal<T>(
  BuildContext context, {
  required Widget child,
  bool bottom = false,
  AppBarrier barrier = AppBarrier.dim,
  bool dismissible = true,
  Duration duration = const Duration(milliseconds: 260),
}) =>
    showGeneralDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      barrierLabel: 'close',
      barrierColor: AppColors.transparent,
      transitionDuration: duration,
      pageBuilder: (ctx, a, _) {
        final backdrop = switch (barrier) {
          AppBarrier.dim => ColoredBox(color: AppColors.textPrimary.o(.35)),
          AppBarrier.black => ColoredBox(color: AppColors.pureBlack.o(.4)),
          AppBarrier.greenBlur => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: ColoredBox(color: AppColors.green900.o(.6)),
            ),
        };
        final content = Material(type: MaterialType.transparency, child: child);
        return Stack(children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: dismissible ? () => Navigator.pop(ctx) : null,
              child: FadeTransition(opacity: a, child: backdrop),
            ),
          ),
          if (bottom)
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
                child: content,
              ),
            )
          else
            Center(
              child: ScaleTransition(
                scale: Tween(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: a, curve: Curves.easeOut)),
                child: FadeTransition(opacity: a, child: content),
              ),
            ),
        ]);
      },
    );

/// 96px icon disc (#f2f4f0) with a faint outer ring (Log Out / Delete Account).
class DialogIconDisc extends StatelessWidget {
  const DialogIconDisc({super.key, required this.icon});
  final Widget icon;

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: 96,
        child: Stack(clipBehavior: Clip.none, children: [
          Container(alignment: Alignment.center, decoration: const BoxDecoration(color: AppColors.surfaceAlt, shape: BoxShape.circle), child: icon),
          Positioned(
            left: -4.8,
            top: -4.8,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.outline.o(.3))),
            ),
          ),
        ]),
      );
}

/// White alert card: icon disc, title, message, then action buttons.
/// Every confirmation in the app (log out, delete account, reset journey)
/// is an [AppAlertDialog]; Figma-specific sizes are parameters.
class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.actions,
    this.icon,
    this.width = 350,
    this.height,
    this.padding = const EdgeInsets.all(AppSpacing.huge),
    this.titleStyle,
    this.messageStyle,
    this.titleGap = AppSpacing.md,
    this.actionsGap = AppSpacing.huge,
    this.border,
    this.titleMaxWidth,
  });

  final String title;
  final String message;
  final List<Widget> actions;
  final Widget? icon;
  final double width;

  /// Fixed card height (actions are then pinned to the bottom).
  final double? height;
  final EdgeInsets padding;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final double titleGap;
  final double actionsGap;
  final Color? border;

  /// Lets the title run wider than the padded content (Figma's Log Out title
  /// box is 329px inside a 282px content area).
  final double? titleMaxWidth;

  @override
  Widget build(BuildContext context) {
    final titleText = Text(title, textAlign: TextAlign.center, style: titleStyle ?? AppTextStyles.title.c(AppColors.textPrimary));
    return Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppRadius.br20,
          border: border == null ? null : Border.all(color: border!),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) ...[DialogIconDisc(icon: icon!), AppGap.v24],
          if (titleMaxWidth == null)
            titleText
          else
            SizedBox(
              width: double.infinity,
              child: OverflowBox(minWidth: 0, maxWidth: titleMaxWidth, fit: OverflowBoxFit.deferToChild, child: titleText),
            ),
          SizedBox(height: titleGap),
          Text(message, textAlign: TextAlign.center, style: messageStyle ?? AppTextStyles.body),
          if (height != null) const Spacer() else SizedBox(height: actionsGap),
          for (var i = 0; i < actions.length; i++) ...[if (i > 0) AppGap.v12, actions[i]],
        ]),
      );
  }
}

/// One-call confirmation dialog. Resolves to `true` when confirmed.
///
/// ```dart
/// if (await showConfirmDialog(context, title: 'Reset?', message: '…', confirmLabel: 'Reset')) { … }
/// ```
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String cancelLabel = 'Cancel',
  Widget? icon,
  bool destructive = false,
}) async {
  final label = AppTextStyles.label.c(AppColors.white);
  final ok = await showAppModal<bool>(
    context,
    child: Builder(
      builder: (ctx) => AppAlertDialog(
        title: title,
        message: message,
        icon: icon,
        actions: [
          AppButton.pill(
            label: destructive ? confirmLabel.toUpperCase() : confirmLabel,
            variant: destructive ? AppButtonVariant.danger : AppButtonVariant.gold,
            textStyle: label,
            onTap: () => Navigator.pop(ctx, true),
          ),
          AppButton.pill(
            label: destructive ? cancelLabel.toUpperCase() : cancelLabel,
            variant: AppButtonVariant.outline,
            borderColor: AppColors.green800,
            textStyle: label.c(AppColors.green800),
            onTap: () => Navigator.pop(ctx, false),
          ),
        ],
      ),
    ),
  );
  return ok ?? false;
}
