import 'package:flutter_test/flutter_test.dart';
import 'package:formgaurd/formgaurd.dart'; // Import the formgaurd package
import 'package:formgaurd/validation_result.dart';

void main() {
  group('FormGuard Validation Tests', () {
    test('Validate String: Valid input', () {
      // Test case for a valid string
      String validString = 'Hello';
      ValidationResult result = FormGuard.validateString(validString);

      expect(result.isValid, true);
      expect(result.message, 'Valid input');
    });

    test('Validate String: Empty input', () {
      // Test case for an empty string
      String invalidString = '';
      ValidationResult result = FormGuard.validateString(invalidString);

      expect(result.isValid, false);
      expect(result.message, 'String cannot be empty');
    });

    test('Validate Number: Valid integer', () {
      // Test case for a valid integer number
      String validNumber = '123';
      ValidationResult result = FormGuard.validateNumber(validNumber);

      expect(result.isValid, true);
      expect(result.message, 'Valid number');
    });

    test('Validate Number: Invalid number', () {
      // Test case for an invalid number (e.g., alphabet)
      String invalidNumber = 'abc';
      ValidationResult result = FormGuard.validateNumber(invalidNumber);

      expect(result.isValid, false);
      expect(result.message, 'Please enter a valid number');
    });

    test('Validate Date: Valid date', () {
      // Test case for a valid date (YYYY-MM-DD format)
      String validDate = '2024-12-06';
      ValidationResult result = FormGuard.validateDate(validDate);

      expect(result.isValid, true);
      expect(result.message, 'Valid date');
    });

    test('Validate Date: Invalid date', () {
      // Test case for an invalid date (wrong format)
      String invalidDate = '06-12-2024';
      ValidationResult result = FormGuard.validateDate(invalidDate);

      expect(result.isValid, false);
      expect(result.message, 'Please enter a valid date (YYYY-MM-DD)');
    });
  });
}
