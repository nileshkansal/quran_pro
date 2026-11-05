import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/fig_widgets.dart';

/// Figma: "Widget" (6001:2695) + "Add to home screen" sheet (6033:756).
class WidgetPromoScreen extends StatelessWidget {
  const WidgetPromoScreen({super.key});

  Future<void> _addWidget(BuildContext context) async {
    final added = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: fc(0x000000, .3),
      isScrollControlled: true,
      builder: (ctx) => const _AddToHomeSheet(),
    );
    if (!context.mounted) return;
    if (added == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Widget added to your home screen')));
    }
    Navigator.of(context).pushNamed(AppRoutes.readingSetup);
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: const Color(0xFFFEFBF4),
      body: FigCanvas(
        background: const Color(0xFFFEFBF4),
        children: [
          Positioned(top: 0, left: -1, width: 391, height: 519 + top, child: Image.asset(AppImages.widgetBg, fit: BoxFit.fill)),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 158 + top,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFEFBF6), Color(0x00FEFAF6)],
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
              GestureDetector(onTap: () => Navigator.maybePop(context), child: const FigIcon('button_margin_35cdaed2', w: 32, h: 46)),
              Text('Widget', style: ts(Ff.inter, 20, w700, const Color(0xFF003B29), lh: 28, ls: -0.5)),
              const FigIcon('button_margin_437cb4d7', w: 32, h: 34),
            ]),
          ),
          FigCenter(
            top: top + 95,
            child: SizedBox(
              width: 183,
              child: Column(children: [
                const Logo.icon(width: 75.9),
                const SizedBox(height: 20),
                Text('Motivation on Your Home Screen',
                    textAlign: TextAlign.center, style: ts(Ff.poppins, 18, w600, const Color(0xFF03261C), lh: 27)),
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
            child: FigButton(
              label: 'Add Widget',
              onTap: () => _addWidget(context),
              trailing: FigButton.arrowWhite,
              textStyle: ts(Ff.inter, 16, w500, Colors.white, lh: 28, ls: -0.2),
            ),
          ),
          Positioned(
            bottom: 31,
            left: 0,
            right: 0,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const FigIcon('gift_305e1646', w: 18, h: 18),
              const SizedBox(width: 6),
              Text('A little reminder, every time you unlock', style: ts(Ff.inter, 11, w400, const Color(0xFF78716C), lh: 13.8)),
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
    final btn = ts(Ff.nunito, 12, w700, const Color(0xFF191A1B), lh: 16);
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 18.5),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: fc(0xFFFFFF, .8)),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFBFDFC), Color(0xFFF7FAF8), Color(0xFFFEFBF4)],
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: Text('Add to home screen', style: ts(Ff.nunito, 17, w700, const Color(0xFF1F2937), lh: 25.5, ls: -0.4)),
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
                    color: const Color(0xFF9814BE),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [fShadow(fc(0x000000, .1), 0, 4, 6, -4), fShadow(fc(0x000000, .1), 0, 10, 15, -3)],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: OverflowBox(
                    maxWidth: 140,
                    child: Image.asset(AppImages.widgetDoingGreat, width: 140, height: 80, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Doing Great', textAlign: TextAlign.center, style: ts(Ff.nunito, 13, w700, const Color(0xFF1F2937), lh: 19.5, ls: -0.3)),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: fc(0x191A1B, .2))),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.pop(context, false),
                  child: SizedBox(height: 36, child: Center(child: Text('Cancel', style: btn))),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Material(
                color: const Color(0xFFBE8C30),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.pop(context, true),
                  child: SizedBox(height: 36, child: Center(child: Text('Add', style: btn.copyWith(color: Colors.white)))),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
