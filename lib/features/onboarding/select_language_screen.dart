import 'package:flutter/material.dart';

import '../../core/l10n/app_language.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Select Language" (6001:1549)
class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key, this.fromSettings = false});
  final bool fromSettings;

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  AppLanguage _lang = AppState.instance.appLanguage;

  Future<void> _pick() async {
    final v = await showAppSheet<AppLanguage>(
      context,
      showClose: false,
      builder: (ctx) => SafeArea(
        top: false,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
            child: Text('Select language', style: ts(AppFonts.poppins, 16, w600, AppColors.green800, lh: 28)),
          ),
          for (final l in AppLanguage.values)
            InkWell(
              onTap: () => Navigator.pop(ctx, l),
              child: Container(
                height: 56,
                padding: AppInsets.h24,
                child: Row(children: [
                  Expanded(child: Text(l.nativeName, style: AppTextStyles.body.c(AppColors.textPrimary))),
                  if (l == _lang) const Icon(Icons.check_circle, color: AppColors.green700, size: 20),
                ]),
              ),
            ),
          AppGap.v12,
        ]),
      ),
    );
    if (v != null) setState(() => _lang = v);
  }

  void _continue() {
    AppState.instance.update(() => AppState.instance.appLanguage = _lang);
    if (widget.fromSettings) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: DesignCanvas(
        background: AppColors.background,
        children: [
          const Positioned.fill(child: LanternBackdrop()),
          if (widget.fromSettings)
            Positioned(top: MediaQuery.of(context).padding.top + 4, left: 8, child: const ArrowBackButton()),
          // Logo group 189.2×223.5 at y 163.9, column gap 15.
          CanvasCenter(
            top: 163.9,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Logo.lockup(width: 163.5),
              AppGap.v15,
              const DecorDivider(),
              AppGap.v15,
              Text('RECITE | UNDERSTAND | TRANSFORM', style: ts(AppFonts.inter, 8.3, w400, AppColors.green72, lsPct: 14)),
            ]),
          ),
          // Form 343×175 at (24, 461), gap 24.
          Positioned(
            top: 461,
            left: 24,
            right: 24,
            child: Column(children: [
              Text(
                'Select your preferred language to begin',
                textAlign: TextAlign.center,
                style: ts(AppFonts.poppins, 13, w500, AppColors.black, lh: 20),
              ),
              const SizedBox(height: 19),
              Material(
                color: AppColors.surface,
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.br10,
                  side: BorderSide(color: AppColors.outline),
                ),
                child: InkWell(
                  borderRadius: AppRadius.br10,
                  onTap: _pick,
                  child: SizedBox(
                    height: 56,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(children: [
                        const AppIcon('icon_d03431c7', w: 20, h: 20),
                        const SizedBox(width: 11),
                        Expanded(child: Text(_lang.nativeName, style: AppTextStyles.body.c(AppColors.textPrimary))),
                        const AppIcon('vector_e1c36d8e', w: 9.6, h: 4.8),
                        AppGap.h15,
                      ]),
                    ),
                  ),
                ),
              ),
              AppGap.v24,
              AppButton(
                label: widget.fromSettings ? 'Save' : 'Bismillah',
                onTap: _continue,
                textStyle: ts(AppFonts.poppins, 16, w600, AppColors.white, lh: 28, ls: -0.2),
                trailing: AppButton.arrowWhite,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
