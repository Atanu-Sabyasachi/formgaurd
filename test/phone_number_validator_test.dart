import 'package:flutter_test/flutter_test.dart';
import 'package:formgaurd/utils/enums/country_code_enum.dart';
import 'package:formgaurd/utils/enums/phone_validation_rules_enum.dart';
import 'package:formgaurd/validators/phone_number_validator.dart';

void main() {
  group('PhoneValidator Tests', () {
    test('Valid phone number with all default rules', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(),
      );
      expect(validator.validate('+1234567890'), null); // No error
    });

    test('Phone number too short', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(minLength: 8),
      );
      expect(validator.validate('12345'),
          'Phone number must be at least 8 characters long.');
    });

    test('Phone number too long', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(maxLength: 15),
      );
      expect(validator.validate('1234567890123456'),
          'Phone number must not exceed 15 characters.');
    });

    test('Invalid format (does not follow E.164)', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(rules: [PhoneValidationRule.checkFormat]),
      );
      expect(validator.validate('12345'), null);
    });

    test('Valid number but contains special characters (disallowed)', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(
          allowSpecialCharacters: false,
          rules: [PhoneValidationRule.preventSpecialCharacters],
        ),
      );
      expect(validator.validate('123-456-7890'),
          'Phone number must not contain special characters.');
    });

    test('Valid number with allowed special characters', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(
          allowSpecialCharacters: true,
          rules: [PhoneValidationRule.preventSpecialCharacters],
        ),
      );
      expect(validator.validate('123-456-7890'), null);
    });

    // test('Valid phone number with country code validation', () {
    //   final validator = PhoneValidator(
    //     const PhoneValidationOptions(
    //       checkCountryCode: true,
    //       allowedCountryCodes: [
    //         CountryCode.USA,
    //         CountryCode.India,
    //       ],
    //     ),
    //   );
    //   expect(validator.validate('+1234567890'), null); // Valid country code
    // });

    // test('Invalid phone number with unsupported country code', () {
    //   final validator = PhoneValidator(
    //     const PhoneValidationOptions(
    //       checkCountryCode: true,
    //       allowedCountryCodes: [
    //         CountryCode.USA,
    //         CountryCode.India,
    //       ],
    //     ),
    //   );
    //   expect(validator.validate('+441234567890'), 'Invalid country code !');
    // });

    test('Phone number with valid length but invalid country code', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(
          checkCountryCode: true,
          allowedCountryCodes: [CountryCode.India],
          minLength: 8,
          maxLength: 15,
        ),
      );
      expect(validator.validate('+12123456789'), 'Invalid country code !');
    });

    test('Phone number without country code when country code is mandatory',
        () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(
          checkCountryCode: true,
          allowedCountryCodes: [CountryCode.India],
        ),
      );
      expect(validator.validate('1234567890'), 'Invalid country code !');
    });

    test('Valid phone number with correct country code and length', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(
          checkCountryCode: true,
          allowedCountryCodes: [CountryCode.India],
          minLength: 8,
          maxLength: 15,
        ),
      );
      expect(validator.validate('+911234567890'), null); // Valid number
    });

    test('Phone number with invalid characters and checkFormat rule', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(
          rules: [PhoneValidationRule.checkFormat],
        ),
      );
      expect(validator.validate('+123-abc-4567'),
          'Please enter a valid phone number.');
    });

    test(
        'Valid number without special characters and preventSpecialCharacters rule',
        () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(
          allowSpecialCharacters: false,
          rules: [PhoneValidationRule.preventSpecialCharacters],
        ),
      );
      expect(validator.validate('1234567890'), null);
    });

    test('Phone number exceeding max length with country code validation', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(
          checkCountryCode: true,
          allowedCountryCodes: [CountryCode.India],
          maxLength: 10,
        ),
      );
      expect(validator.validate('+911234567890'), null);
    });

    test('Phone number with valid format and rules', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(
          rules: [PhoneValidationRule.checkFormat],
        ),
      );
      expect(validator.validate('+911234567890'), null);
    });

    test('Phone number missing "+" in country code', () {
      final validator = PhoneValidator(
        const PhoneValidationOptions(
          checkCountryCode: true,
          allowedCountryCodes: [CountryCode.India],
        ),
      );
      expect(validator.validate('911234567890'), 'Invalid country code !');
    });
  });
}
