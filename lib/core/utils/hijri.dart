/// Tabular (Kuwaiti) Hijri conversion – accurate to ±1 day, good enough for
/// display. Swap for an Umm al-Qura table/package for production.
class HijriDate {
  const HijriDate(this.year, this.month, this.day);
  final int year;
  final int month;
  final int day;

  static const months = [
    'Muharram',
    'Safar',
    'Rabi Al-Awwal',
    'Rabi Al-Thani',
    'Jumada Al-Awwal',
    'Jumada Al-Akhirah',
    'Rajab',
    'Sha\'ban',
    'Ramadan',
    'Shawwal',
    'Dhul-Qa\'dah',
    'Dhul-Hijjah',
  ];

  String get monthName => months[month - 1];

  @override
  String toString() => '$monthName $day, $year AH';

  static HijriDate fromGregorian(DateTime date) {
    final y = date.year, m = date.month, d = date.day;
    // Julian day number
    final a = (14 - m) ~/ 12;
    final yy = y + 4800 - a;
    final mm = m + 12 * a - 3;
    final jd = d + (153 * mm + 2) ~/ 5 + 365 * yy + yy ~/ 4 - yy ~/ 100 + yy ~/ 400 - 32045;
    // Islamic civil calendar
    var l = jd - 1948440 + 10632;
    final n = (l - 1) ~/ 10631;
    l = l - 10631 * n + 354;
    final j = ((10985 - l) ~/ 5316) * ((50 * l) ~/ 17719) + (l ~/ 5670) * ((43 * l) ~/ 15238);
    l = l - ((30 - j) ~/ 15) * ((17719 * j) ~/ 50) - (j ~/ 16) * ((15238 * j) ~/ 43) + 29;
    final month = (24 * l) ~/ 709;
    final day = l - (709 * month) ~/ 24;
    final year = 30 * n + j - 30;
    return HijriDate(year, month, day);
  }
}

const kWeekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
const kMonths = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

String formatLongDate(DateTime d) => '${kWeekdays[d.weekday - 1]}, ${d.day} ${kMonths[d.month - 1]} ${d.year}';
