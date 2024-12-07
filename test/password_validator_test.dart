import 'package:flutter_test/flutter_test.dart';
import 'package:formgaurd/validators/password_validator.dart';
import 'package:formgaurd/utils/enums/password_strength_enum.dart'; // Replace with the correct path

void main() {
  group('PasswordValidator', () {
    late PasswordValidator passwordValidator;

    setUp(() {
      passwordValidator = PasswordValidator();
    });

    test('Validates weak password strength', () {
      passwordValidator.setStrength(PasswordStrength.weak);
      final result = passwordValidator.validate('shortpw');
      expect(result, null); // Weak passwords are valid as long as length >= 6
    });

    test('Fails for password shorter than 6 characters with weak strength', () {
      passwordValidator.setStrength(PasswordStrength.weak);
      final result = passwordValidator.validate('abc');
      expect(result, 'Password must be at least 6 characters long');
    });

    test('Validates medium password strength', () {
      passwordValidator.setStrength(PasswordStrength.medium);
      final result = passwordValidator.validate('pmedium8');
      expect(result, null); // Medium strength requires a digit and length >= 8
    });

    test('Fails for medium strength without a digit', () {
      passwordValidator.setStrength(PasswordStrength.medium);
      final result = passwordValidator.validate('mediumpw');
      expect(result, 'Password must contain at least one digit');
    });

    test('Fails for medium strength with less than 8 characters', () {
      passwordValidator.setStrength(PasswordStrength.medium);
      final result = passwordValidator.validate('short7');
      expect(result, 'Password must be at least 8 characters long');
    });

    test('Validates strong password strength', () {
      passwordValidator.setStrength(PasswordStrength.strong);
      final result = passwordValidator.validate('Str0ng@Password!');
      expect(result,
          null); // Strong strength requires length >= 12, digit, uppercase, lowercase, and symbol
    });

    test('Fails for strong strength without a digit', () {
      passwordValidator.setStrength(PasswordStrength.strong);
      final result = passwordValidator.validate('Strong@Password!');
      expect(result, 'Password must contain at least one digit');
    });

    test('Fails for strong strength without an uppercase letter', () {
      passwordValidator.setStrength(PasswordStrength.strong);
      final result = passwordValidator.validate('weak0@password!');
      expect(result, 'Password must contain at least one uppercase letter');
    });

    test('Fails for strong strength without a lowercase letter', () {
      passwordValidator.setStrength(PasswordStrength.strong);
      final result = passwordValidator.validate('STRONG0@PASSWORD!');
      expect(result, 'Password must contain at least one lowercase letter');
    });

    test('Fails for strong strength without a symbol', () {
      passwordValidator.setStrength(PasswordStrength.strong);
      final result = passwordValidator.validate('Strong0Password');
      expect(result, 'Password must contain at least one symbol');
    });

    test('Fails for strong strength with less than 12 characters', () {
      passwordValidator.setStrength(PasswordStrength.strong);
      final result = passwordValidator.validate('Short0@!');
      expect(result, 'Password must be at least 12 characters long');
    });

    test('Validates custom rule: require symbol and digit only', () {
      passwordValidator.custom(requireSymbol: true, requireDigit: true);
      final result = passwordValidator.validate('password1!');
      expect(result, null);
    });

    test('Fails custom rule without required symbol', () {
      passwordValidator.custom(requireSymbol: true);
      final result = passwordValidator.validate('password1');
      expect(result, 'Password must contain at least one symbol');
    });

    test('Fails custom rule without required digit', () {
      passwordValidator.custom(requireDigit: true);
      final result = passwordValidator.validate('password!');
      expect(result, 'Password must contain at least one digit');
    });

    test('Passes custom rule with no restrictions', () {
      passwordValidator.custom();
      final result = passwordValidator.validate('anypassword');
      expect(result, null); // No restrictions applied
    });

    test('Validates custom rule with a custom minimum length', () {
      passwordValidator.custom(minLength: 10);
      final result = passwordValidator.validate('longenough1');
      expect(result, null);
    });

    test('Fails custom rule for short password with custom minimum length', () {
      passwordValidator.custom(minLength: 10);
      final result = passwordValidator.validate('short1');
      expect(result, 'Password must be at least 10 characters long');
    });
  });
}
