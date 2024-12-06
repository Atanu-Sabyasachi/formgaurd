library formgaurd;

import 'package:formgaurd/validation_result.dart';

import 'validators/date_validator.dart';
import 'validators/number_validator.dart';
import 'validators/string_validator.dart';

/// A class responsible for handling various form validations.
class FormGuard {
  /// Validates a string input. Ensures the string is not empty.
  static ValidationResult validateString(String input) {
    bool isValid = StringValidator.validate(input);
    return ValidationResult(
      isValid: isValid,
      message: isValid ? 'Valid input' : 'String cannot be empty',
    );
  }

  /// Validates a number input. Ensures the string represents a valid number (integer or float).
  static ValidationResult validateNumber(String number) {
    bool isValid = NumberValidator.validate(number);
    return ValidationResult(
      isValid: isValid,
      message: isValid ? 'Valid number' : 'Please enter a valid number',
    );
  }

  /// Validates a date input. Ensures the date follows the 'YYYY-MM-DD' format.
  static ValidationResult validateDate(String date) {
    bool isValid = DateValidator.validate(date);
    return ValidationResult(
      isValid: isValid,
      message:
          isValid ? 'Valid date' : 'Please enter a valid date (YYYY-MM-DD)',
    );
  }
}
