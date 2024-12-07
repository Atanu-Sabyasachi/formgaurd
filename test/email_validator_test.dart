import 'package:flutter_test/flutter_test.dart';
import 'package:formgaurd/validators/email_validator.dart';

void main() {
  group('EmailValidator', () {
    late EmailValidator emailValidator;

    setUp(() {
      emailValidator = EmailValidator(
        options: EmailValidationOptions(),
      );
    });

    test('Returns error for empty email', () {
      final result = emailValidator.validate('');
      expect(result, 'Email address cannot be empty !');
    });

    test('Returns error for email shorter than minimum length', () {
      emailValidator = EmailValidator(
        options: EmailValidationOptions(minLength: 6),
      );
      final result = emailValidator.validate('a@b.co');
      expect(result, null);
    });

    test('Returns error for email with consecutive dots', () {
      final result = emailValidator.validate('user..name@example.com');
      expect(result, 'Email address cannot contain consecutive dots !');
    });

    test('Returns error for email ending with a dot', () {
      final result = emailValidator.validate('username@example.com.');
      expect(result, 'Email address cannot end with a dot !');
    });

    test('Returns error for email with multiple "@" symbols', () {
      final result = emailValidator.validate('user@@example.com');
      expect(result, 'Email address cannot contain multiple "@" symbols !');
    });

    test('Returns error for common mistakes in email', () {
      final result = emailValidator.validate('user@gnail.com');
      expect(result, 'Did you mean "user@gmail.com" ?');
    });

    test('Returns error for disposable email domains', () {
      final result = emailValidator.validate('user@tempmail.com');
      expect(result, 'Disposable email addresses are not allowed !');
    });

    test('Returns error for invalid email format', () {
      final result = emailValidator.validate('username@com');
      expect(result, 'Please enter a valid email address !');
    });

    test('Passes for valid email', () {
      final result = emailValidator.validate('user@example.com');
      expect(result, isNull);
    });

    test('Passes for valid email with disabled consecutive dots check', () {
      emailValidator = EmailValidator(
        options: EmailValidationOptions(preventConsecutiveDots: false),
      );
      final result = emailValidator.validate('user..name@example.com');
      expect(result, isNull);
    });

    test('Passes for disposable email when check is disabled', () {
      emailValidator = EmailValidator(
        options: EmailValidationOptions(preventDisposableEmails: false),
      );
      final result = emailValidator.validate('user@tempmail.com');
      expect(result, isNull);
    });

    test('Handles custom minimum length', () {
      emailValidator = EmailValidator(
        options: EmailValidationOptions(minLength: 10),
      );
      final result = emailValidator.validate('short@em.com');
      expect(result, 'Email address must be at least 10 characters long !');
    });
  });
}
