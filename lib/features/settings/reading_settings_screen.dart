import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/sheets.dart';

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
  static const _stroke = Color(0xFFE8E2D5);

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
            child: GradientText('Choose Translator', style: ts(Ff.poppins, 16, w500, Colors.white, lh: 24), gradient: AppColors.goldGradient),
          ),
          for (final t in kTranslators)
            InkWell(
              onTap: () => Navigator.pop(ctx, t),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: t == s.translator ? const Color(0xFFC5A869) : _stroke),
                  ),
                  const SizedBox(width: 12),
                  Text(t, style: ts(Ff.jakarta, 14, w500, const Color(0xFF292524), lh: 20)),
                ]),
              ),
            ),
          const SizedBox(height: 12),
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

  Widget _circleBtn(String icon, VoidCallback onTap) => GestureDetector(onTap: onTap, child: FigIcon(icon, w: 44, h: 44));

  Widget _sectionHeader(Widget badge, String title) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          height: 24,
          child: Row(children: [
            badge,
            const SizedBox(width: 8),
            GradientText(title, style: ts(Ff.poppins, 14, w500, Colors.white, lh: 20, ls: -0.3), gradient: AppColors.goldGradient),
          ]),
        ),
      );

  BoxDecoration get _card => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _stroke),
        borderRadius: BorderRadius.circular(16),
      );

  @override
  Widget build(BuildContext context) {
    final uthmani = s.script == QuranScript.uthmani;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
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
                  Text('Reading Settings', style: ts(Ff.poppins, 20, w600, AppColors.green800, lh: 28, ls: -0.2)),
                  _circleBtn('right_badge_golden_quran_ico_d955ace9', () {}),
                ]),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    width: double.infinity,
                    child: GradientText('Reading Preferences',
                        style: ts(Ff.poppins, 19, w500, Colors.white, lh: 32, ls: -0.6), gradient: AppColors.goldGradient),
                  ),
                  const SizedBox(height: 2),
                  Text('Customize your reading experience', style: ts(Ff.jakarta, 12, w400, const Color(0xFF657069), lh: 16)),
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
                  padding: const EdgeInsets.all(20),
                  decoration: _card,
                  child: Column(children: [
                    SizedBox(
                      height: 66,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const Opacity(opacity: 0.8, child: FigIcon('svg_left_gold_flourish_eddbf94b', w: 28, h: 16)),
                        const SizedBox(width: 8),
                        GradientText(
                          'قُلْ هُوَ ٱللَّهُ أَحَدٌ',
                          style: ts(uthmani ? Ff.amiri : Ff.scheherazade, 27 + (_step - 2) * 2.0, w700, Colors.white, lh: 54, ls: 0.7),
                          gradient: AppColors.goldGradient,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 8),
                        Transform.flip(flipX: true, child: const Opacity(opacity: 0.8, child: FigIcon('svg_left_gold_flourish_eddbf94b', w: 28, h: 16))),
                      ]),
                    ),
                    const SizedBox(height: 11),
                    SizedBox(
                      height: 14,
                      child: Stack(alignment: Alignment.center, children: [
                        Container(height: 1, color: fc(0xC5A869, .3)),
                        Container(color: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 0), child: const FigIcon('background_86bd6867', w: 34, h: 14)),
                      ]),
                    ),
                    const SizedBox(height: 11),
                    Text('“Say, ‘He is Allah—One and Indivisible.’”',
                        textAlign: TextAlign.center,
                        style: ts(Ff.poppins, 13, w400, AppColors.green800, lh: 19.5, style: FontStyle.italic)),
                  ]),
                ),
                const SizedBox(height: 16),
                _sectionHeader(const FigIcon('overlay_6257a1fd', w: 24, h: 24), 'Quran Text Style'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: fc(0xE8E2D5, .3),
                    border: Border.all(color: _stroke),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(children: [
                    Expanded(child: _scriptTile('عُثْمَانِي', 'UTHMANI', uthmani, QuranScript.uthmani)),
                    const SizedBox(width: 8),
                    Expanded(child: _scriptTile('انڈو پاک', 'INDO PAK SCRIPT', !uthmani, QuranScript.indoPak)),
                  ]),
                ),
                const SizedBox(height: 16),
                _sectionHeader(
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: fc(0x022C22, .1), shape: BoxShape.circle),
                    child: GradientText('Aa', style: ts(Ff.cormorant, 12, w700, Colors.white, lh: 16), gradient: AppColors.goldGradient),
                  ),
                  'Font Size',
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: _card,
                  child: _FontSlider(
                    step: _step,
                    label: _sizes[_step],
                    onChanged: (v) => setState(() => s.update(() => s.fontScale = v / 4)),
                  ),
                ),
                const SizedBox(height: 16),
                _sectionHeader(const FigIcon('overlay_ebdf4195', w: 24, h: 24), 'Choose Translator'),
                const SizedBox(height: 8),
                Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: _stroke)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: _pickTranslator,
                    child: SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(children: [
                          Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFFC5A869), shape: BoxShape.circle)),
                          const SizedBox(width: 12),
                          Expanded(child: Text(s.translator, style: ts(Ff.jakarta, 14, w500, const Color(0xFF292524), lh: 20))),
                          const FigIcon('svg_789a6707', w: 16, h: 16),
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
          color: selected ? null : fc(0xFFFFFF, .9),
          border: Border.all(color: fc(0xE8E2D5, .6)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(children: [
          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(arabic,
                  textDirection: TextDirection.rtl,
                  style: ts(Ff.amiri, 18, w700, selected ? const Color(0xFFFEF3C7) : const Color(0xFF292524), lh: 22.5, ls: 0.9)),
              const SizedBox(height: 1),
              Text(label,
                  style: ts(Ff.jakarta, 11, w500, selected ? fc(0xFDE68A, .9) : const Color(0xFF657069), lh: 16.5, ls: 0.3)),
            ]),
          ),
          if (selected) const Positioned(top: 5, right: 6, child: FigIcon('active_check_badge_013d4732', w: 14, h: 14)),
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
                  decoration: BoxDecoration(gradient: AppColors.goldGradient, borderRadius: BorderRadius.circular(9999)),
                  child: Text(label, maxLines: 1, style: ts(Ff.jakarta, 10, w500, const Color(0xFFFEF3C7), lh: 15)),
                ),
              ]),
            ),
          ]);
        }),
      ),
      const SizedBox(height: 4),
      SizedBox(
        height: 36,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(children: [
            Text('A', style: ts(Ff.cormorant, 12, w600, const Color(0xFFA8A29E), lh: 16)),
            const SizedBox(width: 12),
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
                      Container(height: 6, decoration: BoxDecoration(color: const Color(0xFFE7E5E4), borderRadius: BorderRadius.circular(9999))),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: w * step / 4,
                        height: 6,
                        decoration: BoxDecoration(gradient: AppColors.goldGradient, borderRadius: BorderRadius.circular(9999)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          for (var i = 0; i < 5; i++)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i <= step ? Colors.white : const Color(0xFFD6D3D1),
                                border: i <= step ? Border.all(color: const Color(0xFFD6D3D1)) : null,
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
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [fShadow(fc(0x064E3B, .3), 0, 2, 8)],
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              }),
            ),
            const SizedBox(width: 12),
            GradientText('A', style: ts(Ff.cormorant, 18, w700, Colors.white, lh: 28), gradient: AppColors.goldGradient),
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
          border: Border.all(color: fc(0xFCD34D, .4)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [fShadow(fc(0x064E3B, .3), 0, 10, 25, -3)],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Stack(alignment: Alignment.center, children: [
              Text(label, style: ts(Ff.cormorant, 18, w500, Colors.white, lh: 28, ls: 0.4)),
              const Positioned(right: 21, child: FigIcon('right_arrow_icon_a39b31d2', w: 32, h: 32)),
            ]),
          ),
        ),
      );
}
