import 'package:flutter/material.dart';

import '../core/theme/theme.dart';

/// Rounded white bottom sheet with drag handle and optional close (X)
/// (FAQ, Contact, language and translator pickers).
Future<T?> showAppSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool showClose = true,
  bool showHandle = true,
  double maxHeightFactor = 0.9,
  Color background = AppColors.white,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.transparent,
    barrierColor: AppColors.green800.o(.45),
    builder: (ctx) {
      final maxH = MediaQuery.of(ctx).size.height * maxHeightFactor;
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxH),
        child: Container(
          decoration: BoxDecoration(color: background, borderRadius: const BorderRadius.vertical(top: Radius.circular(32))),
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(top: showHandle ? 22 : 0, bottom: MediaQuery.of(ctx).viewInsets.bottom),
              child: builder(ctx),
            ),
            if (showHandle)
              Positioned(
                top: AppSpacing.md,
                left: 0,
                right: 0,
                child: Center(child: Container(width: 44, height: 4, decoration: const BoxDecoration(color: AppColors.outline, borderRadius: AppRadius.br4))),
              ),
            if (showClose) Positioned(top: 14, right: 14, child: SheetCloseButton(onTap: () => Navigator.of(ctx).pop())),
          ]),
        ),
      );
    },
  );
}

/// Round close (X) button used on sheets.
class SheetCloseButton extends StatelessWidget {
  const SheetCloseButton({super.key, required this.onTap, this.outlined = false});
  final VoidCallback onTap;
  final bool outlined;

  @override
  Widget build(BuildContext context) => Material(
        color: outlined ? AppColors.white : AppColors.surfaceAlt,
        shape: CircleBorder(side: outlined ? const BorderSide(color: AppColors.textPrimary, width: 1.4) : BorderSide.none),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: const Padding(padding: EdgeInsets.all(6), child: Icon(Icons.close, size: 18, color: AppColors.textPrimary)),
        ),
      );
}
