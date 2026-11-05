/// Form validation helpers shared by the auth and profile screens.
abstract final class Validators {
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// True when [value] looks like an e-mail address.
  static bool isEmail(String value) => _email.hasMatch(value.trim());

  /// True when [value] has non-whitespace content.
  static bool isNotBlank(String value) => value.trim().isNotEmpty;

  /// Password strength 0–4: one point each for 8+ characters, mixed case,
  /// a digit and a symbol.
  static int passwordStrength(String p) {
    var s = 0;
    if (p.length >= 8) s++;
    if (RegExp(r'[A-Z]').hasMatch(p) && RegExp(r'[a-z]').hasMatch(p)) s++;
    if (RegExp(r'\d').hasMatch(p)) s++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(p)) s++;
    return s;
  }
}
