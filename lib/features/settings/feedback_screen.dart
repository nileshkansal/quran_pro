import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';


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
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _send() {
    if (_rating == 0) {
      showAppSnackBar(context, 'Please choose a star rating');
      return;
    }
    FocusScope.of(context).unfocus();
    showAppSnackBar(context, 'JazakAllahu khairan! Feedback sent.');
    setState(() {
      _rating = 0;
      _text.clear();
    });
    if (widget.standalone) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: AppColors.pageGradient,
      ),
      child: Column(children: [
        AppHeader(
          title: 'Feedback',
          titleStyle: AppTextStyles.title.c(AppColors.textPrimary),
          leading: AppBackButton(
            icon: 'button_go_back_a8f781c0',
            w: 32,
            h: 32,
            onTap: () => widget.standalone ? Navigator.maybePop(context) : mainTabIndex.value = 0,
          ),
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
                        boxShadow: AppShadows.soft,
                      ),
                      child: const AppIcon('container_173edf59', w: 30, h: 30),
                    ),
                    const Positioned(left: 81.1, top: 8, child: AppIcon('sparkles_137004da', w: 6.9, h: 11.7)),
                    const Positioned(left: 8, top: 70, child: AppIcon('container_f3529631', w: 5.9, h: 10)),
                  ]),
                ),
              ),
              const SizedBox(height: 8 + 12),
              Text('We value your feedback!', textAlign: TextAlign.center, style: AppTextStyles.title.c(AppColors.textPrimary)),
              AppGap.v12,
              Text(
                'Please share your thoughts on your\nexperience to help us improve Sacred\nSerenity.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
              AppGap.v40,
              Container(
                padding: AppInsets.all24,
                decoration: AppDecorations.card(border: AppColors.outline.o(.1)),
                child: Column(children: [
                  Text('How was your experience?', style: AppTextStyles.bodyMedium),
                  AppGap.v12,
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    for (var i = 1; i <= 5; i++) ...[
                      if (i > 1) AppGap.h8,
                      GestureDetector(
                        onTap: () => setState(() => _rating = i),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 4, 4, 7),
                          child: AppIcon('button_rate_1_star_1db32288', w: 25, h: 23.8, color: i <= _rating ? AppColors.gold : null),
                        ),
                      ),
                    ],
                  ]),
                ]),
              ),
              AppGap.v40,
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text('Tell us more (optional)', style: AppTextStyles.label),
              ),
              AppGap.v8,
              AppTextArea(controller: _text, hint: 'What did you love? What could be \nbetter?'),
              const SizedBox(height: 6 + 24 + 12),
              AppButton(
                label: 'Send Feedback',
                height: 48,
                onTap: _send,
                leading: const AppIcon('container_7f5e16bc', w: 14.3, h: 12),
                gap: 8,
                textStyle: AppTextStyles.label.c(AppColors.white),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
