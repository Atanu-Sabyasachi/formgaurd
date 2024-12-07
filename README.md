# FormGuard

**FormGuard** is a powerful, flexible, and customizable validation library for Flutter that helps developers validate common input fields such as email, phone numbers, and passwords with ease. 

## Features

1. **Email Validation**:

    The EmailValidator is designed to validate email addresses based on customizable rules. It ensures proper formatting, prevents common mistakes, and optionally blocks disposable email addresses.   
```dart
import 'package:formgaurd/validators/email_validator.dart';

void main() {
// Configure validation options
EmailValidationOptions options = EmailValidationOptions(
    checkFormat: true,
    preventConsecutiveDots: true,
    preventMultipleAtSymbols: true,
    checkCommonMistakes: true,
    preventDisposableEmails: true,
    checkEndsWithDot: true,
    minLength: 6,
);

// Create an EmailValidator instance
EmailValidator validator = EmailValidator(options: options);

// Example email inputs
String email1 = "test@example.com";
String email2 = "invalid..email@@example.com";

// Validate the emails
print(validator.validate(email1)); // Output: null (valid email)
print(validator.validate(email2)); // Output: Error message (invalid email)
}
```

   **Explanation**:
- Valid Email (email1): Meets all validation rules.
- Invalid Email (email2): Fails due to consecutive dots and multiple @ symbols.
- The validate method returns null for valid inputs or an error message for invalid ones.


2. **Phone Number Validation**:

    The PhoneValidator helps validate phone numbers for specific countries, enforces minimum and maximum lengths, and optionally prevents special characters.
```dart
import 'package:formgaurd/validators/phone_number_validator.dart';
import 'package:formgaurd/enums.dart';

void main() {
// Configure validation options
PhoneValidationOptions options = PhoneValidationOptions(
    rules: [
    PhoneValidationRule.checkFormat,
    PhoneValidationRule.checkMinLength,
    PhoneValidationRule.checkMaxLength,
    PhoneValidationRule.checkStartsWithCountryCode,
    ],
    minLength: 10,
    maxLength: 15,
    allowedCountryCodes: [
    CountryCode.India,
    CountryCode.UnitedStates,
    ],
    checkCountryCode: true,
);

// Create a PhoneValidator instance
PhoneValidator validator = PhoneValidator(options);

// Example phone numbers
String phone1 = "+919876543210"; // Valid phone number
String phone2 = "12345";         // Invalid phone number (too short)

// Validate the phone numbers
print(validator.validate(phone1)); // Output: null (valid phone number)
print(validator.validate(phone2)); // Output: Error message (invalid phone number)
}
```

   **Explanation**
- Valid Phone (phone1): Starts with the country code and meets length rules.
- Invalid Phone (phone2): Too short to be a valid phone number.
- The validate method checks the number against the configured rules.


3. **Password Validation**:

    The PasswordValidator ensures that passwords meet strength requirements. You can set the strength to Weak, Medium, or Strong based on your application's needs.
    ```dart
    import 'package:formgaurd/validators/password_validator.dart';
    import 'package:formgaurd/enums.dart';

    void main() {
    // Create a PasswordValidator instance
    PasswordValidator validator = PasswordValidator()
        .setStrength(PasswordStrength.strong);

    // Example passwords
    String password1 = "P@ssw0rd123"; // Strong password
    String password2 = "12345";       // Weak password

    // Validate the passwords
    print(validator.validate(password1)); // Output: null (valid password)
    print(validator.validate(password2)); // Output: Error message (invalid password)
    }
    ```

  **Explanation**
- Strong Password (password1): Includes uppercase, lowercase, digits, and symbols.
- Weak Password (password2): Lacks complexity and strength.
- The validate method checks the password against the set rules.

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  formgaurd: <latest_version>
```