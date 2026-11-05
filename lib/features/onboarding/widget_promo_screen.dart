import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Widget" (6001:2695) + "Add to home screen" sheet (6033:756).
class WidgetPromoScreen extends StatelessWidget {
  const WidgetPromoScreen({super.key});

  Future<void> _addWidget(BuildContext context) async {
    final added = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppColors.transparent,
      barrierColor: AppColors.pureBlack.o(.3),
      isScrollControlled: true,
      builder: (ctx) => const _AddToHomeSheet(),
    );
    if (!context.mounted) return;
    if (added == true) {
      showAppSnackBar(context, 'Widget added to your home screen');
    }
    Navigator.of(context).pushNamed(AppRoutes.readingSetup);
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: DesignCanvas(
        background: AppColors.cream,
        children: [
          Positioned(top: 0, left: -1, width: 391, height: 519 + top, child: Image.asset(AppImages.widgetBg, fit: BoxFit.fill)),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 158 + top,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.cream, AppColors.cream.o(0)],
                ),
              ),
            ),
          ),
          // Header: 62px row at y 10 (+ status bar), 24px side padding.
          Positioned(
            top: top + 10,
            left: 24,
            right: 24,
            height: 62,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(onTap: () => Navigator.maybePop(context), child: const AppIcon('button_margin_35cdaed2', w: 32, h: 46)),
              Text('Widget', style: AppTextStyles.titleTight),
              const AppIcon('button_margin_437cb4d7', w: 32, h: 34),
            ]),
          ),
          CanvasCenter(
            top: top + 95,
            child: SizedBox(
              width: 183,
              child: Column(children: [
                const Logo.icon(width: 75.9),
                AppGap.v20,
                Text('Motivation on Your Home Screen',
                    textAlign: TextAlign.center, style: ts(AppFonts.poppins, 18, w600, AppColors.green900, lh: 27)),
              ]),
            ),
          ),
          Positioned(
            top: top + 257,
            left: 35,
            width: 320.5,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(46.3)),
              child: Image.asset(AppImages.widgetStack, fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
            ),
          ),
          Positioned(
            bottom: 61,
            left: 36,
            right: 32,
            child: AppButton(
              label: 'Add Widget',
              onTap: () => _addWidget(context),
              trailing: AppButton.arrowWhite,
              textStyle: AppTextStyles.button,
            ),
          ),
          Positioned(
            bottom: 31,
            left: 0,
            right: 0,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const AppIcon('gift_305e1646', w: 18, h: 18),
              AppGap.h6,
              Text('A little reminder, every time you unlock', style: ts(AppFonts.inter, 11, w400, AppColors.stone500, lh: 13.8)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _AddToHomeSheet extends StatelessWidget {
  const _AddToHomeSheet();

  @override
  Widget build(BuildContext context) {
    final btn = ts(AppFonts.nunito, 12, w700, AppColors.textPrimary, lh: 16);
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 18.5),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.white.o(.8)),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, AppColors.surface, AppColors.cream],
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: Text('Add to home screen', style: ts(AppFonts.nunito, 17, w700, AppColors.gray800, lh: 25.5, ls: -0.4)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: SizedBox(
              width: 112,
              height: 124,
              child: Column(children: [
                Container(
                  width: 112,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.purple59,
                    borderRadius: AppRadius.br16,
                    boxShadow: AppShadows.lg,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: OverflowBox(
                    maxWidth: 140,
                    child: Image.asset(AppImages.widgetDoingGreat, width: 140, height: 80, fit: BoxFit.cover),
                  ),
                ),
                AppGap.v8,
                Text('Doing Great', textAlign: TextAlign.center, style: ts(AppFonts.nunito, 13, w700, AppColors.gray800, lh: 19.5, ls: -0.3)),
              ]),
            ),
          ),
          AppGap.v16,
          Row(children: [
            Expanded(
              child: Material(
                color: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: AppRadius.br10, side: BorderSide(color: AppColors.textPrimary.o(.2))),
                child: InkWell(
                  borderRadius: AppRadius.br10,
                  onTap: () => Navigator.pop(context, false),
                  child: SizedBox(height: 36, child: Center(child: Text('Cancel', style: btn))),
                ),
              ),
            ),
            AppGap.h12,
            Expanded(
              child: Material(
                color: AppColors.gold53,
                borderRadius: AppRadius.br10,
                child: InkWell(
                  borderRadius: AppRadius.br10,
                  onTap: () => Navigator.pop(context, true),
                  child: SizedBox(height: 36, child: Center(child: Text('Add', style: btn.copyWith(color: AppColors.white)))),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
