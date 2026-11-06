import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../widgets/widgets.dart';

/// Onboarding bottom bar: book icon + "Read. Understand. Live the Quran.",
/// pager dots and the Next button.
class OnboardingBar extends StatelessWidget {
  const OnboardingBar({super.key, required this.index, required this.onNext, this.firstPage = false});
  final int index;
  final VoidCallback onNext;

  /// Page 1 uses a black Next button, white inactive dots and dark text.
  final bool firstPage;

  @override
  Widget build(BuildContext context) {
    final ink = firstPage ? AppColors.black : AppColors.green80;
    return SizedBox(
      width: 358,
      height: 41.9,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        // Two fixed lines: never wraps, even where Flutter's Inter is a
        // touch wider than Figma's 91px text box.
        Row(mainAxisSize: MainAxisSize.min, children: [
          AppIcon.square(firstPage ? 'famicons_book_outline_4baf5e02' : 'famicons_book_outline_d97af45d', 20.4),
          const SizedBox(width: 7.7),
          Text('Read. Understand.\nLive the Quran.', softWrap: false, style: ts(AppFonts.inter, 10.3, w400, ink, lh: 17.1)),
        ]),
        PagerDots(count: 5, index: index, active: ink, inactive: firstPage ? AppColors.white : AppColors.grey15),
        AppButton(
          label: 'Next',
          onTap: onNext,
          width: 93,
          height: 41.9,
          variant: firstPage ? AppButtonVariant.dark : AppButtonVariant.gold,
          textStyle: ts(AppFonts.inter, 10.1, w500, AppColors.white, lh: 13.4, ls: 0.5),
          trailing: const AppIcon.square('container_765421ed', 10.1),
          gap: 6.7,
          shadow: [
            fShadow(AppColors.pureBlack.o(.1), 0, 1.7, 3.4, -1.7),
            fShadow(AppColors.pureBlack.o(.1), 0, 3.4, 5, -0.8),
          ],
        ),
      ]),
    );
  }
}
