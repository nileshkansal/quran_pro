import 'package:flutter/widgets.dart';

/// The four app languages requested by the client.
/// Full string translation (ARB files) is the next round; the choice is
/// already stored and drives text direction for Arabic and Urdu.
enum AppLanguage {
  english('English', 'English', Locale('en'), TextDirection.ltr),
  tamil('Tamil', 'தமிழ்', Locale('ta'), TextDirection.ltr),
  arabic('Arabic', 'العربية', Locale('ar'), TextDirection.rtl),
  urdu('Urdu', 'اردو', Locale('ur'), TextDirection.rtl);

  const AppLanguage(this.englishName, this.nativeName, this.locale, this.direction);
  final String englishName;
  final String nativeName;
  final Locale locale;
  final TextDirection direction;
}
