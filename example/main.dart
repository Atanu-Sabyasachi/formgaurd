import 'package:flutter/material.dart';
import 'package:formgaurd/utils/enums/country_code_enum.dart';
import 'package:formgaurd/utils/enums/password_strength_enum.dart';
import 'package:formgaurd/utils/enums/phone_validation_rules_enum.dart';
import 'package:formgaurd/validators/email_validator.dart';
import 'package:formgaurd/validators/password_validator.dart';
import 'package:formgaurd/validators/phone_number_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FormGuard Example')),
        body: const MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Email Validation
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                EmailValidationOptions options = EmailValidationOptions(
                  checkFormat: true,
                  preventConsecutiveDots: true,
                  preventMultipleAtSymbols: true,
                  checkCommonMistakes: true,
                  preventDisposableEmails: true,
                  checkEndsWithDot: true,
                  minLength: 6,
                );

                EmailValidator validator = EmailValidator(options: options);
                String? result = validator.validate(value ?? '');
                return result;
              },
            ),
            const SizedBox(height: 16),

            // Phone Number Validation
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                PhoneValidationOptions options = const PhoneValidationOptions(
                  rules: [
                    PhoneValidationRule.checkFormat,
                    PhoneValidationRule.checkMinLength,
                    PhoneValidationRule.checkStartsWithCountryCode,
                    PhoneValidationRule.checkMaxLength,
                    PhoneValidationRule.preventSpecialCharacters,
                  ],
                  minLength: 10,
                  maxLength: 15,
                  allowedCountryCodes: [
                    CountryCode.India,
                    CountryCode.UnitedStates,
                    CountryCode.Bermuda,
                  ],
                  allowSpecialCharacters: false,
                  checkCountryCode: true,
                );

                PhoneValidator phoneValidator = PhoneValidator(options);
                String? result = phoneValidator.validate(value ?? '');
                return result;
              },
            ),
            const SizedBox(height: 16),

            // Password Validation
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              validator: (value) {
                PasswordValidator strongValidator =
                    PasswordValidator().setStrength(PasswordStrength.strong);

                String? result = strongValidator.validate(value ?? '');
                return result;
              },
            ),
            const SizedBox(height: 16),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form is valid!')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
