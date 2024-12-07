class EmailValidationOptions {
  /// Constructor to set default validation options
  EmailValidationOptions({
    this.checkFormat = true,
    this.preventConsecutiveDots = true,
    this.preventMultipleAtSymbols = true,
    this.checkCommonMistakes = true,
    this.preventDisposableEmails = true,
    this.checkEndsWithDot = true,
    this.minLength = 5,
  });

  /// Whether to check for common mistakes in the email, such as ".con" instead of ".com".
  final bool checkCommonMistakes;

  /// Whether to ensure the email does not end with a dot.
  final bool checkEndsWithDot;

  /// Whether to validate the email format against a standard email regex pattern.
  final bool checkFormat;

  /// Minimum length required for the email address. Default is 5 characters.
  final int minLength;

  /// Whether to prevent consecutive dots in the email address.
  /// For example, "user..name@example.com" will be considered invalid if this is true.
  final bool preventConsecutiveDots;

  /// Whether to block disposable email domains such as "mailinator.com" or "10minutemail.com".
  final bool preventDisposableEmails;

  /// Whether to prevent multiple '@' symbols in the email address.
  /// For example, "user@@example.com" will be considered invalid if this is true.
  final bool preventMultipleAtSymbols;
}

class EmailValidator {
  EmailValidator({required this.options});

  final EmailValidationOptions options;

  /// Validates the email based on user-specified options
  String? validate(String email) {
    if (email.trim().isEmpty) {
      return 'Email address cannot be empty !';
    }

    // Check minimum length
    if (email.length < options.minLength) {
      return 'Email address must be at least ${options.minLength} characters long !';
    }

    // if (options.checkFormat) {
    //   final emailRegex = RegExp(
    //       r'^(?!.*\.\.)(?!.*\.$)(?!.*\@.*\@)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    //   if (!emailRegex.hasMatch(email)) {
    //     return 'Please enter a valid email address';
    //   }
    // }

// Separate checks for consecutive dots and trailing dots
    if (options.preventConsecutiveDots && email.contains('..')) {
      return 'Email address cannot contain consecutive dots !';
    }

    if (options.checkEndsWithDot && email.endsWith('.')) {
      return 'Email address cannot end with a dot !';
    }

    // Prevent multiple "@" symbols
    if (options.preventMultipleAtSymbols && email.split('@').length - 1 > 1) {
      return 'Email address cannot contain multiple "@" symbols !';
    }

    // Check for common mistakes
    if (options.checkCommonMistakes) {
      final commonMistakes = {
        '.con': '.com',
        '.cim': '.com',
        '.comm': '.com',
        '@gnail.com': '@gmail.com',
        '@gamil.com': '@gmail.com',
        '@yaho.com': '@yahoo.com',
        '@outlok.com': '@outlook.com',
        '@hotmial.com': '@hotmail.com',
      };

      for (var mistake in commonMistakes.entries) {
        if (email.endsWith(mistake.key)) {
          return 'Did you mean "${email.replaceFirst(mistake.key, mistake.value)}" ?';
        }
      }
    }

    // Prevent disposable email domains
    if (options.preventDisposableEmails) {
      final disposableDomains = [
        'tempmail.com',
        '10minutemail.com',
        'mailinator.com',
        'yopmail.com',
        'guerrillamail.com',
      ];

      final emailDomain = email.split('@').last;
      if (disposableDomains.contains(emailDomain)) {
        return 'Disposable email addresses are not allowed !';
      }
    }
    // Check email format
    if (options.checkFormat) {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(email)) {
        return 'Please enter a valid email address !';
      }
    }
    // If all checks pass
    return null;
  }
}
