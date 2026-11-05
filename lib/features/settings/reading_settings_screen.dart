import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../data/mock_data.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Reading Settings" (6001:7175 onboarding, 6021:2 from Settings).
class ReadingSettingsScreen extends StatefulWidget {
  const ReadingSettingsScreen({super.key, this.onboarding = false});
  final bool onboarding;

  @override
  State<ReadingSettingsScreen> createState() => _ReadingSettingsScreenState();
}

class _ReadingSettingsScreenState extends State<ReadingSettingsScreen> {
  final s = AppState.instance;
  static const _sizes = ['Small', 'Compact', 'Normal', 'Large', 'Extra Large'];
  static const _stroke = AppColors.gold13;

  int get _step => (s.fontScale * 4).round();

  Future<void> _pickTranslator() async {
    final v = await showAppSheet<String>(
      context,
      showClose: false,
      builder: (ctx) => SafeArea(
        top: false,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
            child: GradientText('Choose Translator', style: ts(AppFonts.poppins, 16, w500, AppColors.white, lh: 24), gradient: AppColors.goldGradient),
          ),
          for (final t in kTranslators)
            InkWell(
              onTap: () => Navigator.pop(ctx, t),
              child: Container(
                height: 50,
                padding: AppInsets.h24,
                child: Row(children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: t == s.translator ? AppColors.gold41 : _stroke),
                  ),
                  AppGap.h12,
                  Text(t, style: AppTextStyles.jakartaBody),
                ]),
              ),
            ),
          AppGap.v12,
        ]),
      ),
    );
    if (v != null) setState(() => s.update(() => s.translator = v));
  }

  void _done() {
    if (widget.onboarding) {
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
    } else {
      Navigator.pop(context);
    }
  }

  Widget _circleBtn(String icon, VoidCallback onTap) => GestureDetector(onTap: onTap, child: AppIcon(icon, w: 44, h: 44));

  Widget _sectionHeader(Widget badge, String title) => Padding(
        padding: AppInsets.h4,
        child: SizedBox(
          height: 24,
          child: Row(children: [
            badge,
            AppGap.h8,
            GradientText(title, style: ts(AppFonts.poppins, 14, w500, AppColors.white, lh: 20, ls: -0.3), gradient: AppColors.goldGradient),
          ]),
        ),
      );

  BoxDecoration get _card => BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: _stroke),
        borderRadius: AppRadius.br16,
      );

  @override
  Widget build(BuildContext context) {
    final uthmani = s.script == QuranScript.uthmani;
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          // TopBar & Header: pad 24/16/24/8, gap 8.
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Column(children: [
              SizedBox(
                height: 44,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  _circleBtn('button_go_back_565bfb68', () => Navigator.maybePop(context)),
                  Text('Reading Settings', style: ts(AppFonts.poppins, 20, w600, AppColors.green800, lh: 28, ls: -0.2)),
                  _circleBtn('right_badge_golden_quran_ico_d955ace9', () {}),
                ]),
              ),
              AppGap.v8,
              Padding(
                padding: AppInsets.v8,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    width: double.infinity,
                    child: GradientText('Reading Preferences',
                        style: ts(AppFonts.poppins, 19, w500, AppColors.white, lh: 32, ls: -0.6), gradient: AppColors.goldGradient),
                  ),
                  AppGap.v2,
                  Text('Customize your reading experience', style: AppTextStyles.jakartaCaption.c(AppColors.grey58)),
                ]),
              ),
            ]),
          ),
          const SizedBox(height: 17),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              children: [
                // Quran preview card.
                Container(
                  padding: AppInsets.all20,
                  decoration: _card,
                  child: Column(children: [
                    SizedBox(
                      height: 66,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const Opacity(opacity: 0.8, child: AppIcon('svg_left_gold_flourish_eddbf94b', w: 28, h: 16)),
                        AppGap.h8,
                        GradientText(
                          'قُلْ هُوَ ٱللَّهُ أَحَدٌ',
                          style: ts(uthmani ? AppFonts.amiri : AppFonts.scheherazade, 27 + (_step - 2) * 2.0, w700, AppColors.white, lh: 54, ls: 0.7),
                          gradient: AppColors.goldGradient,
                          textAlign: TextAlign.center,
                        ),
                        AppGap.h8,
                        Transform.flip(flipX: true, child: const Opacity(opacity: 0.8, child: AppIcon('svg_left_gold_flourish_eddbf94b', w: 28, h: 16))),
                      ]),
                    ),
                    const SizedBox(height: 11),
                    SizedBox(
                      height: 14,
                      child: Stack(alignment: Alignment.center, children: [
                        Container(height: 1, color: AppColors.gold41.o(.3)),
                        Container(color: AppColors.white, padding: const EdgeInsets.symmetric(horizontal: 0), child: const AppIcon('background_86bd6867', w: 34, h: 14)),
                      ]),
                    ),
                    const SizedBox(height: 11),
                    Text('“Say, ‘He is Allah—One and Indivisible.’”',
                        textAlign: TextAlign.center,
                        style: ts(AppFonts.poppins, 13, w400, AppColors.green800, lh: 19.5, style: FontStyle.italic)),
                  ]),
                ),
                AppGap.v16,
                _sectionHeader(const AppIcon('overlay_6257a1fd', w: 24, h: 24), 'Quran Text Style'),
                AppGap.v8,
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.gold13.o(.3),
                    border: Border.all(color: _stroke),
                    borderRadius: AppRadius.br16,
                  ),
                  child: Row(children: [
                    Expanded(child: _scriptTile('عُثْمَانِي', 'UTHMANI', uthmani, QuranScript.uthmani)),
                    AppGap.h8,
                    Expanded(child: _scriptTile('انڈو پاک', 'INDO PAK SCRIPT', !uthmani, QuranScript.indoPak)),
                  ]),
                ),
                AppGap.v16,
                _sectionHeader(
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColors.green91.o(.1), shape: BoxShape.circle),
                    child: GradientText('Aa', style: ts(AppFonts.cormorant, 12, w700, AppColors.white, lh: 16), gradient: AppColors.goldGradient),
                  ),
                  'Font Size',
                ),
                AppGap.v8,
                Container(
                  padding: AppInsets.all16,
                  decoration: _card,
                  child: _FontSlider(
                    step: _step,
                    label: _sizes[_step],
                    onChanged: (v) => setState(() => s.update(() => s.fontScale = v / 4)),
                  ),
                ),
                AppGap.v16,
                _sectionHeader(const AppIcon('overlay_ebdf4195', w: 24, h: 24), 'Choose Translator'),
                AppGap.v8,
                Material(
                  color: AppColors.white,
                  shape: const RoundedRectangleBorder(borderRadius: AppRadius.br16, side: BorderSide(color: _stroke)),
                  child: InkWell(
                    borderRadius: AppRadius.br16,
                    onTap: _pickTranslator,
                    child: SizedBox(
                      height: 50,
                      child: Padding(
                        padding: AppInsets.h14,
                        child: Row(children: [
                          Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppColors.gold41, shape: BoxShape.circle)),
                          AppGap.h12,
                          Expanded(child: Text(s.translator, style: AppTextStyles.jakartaBody)),
                          const AppIcon('svg_789a6707', w: 16, h: 16),
                        ]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 75),
                _NextButton(label: widget.onboarding ? 'Next' : 'Save', onTap: _done),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _scriptTile(String arabic, String label, bool selected, QuranScript value) {
    return GestureDetector(
      onTap: () => setState(() => s.update(() => s.script = value)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 66,
        decoration: BoxDecoration(
          gradient: selected ? AppColors.goldGradient : null,
          color: selected ? null : AppColors.white.o(.9),
          border: Border.all(color: AppColors.gold13.o(.6)),
          borderRadius: AppRadius.br12,
        ),
        child: Stack(children: [
          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(arabic,
                  textDirection: TextDirection.rtl,
                  style: ts(AppFonts.amiri, 18, w700, selected ? AppColors.amber100 : AppColors.stone800, lh: 22.5, ls: 0.9)),
              const SizedBox(height: 1),
              Text(label,
                  style: ts(AppFonts.jakarta, 11, w500, selected ? AppColors.amber200.o(.9) : AppColors.grey58, lh: 16.5, ls: 0.3)),
            ]),
          ),
          if (selected) const Positioned(top: 5, right: 6, child: AppIcon('active_check_badge_013d4732', w: 14, h: 14)),
        ]),
      ),
    );
  }
}

