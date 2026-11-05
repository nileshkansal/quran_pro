import 'package:flutter/material.dart';

import '../../widgets/bottom_nav.dart';
import '../profile/profile_screen.dart';
import '../settings/feedback_screen.dart';
import '../settings/settings_screen.dart';
import 'home_screen.dart';

/// Root after onboarding/login: Home · Feedback · Setting · Profile.
class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: mainTabIndex,
      builder: (context, index, _) => PopScope(
        canPop: index == 0,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) mainTabIndex.value = 0;
        },
        child: Scaffold(
          body: IndexedStack(index: index, children: const [HomeScreen(), FeedbackScreen(), SettingsScreen(), ProfileScreen()]),
          bottomNavigationBar: AppBottomNav(index: index, onTap: (i) => mainTabIndex.value = i),
        ),
      ),
    );
  }
}
