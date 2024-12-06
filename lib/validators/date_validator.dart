class DateValidator {
  static bool validate(String date) {
    // Simple date validation format (YYYY-MM-DD)
    RegExp regExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return regExp.hasMatch(date);
  }
}
