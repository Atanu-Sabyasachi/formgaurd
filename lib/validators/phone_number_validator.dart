import 'package:formgaurd/utils/enums/country_code_enum.dart';
import 'package:formgaurd/utils/enums/phone_validation_rules_enum.dart';

/// Validation options for phone numbers.
class PhoneValidationOptions {
  const PhoneValidationOptions({
    this.rules = const [
      PhoneValidationRule.checkFormat,
      PhoneValidationRule.checkMinLength,
      PhoneValidationRule.checkMaxLength,
    ],
    this.minLength = 8,
    this.maxLength = 15,
    this.allowedCountryCodes,
    this.allowSpecialCharacters = true,
    this.checkCountryCode = false, // New property for country code validation
  });

  /// Whether to allow special characters in the phone number.
  final bool allowSpecialCharacters;

  /// List of valid country codes (e.g., "+1" for the USA, "+91" for India).
  final List<CountryCode>? allowedCountryCodes;

  /// Whether to check the country code in validation.
  final bool checkCountryCode;

  /// Maximum length for the phone number.
  final int maxLength;

  /// Minimum length for the phone number.
  final int minLength;

  /// List of rules to apply for phone number validation.
  final List<PhoneValidationRule> rules;
}

/// Validator class for phone numbers.
class PhoneValidator {
  /// Constructor to initialize the validator with custom options.
  PhoneValidator(this.options);

  final PhoneValidationOptions options;

  /// Validates a phone number based on the provided options.
  String? validate(String phoneNumber) {
    final cleanedPhone = phoneNumber.trim();

    String? validateCountryCode(String phoneNumber) {
      for (var code in options.allowedCountryCodes ?? []) {
        if (phoneNumber.startsWith('+${code.code}')) {
          // Add '+' during validation
          return phoneNumber
              .substring(code.code.length + 1); // Remove country code
        }
      }
      return null; // No valid country code found
    }

    // Validate country code if required.
    String? phoneWithoutCountryCode = cleanedPhone;
    if (options.checkCountryCode) {
      phoneWithoutCountryCode = validateCountryCode(cleanedPhone);
      if (phoneWithoutCountryCode == null) {
        return 'Invalid country code !';
      }
    }

    // Check for minimum length.
    if (options.rules.contains(PhoneValidationRule.checkMinLength)) {
      if (phoneWithoutCountryCode.length < options.minLength) {
        return 'Phone number must be at least ${options.minLength} characters long.';
      }
    }

    // Check for maximum length.
    if (options.rules.contains(PhoneValidationRule.checkMaxLength)) {
      if (phoneWithoutCountryCode.length > options.maxLength) {
        return 'Phone number must not exceed ${options.maxLength} characters.';
      }
    }

    // Prevent special characters.
    if (options.rules.contains(PhoneValidationRule.preventSpecialCharacters) &&
        !options.allowSpecialCharacters) {
      if (RegExp(r'[^\d\+]').hasMatch(phoneWithoutCountryCode)) {
        return 'Phone number must not contain special characters.';
      }
    }

    // Check format (E.164 standard).
    if (options.rules.contains(PhoneValidationRule.checkFormat)) {
      final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
      if (!phoneRegex.hasMatch(cleanedPhone)) {
        return 'Please enter a valid phone number.';
      }
    }

    return null; // All validations passed.
  }
}
