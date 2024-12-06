import 'dart:developer';

import 'package:formgaurd/formgaurd.dart';

void main() {
  // Example usage
  var nameValidation = FormGuard.validateString('John Doe');
  log(nameValidation.message); // Valid input

  var numberValidation = FormGuard.validateNumber('123.45');
  log(numberValidation.message); // Valid number

  var dateValidation = FormGuard.validateDate('2024-12-06');
  log(dateValidation.message); // Valid date
}
