/// Enum representing different rules for phone number validation.
enum PhoneValidationRule {
  /// Checks if the phone number follows a valid format, typically E.164.
  /// This ensures the phone number is valid for international use and avoids
  /// incorrect formats such as multiple "+" symbols or invalid characters.
  checkFormat,

  /// Ensures the phone number meets the minimum length requirement.
  /// This helps avoid phone numbers that are too short to be valid.
  checkMinLength,

  /// Ensures the phone number does not exceed the maximum length.
  /// This helps avoid overly long and potentially invalid phone numbers.
  checkMaxLength,

  /// Disallows special characters in the phone number.
  /// For example, characters such as "-", "(", ")" will be considered invalid
  /// if this rule is applied.
  preventSpecialCharacters,

  /// Ensures the phone number starts with a valid country code.
  /// The country code can be specified in the validation options, and
  /// numbers without the appropriate prefix will be flagged as invalid.
  checkStartsWithCountryCode,
}
