import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/state/app_state.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Log Out Confirmation" (6001:1438) — 364×584 card.
Future<void> showLogoutDialog(BuildContext context) => showAppModal(
      context,
      duration: const Duration(milliseconds: 220),
      child: Builder(
        builder: (ctx) => AppAlertDialog(
          width: 364,
          height: 584,
          padding: const EdgeInsets.all(41),
          border: AppColors.divider.o(.5),
          icon: const AppIcon.square('container_f7f3a61d', 26.7),
          title: 'Are you sure\nyou want to log out?',
          titleStyle: ts(AppFonts.inter, 32, w600, AppColors.textPrimary, lh: 40),
          titleMaxWidth: 329,
          titleGap: AppSpacing.md + AppSpacing.xl,
          message: 'Your progress and reflections\nwill be saved for your next\nvisit.',
          messageStyle: AppTextStyles.lead,
          actions: [
            AppButton(label: 'Log Out', textStyle: AppTextStyles.buttonWide, onTap: () => _signOut(ctx)),
            AppButton(
              label: 'Stay Signed In',
              height: 58,
              variant: AppButtonVariant.outline,
              borderColor: AppColors.gold36,
              textStyle: AppTextStyles.buttonWide.c(AppColors.gold81),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );

/// Figma: Delete Account dialog (6001:1460) — 350-wide card, pill buttons.
Future<void> showDeleteAccountDialog(BuildContext context) async {
  final ok = await showConfirmDialog(
    context,
    title: 'Delete Account?',
    message:
        'Are you sure you want to delete\nyour account? This action is\npermanent and will erase all your\nreading progress, bookmarks, and\nreflections. This cannot be\nundone.',
    confirmLabel: 'Delete my account',
    cancelLabel: 'Keep my account',
    icon: const AppIcon('icon_88155548', w: 21.3, h: 24),
    destructive: true,
  );
  if (ok && context.mounted) _signOut(context);
}

void _signOut(BuildContext ctx) {
  AppState.instance.update(() => AppState.instance.loggedIn = false);
  mainTabIndex.value = 0;
  Navigator.of(ctx).pushNamedAndRemoveUntil(AppRoutes.welcome, (_) => false);
}
