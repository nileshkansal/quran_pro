import 'package:flutter/material.dart';

import '../../features/auth/forgot_password_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/reset_password_screen.dart';
import '../../features/auth/reset_success_screen.dart';
import '../../features/auth/verify_otp_screen.dart';
import '../../features/home/dua_virtues_screens.dart';
import '../../features/home/main_shell.dart';
import '../../features/onboarding/create_profile_screen.dart';
import '../../features/onboarding/daily_recitation_screen.dart';
import '../../features/onboarding/enable_location_screen.dart';
import '../../features/onboarding/notification_permission_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/onboarding/select_language_screen.dart';
import '../../features/onboarding/splash_screen.dart';
import '../../features/onboarding/welcome_screen.dart';
import '../../features/onboarding/widget_promo_screen.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/profile/my_goals_screen.dart';
import '../../features/quran/daily_reading_screen.dart';
import '../../features/quran/mushaf_screen.dart';
import '../../features/quran/quran_sanctuary_screen.dart';
import '../../features/quran/success_screen.dart';
import '../../features/quran/surah_detail_screen.dart';
import '../../features/settings/about_screen.dart';
import '../../features/settings/audio_recitation_screen.dart';
import '../../features/settings/feedback_screen.dart';
import '../../features/settings/help_about_screen.dart';
import '../../features/settings/legal_screens.dart';
import '../../features/settings/reading_settings_screen.dart';

/// Every screen in the click-flow, named after its Figma frame.
abstract final class AppRoutes {
  // 01 · Splash, onboarding, language & authentication
  static const splash = '/';
  static const selectLanguage = '/select-language';
  static const welcome = '/welcome';
  static const onboarding = '/onboarding';
  static const createProfile = '/create-profile';
  static const dailyRecitation = '/daily-recitation';
  static const notifications = '/notifications';
  static const enableLocation = '/enable-location';
  static const widgetPromo = '/widget';
  static const readingSetup = '/reading-setup';
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const verifyOtp = '/verify-otp';
  static const resetPassword = '/reset-password';
  static const resetSuccess = '/reset-success';

  // 02 · Home
  static const home = '/home';
  static const dua = '/dua';
  static const virtues = '/virtues';

  // 03 · Quran (translation reading) / 04 · Arabic reading
  static const sanctuary = '/quran';
  static const surahDetail = '/quran/surah';
  static const mushaf = '/quran/mushaf';
  static const dailyReading = '/daily-reading';
  static const success = '/success';

  // 05 · Profile & settings
  static const editProfile = '/profile/edit';
  static const myGoals = '/profile/goals';
  static const readingSettings = '/settings/reading';
  static const audioRecitation = '/settings/audio';
  static const about = '/settings/about';
  static const helpAbout = '/settings/help';
  static const privacy = '/settings/privacy';
  static const terms = '/settings/terms';
  static const feedback = '/feedback';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final Widget page = switch (settings.name) {
      splash => const SplashScreen(),
      selectLanguage => SelectLanguageScreen(fromSettings: args == true),
      welcome => const WelcomeScreen(),
      onboarding => OnboardingScreen(tour: args == true),
      createProfile => const CreateProfileScreen(),
      dailyRecitation => const DailyRecitationScreen(),
      notifications => const NotificationPermissionScreen(),
      enableLocation => const EnableLocationScreen(),
      widgetPromo => const WidgetPromoScreen(),
      readingSetup => const ReadingSettingsScreen(onboarding: true),
      login => const LoginScreen(),
      forgotPassword => const ForgotPasswordScreen(),
      verifyOtp => VerifyOtpScreen(email: args is String ? args : 'example12@gmail.com'),
      resetPassword => const ResetPasswordScreen(),
      resetSuccess => const ResetSuccessScreen(),
      home => const MainShell(),
      dua => const DuaScreen(),
      virtues => const VirtuesScreen(),
      sanctuary => QuranSanctuaryScreen(mode: args is ReadingMode ? args : ReadingMode.translation),
      surahDetail => const SurahDetailScreen(),
      mushaf => const MushafScreen(),
      dailyReading => const DailyReadingScreen(),
      success => const SuccessScreen(),
      editProfile => const EditProfileScreen(),
      myGoals => const MyGoalsScreen(),
      readingSettings => const ReadingSettingsScreen(),
      audioRecitation => const AudioRecitationScreen(),
      about => const AboutScreen(),
      helpAbout => const HelpAboutScreen(),
      privacy => const PrivacyPolicyScreen(),
      terms => const TermsScreen(),
      feedback => const FeedbackScreen(standalone: true),
      _ => const SplashScreen(),
    };
    if (settings.name == splash || settings.name == home) {
      return PageRouteBuilder(
        settings: settings,
        transitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (_, _, _) => page,
        transitionsBuilder: (_, a, _, child) => FadeTransition(opacity: a, child: child),
      );
    }
    return MaterialPageRoute(settings: settings, builder: (_) => page);
  }
}
