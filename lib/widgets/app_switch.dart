import 'package:flutter/material.dart';

import '../core/theme/theme.dart';

/// Figma toggle. Default 44×24 track (#176b4d on / #e1e3df off, 20px knob);
/// [AppSwitch.small] is the 36×20 My Goals variant.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = AppSizes.switchWidth,
    this.height = AppSizes.switchHeight,
    this.activeColor = AppColors.green500,
    this.inactiveColor = AppColors.divider,
    this.knobBorder = true,
  });

  const AppSwitch.small({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = AppColors.green79,
    this.inactiveColor = AppColors.gold10,
  })  : width = 36,
        height = 20,
        knobBorder = false;

  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final bool knobBorder;

  @override
  Widget build(BuildContext context) {
    final knob = height - 4;
    return Semantics(
      toggled: value,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: width,
          height: height,
          padding: AppInsets.all2,
          decoration: BoxDecoration(color: value ? activeColor : inactiveColor, borderRadius: AppRadius.pill),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: knob,
              height: knob,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: knobBorder ? Border.all(color: value ? AppColors.white : AppColors.gray300) : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
