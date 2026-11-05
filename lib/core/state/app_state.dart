import 'package:flutter/foundation.dart';

import '../l10n/app_language.dart';

enum QuranScript { uthmani, indoPak }

/// Lightweight in-memory app state for the clickable prototype.
/// Swap for a persisted store (shared_preferences / hive / riverpod) later.
class AppState extends ChangeNotifier {
  AppState._();
  static final AppState instance = AppState._();

  AppLanguage appLanguage = AppLanguage.english;
  String get language => appLanguage.nativeName;
  String firstName = 'Abdullah';
  String lastName = 'Khan';
  String email = 'ahmad@example.com';
  int dailyMinutes = 5;
  bool loggedIn = false;
  bool notificationsAllowed = false;
  bool locationAllowed = false;
  String location = 'Chennai, Tamil Nadu, India';

  // Reading preferences
  QuranScript script = QuranScript.uthmani;
  double fontScale = 0.5; // 0..1, "Normal" in the middle
  String translator = 'Saheeh International';

  // Settings toggles
  bool dailyReminder = true;
  bool prayerNotifications = false;
  bool autoPlayNext = true;
  bool autoPlayAyahs = true;
  int repeatAyah = 1; // 0 = infinite
  int reciterIndex = 0;

  // Progress
  int minutesReadToday = 18;
  int streakDays = 12;

  String get fullName => '$firstName $lastName'.trim();

  void update(VoidCallback change) {
    change();
    notifyListeners();
  }

  /// Sections/day + days to finish, mirroring "Set Your Daily Recitation Time".
  int get sectionsPerDay => (dailyMinutes / 5 * 3).round().clamp(1, 12);
  int get daysToComplete => (1280 / sectionsPerDay).ceil();
  int get monthsToComplete => (daysToComplete / 30).round();
}
