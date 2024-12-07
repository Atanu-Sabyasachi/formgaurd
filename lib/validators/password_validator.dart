import 'package:formgaurd/utils/enums/password_strength_enum.dart';

class PasswordValidator {
  PasswordValidator();

  int minLength = 8;
  bool requireDigit = false;
  bool requireLowercase = false;
  bool requireSymbol = false;
  bool requireUppercase = false;

  /// Sets the strength of the password using the PasswordStrength
  PasswordValidator setStrength(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        minLength = 6;
        break;
      case PasswordStrength.medium:
        requireDigit = true;
        minLength = 8;
        break;
      case PasswordStrength.strong:
        requireDigit = true;
        requireUppercase = true;
        requireLowercase = true;
        requireSymbol = true;
        minLength = 12;
        break;
    }
    return this;
  }

  /// Allows custom validation rules for digits, symbols, etc.
  PasswordValidator custom({
    bool? requireDigit,
    bool? requireUppercase,
    bool? requireLowercase,
    bool? requireSymbol,
    int? minLength,
  }) {
    this.requireDigit = requireDigit ?? this.requireDigit;
    this.requireUppercase = requireUppercase ?? this.requireUppercase;
    this.requireLowercase = requireLowercase ?? this.requireLowercase;
    this.requireSymbol = requireSymbol ?? this.requireSymbol;
    this.minLength = minLength ?? this.minLength;
    return this;
  }

  /// Validates the password based on the configured rules.
  String? validate(String password) {
    if (password.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    if (requireDigit && !RegExp(r'\d').hasMatch(password)) {
      return 'Password must contain at least one digit';
    }
    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (requireLowercase && !RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (requireSymbol &&
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one symbol';
    }
    return null;
  }
}
