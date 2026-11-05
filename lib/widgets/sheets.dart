import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Opens a rounded white bottom sheet with drag handle and optional close (X),
/// matching the Qibla / Prayer Times / Choose Location / Share sheets.
Future<T?> showAppSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool showClose = true,
  bool showHandle = true,
  double maxHeightFactor = 0.9,
  Color background = Colors.white,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.green800.withValues(alpha: 0.45),
    builder: (ctx) {
      final maxH = MediaQuery.of(ctx).size.height * maxHeightFactor;
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxH),
        child: Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: showHandle ? 22 : 0, bottom: MediaQuery.of(ctx).viewInsets.bottom),
                child: builder(ctx),
              ),
              if (showHandle)
                Positioned(
                  top: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(color: AppColors.outline, borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
              if (showClose) Positioned(top: 14, right: 14, child: SheetCloseButton(onTap: () => Navigator.of(ctx).pop())),
            ],
          ),
        ),
      );
    },
  );
}

class SheetCloseButton extends StatelessWidget {
  const SheetCloseButton({super.key, required this.onTap, this.outlined = false});
  final VoidCallback onTap;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: outlined ? Colors.white : AppColors.surfaceAlt,
      shape: CircleBorder(side: outlined ? const BorderSide(color: AppColors.textPrimary, width: 1.4) : BorderSide.none),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(6),
          child: Icon(Icons.close, size: 18, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

/// Centered card dialog (Log Out / Delete Account confirmation).
Future<T?> showAppDialog<T>(BuildContext context, {required WidgetBuilder builder}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'dismiss',
    barrierColor: AppColors.textPrimary.withValues(alpha: 0.35),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (ctx, a1, a2) => Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          child: Padding(padding: const EdgeInsets.fromLTRB(24, 28, 24, 24), child: builder(ctx)),
        ),
      ),
    ),
    transitionBuilder: (ctx, anim, _, child) => FadeTransition(
      opacity: anim,
      child: ScaleTransition(scale: Tween(begin: 0.94, end: 1.0).animate(anim), child: child),
    ),
  );
}
