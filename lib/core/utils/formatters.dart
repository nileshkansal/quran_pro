/// Text formatting helpers.
abstract final class Formatters {
  static const _arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  static const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  /// 12 → "١٢" (Arabic-Indic numerals for ayah markers).
  static String arabicDigits(int n) => n.toString().split('').map((c) => _arabicDigits[int.parse(c)]).join();

  /// "John Doe" → "JD".
  static String initials(String name) {
    final p = name.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
    if (p.isEmpty) return '';
    return (p.first[0] + (p.length > 1 ? p.last[0] : '')).toUpperCase();
  }

  /// "John Ali Doe" → ("John", "Ali Doe").
  static (String first, String last) splitName(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    return (parts.first, parts.length > 1 ? parts.sublist(1).join(' ') : '');
  }

  /// DateTime → "Dec 2027".
  static String monthYear(DateTime d) => '${_months[d.month - 1]} ${d.year}';

  /// 7 → "07".
  static String twoDigits(int n) => n.toString().padLeft(2, '0');
}