/// Discrete 5-step slider drawn to the Figma "Slider Card" spec.
class _FontSlider extends StatelessWidget {
  const _FontSlider({required this.step, required this.label, required this.onChanged});
  final int step;
  final String label;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        height: 19,
        child: LayoutBuilder(builder: (context, c) {
          const trackStart = 8 + 8.6 + 12.0; // pad + small A + gap
          final trackW = c.maxWidth - trackStart - 12 - 12.9 - 8;
          final x = trackStart + trackW * step / 4;
          return Stack(clipBehavior: Clip.none, children: [
            Positioned(
              left: x - 27.35,
              top: 0,
              child: Stack(clipBehavior: Clip.none, alignment: Alignment.topCenter, children: [
                Positioned(
                  top: 13.3,
                  child: Transform.rotate(angle: 0.785398, child: Container(width: 8, height: 8, decoration: const BoxDecoration(gradient: AppColors.goldGradient))),
                ),
                Container(
                  width: 54.7,
                  height: 19,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(gradient: AppColors.goldGradient, borderRadius: AppRadius.pill),
                  child: Text(label, maxLines: 1, style: ts(AppFonts.jakarta, 10, w500, AppColors.amber100, lh: 15)),
                ),
              ]),
            ),
          ]);
        }),
      ),
      AppGap.v4,
      SizedBox(
        height: 36,
        child: Padding(
          padding: AppInsets.h8,
          child: Row(children: [
            Text('A', style: ts(AppFonts.cormorant, 12, w600, AppColors.stone400, lh: 16)),
            AppGap.h12,
            Expanded(
              child: LayoutBuilder(builder: (context, c) {
                final w = c.maxWidth;
                void set(double dx) => onChanged((dx / w * 4).round().clamp(0, 4));
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (d) => set(d.localPosition.dx),
                  onHorizontalDragUpdate: (d) => set(d.localPosition.dx),
                  child: SizedBox(
                    height: 36,
                    child: Stack(alignment: Alignment.centerLeft, clipBehavior: Clip.none, children: [
                      Container(height: 6, decoration: const BoxDecoration(color: AppColors.stone200, borderRadius: AppRadius.pill)),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: w * step / 4,
                        height: 6,
                        decoration: const BoxDecoration(gradient: AppColors.goldGradient, borderRadius: AppRadius.pill),
                      ),
                      Padding(
                        padding: AppInsets.h4,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          for (var i = 0; i < 5; i++)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i <= step ? AppColors.white : AppColors.stone300,
                                border: i <= step ? Border.all(color: AppColors.stone300) : null,
                              ),
                            ),
                        ]),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 150),
                        left: w * step / 4 - 11,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            gradient: AppColors.goldGradient,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.white, width: 3),
                            boxShadow: [fShadow(AppColors.emerald900.o(.3), 0, 2, 8)],
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              }),
            ),
            AppGap.h12,
            GradientText('A', style: ts(AppFonts.cormorant, 18, w700, AppColors.white, lh: 28), gradient: AppColors.goldGradient),
          ]),
        ),
      ),
    ]);
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Container(
        height: 62,
        decoration: BoxDecoration(
          gradient: AppColors.goldGradient,
          border: Border.all(color: AppColors.amber300.o(.4)),
          borderRadius: AppRadius.br10,
          boxShadow: [fShadow(AppColors.emerald900.o(.3), 0, 10, 25, -3)],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: AppRadius.br10,
            onTap: onTap,
            child: Stack(alignment: Alignment.center, children: [
              Text(label, style: ts(AppFonts.cormorant, 18, w500, AppColors.white, lh: 28, ls: 0.4)),
              const Positioned(right: 21, child: AppIcon('right_arrow_icon_a39b31d2', w: 32, h: 32)),
            ]),
          ),
        ),
      );
}
