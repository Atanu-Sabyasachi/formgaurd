class NumberValidator {
  static bool validate(String number) {
    // Check if the input is a valid number (integer or float)
    RegExp regExp = RegExp(r'^-?[0-9]+(\.[0-9]+)?$');
    return regExp.hasMatch(number);
  }
}
