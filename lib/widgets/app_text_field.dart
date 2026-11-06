import 'package:flutter/material.dart';

import '../core/theme/theme.dart';

/// The design's text input: 58 high, radius 10, 1px outline @50 %, white fill,
/// Inter 16/24 text, a fixed-width leading icon slot and an optional trailing.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.leading,
    this.leadingWidth = 48,
    this.trailing,
    this.trailingPad = AppSpacing.lg,
    this.obscure = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.enabled = true,
    this.height = AppSizes.inputHeight,
    this.radius = AppSizes.inputRadius,
    this.borderColor,
    this.fill = AppColors.white,
    this.textStyle,
    this.hintStyle,
  });

  final TextEditingController? controller;
  final String? hint;
  final Widget? leading;
  final double leadingWidth;
  final Widget? trailing;
  final double trailingPad;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool enabled;
  final double height;
  final double radius;

  /// Defaults to the outline colour at 50 %.
  final Color? borderColor;
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
        border: Border.all(color: borderColor ?? AppColors.outline.o(.5)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: leadingWidth,
            child: leading == null ? null : Align(alignment: Alignment.centerLeft, child: leading),
          ),
          Expanded(
            // Material ancestor so the field also works outside a Scaffold.
            child: Material(
              type: MaterialType.transparency,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                enabled: enabled,
                obscureText: obscure,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                cursorColor: AppColors.green700,
                style: textStyle ?? AppTextStyles.body.c(AppColors.textPrimary),
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: hintStyle ?? AppTextStyles.body.c(AppColors.grey38),
                ),
              ),
            ),
          ),
          ?trailing,
          SizedBox(width: trailingPad),
        ],
      ),
    );
  }
}

/// [AppTextField] with a built-in show / hide toggle for passwords.
///
/// [toggleBuilder] draws the eye icon for the current visibility, so each
/// Figma frame can keep its own icon.
class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    required this.controller,
    required this.toggleBuilder,
    this.hint,
    this.leading,
    this.leadingWidth = 48,
    this.onChanged,
    this.height = AppSizes.inputHeight,
    this.radius = AppSizes.inputRadius,
    this.borderColor,
    this.fill = AppColors.white,
    this.hintStyle,
  });

  final TextEditingController controller;
  final Widget Function(bool visible) toggleBuilder;
  final String? hint;
  final Widget? leading;
  final double leadingWidth;
  final ValueChanged<String>? onChanged;
  final double height;
  final double radius;
  final Color? borderColor;
  final Color fill;
  final TextStyle? hintStyle;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) => AppTextField(
    controller: widget.controller,
    hint: widget.hint,
    obscure: !_visible,
    leading: widget.leading,
    leadingWidth: widget.leadingWidth,
    onChanged: widget.onChanged,
    height: widget.height,
    radius: widget.radius,
    borderColor: widget.borderColor,
    fill: widget.fill,
    hintStyle: widget.hintStyle,
    trailingPad: 0,
    trailing: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _visible = !_visible),
      child: widget.toggleBuilder(_visible),
    ),
  );
}

/// Caps label above a compact field (Edit Profile: "FULL NAME").
class AppLabeledField extends StatelessWidget {
  const AppLabeledField({super.key, required this.label, required this.controller, this.keyboardType, this.hint});
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hint;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.label),
      AppGap.v4,
      AppTextField(
        controller: controller,
        keyboardType: keyboardType,
        hint: hint,
        height: 49,
        radius: AppRadius.r8,
        leadingWidth: AppSpacing.md,
        trailingPad: AppSpacing.md,
        borderColor: AppColors.outline.o(.3),
        textStyle: AppTextStyles.body.c(AppColors.gray500),
      ),
    ],
  );
}

/// Multi-line input with a live "n/max" counter (Feedback).
class AppTextArea extends StatelessWidget {
  const AppTextArea({super.key, required this.controller, this.hint, this.height = 154, this.maxLength = 500});
  final TextEditingController controller;
  final String? hint;
  final double height;
  final int maxLength;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.outline),
          borderRadius: AppRadius.br12,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: TextField(
            controller: controller,
            maxLines: null,
            expands: true,
            maxLength: maxLength,
            buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: AppColors.green700,
            style: AppTextStyles.body.c(AppColors.textPrimary),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: AppInsets.all16,
              hintText: hint,
              hintStyle: AppTextStyles.body.c(AppColors.textMuted),
            ),
          ),
        ),
      ),
      Positioned(
        right: AppSpacing.lg,
        bottom: AppSpacing.s6,
        child: ListenableBuilder(
          listenable: controller,
          builder: (_, _) => Text('${controller.text.length}/$maxLength', style: AppTextStyles.label.c(AppColors.textMuted)),
        ),
      ),
    ],
  );
}
