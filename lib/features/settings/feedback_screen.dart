import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/fig_widgets.dart';

/// Figma: "Feedback" (6001:923) — also the Feedback tab of the bottom bar.
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key, this.standalone = false});
  final bool standalone;

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _rating = 0;
  final _text = TextEditingController();

  @override
  void initState() {
    super.initState();
    _text.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _send() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please choose a star rating')));
      return;
    }
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('JazakAllahu khairan! Feedback sent.')));
    setState(() {
      _rating = 0;
      _text.clear();
    });
    if (widget.standalone) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF8FAF6), Colors.white]),
      ),
      child: Column(children: [
        Container(
          height: 64 + top,
          color: fc(0xF8FAF6, .8),
          padding: EdgeInsets.fromLTRB(24, top, 24, 0),
          child: Stack(alignment: Alignment.center, children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => widget.standalone ? Navigator.maybePop(context) : mainTabIndex.value = 0,
                child: const FigIcon('button_go_back_a8f781c0', w: 32, h: 32),
              ),
            ),
            Text('Feedback', style: ts(Ff.inter, 20, w700, AppColors.textPrimary, lh: 28, ls: -0.2)),
          ]),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            children: [
              Center(
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: Stack(children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: AppColors.goldGradient,
                        shape: BoxShape.circle,
                        boxShadow: [fShadow(fc(0x000000, .04), 0, 4, 20)],
                      ),
                      child: const FigIcon('container_173edf59', w: 30, h: 30),
                    ),
                    const Positioned(left: 81.1, top: 8, child: FigIcon('sparkles_137004da', w: 6.9, h: 11.7)),
                    const Positioned(left: 8, top: 70, child: FigIcon('container_f3529631', w: 5.9, h: 10)),
                  ]),
                ),
              ),
              const SizedBox(height: 8 + 12),
              Text('We value your feedback!', textAlign: TextAlign.center, style: ts(Ff.inter, 20, w700, AppColors.textPrimary, lh: 28, ls: -0.2)),
              const SizedBox(height: 12),
              Text(
                'Please share your thoughts on your\nexperience to help us improve Sacred\nSerenity.',
                textAlign: TextAlign.center,
                style: ts(Ff.inter, 16, w400, AppColors.textSecondary, lh: 24),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: figCard(border: fc(0xBFC9C2, .1)),
                child: Column(children: [
                  Text('How was your experience?', style: ts(Ff.inter, 16, w500, AppColors.textPrimary, lh: 24)),
                  const SizedBox(height: 12),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    for (var i = 1; i <= 5; i++) ...[
                      if (i > 1) const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => setState(() => _rating = i),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 4, 4, 7),
                          child: FigIcon('button_rate_1_star_1db32288', w: 25, h: 23.8, color: i <= _rating ? AppColors.gold : null),
                        ),
                      ),
                    ],
                  ]),
                ]),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text('Tell us more (optional)', style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16, ls: 0.6)),
              ),
              const SizedBox(height: 8),
              Stack(children: [
                Container(
                  height: 154,
                  decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.outline), borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: _text,
                    maxLines: null,
                    expands: true,
                    maxLength: 500,
                    buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                    textAlignVertical: TextAlignVertical.top,
                    style: ts(Ff.inter, 16, w400, AppColors.textPrimary, lh: 24),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                      hintText: 'What did you love? What could be \nbetter?',
                      hintStyle: ts(Ff.inter, 16, w400, AppColors.textMuted, lh: 24),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 6,
                  child: Text('${_text.text.length}/500', style: ts(Ff.inter, 12, w500, AppColors.textMuted, lh: 16, ls: 0.6)),
                ),
              ]),
              const SizedBox(height: 6 + 24 + 12),
              FigButton(
                label: 'Send Feedback',
                height: 48,
                onTap: _send,
                leading: const FigIcon('container_7f5e16bc', w: 14.3, h: 12),
                gap: 8,
                textStyle: ts(Ff.inter, 12, w500, Colors.white, lh: 16, ls: 0.6),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
