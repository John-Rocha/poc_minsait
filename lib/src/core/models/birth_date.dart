import 'package:formz/formz.dart';

enum BirthDateValidatorError { empty, invalid }

class BirthDate extends FormzInput<String, BirthDateValidatorError> {
  const BirthDate.pure() : super.pure('');
  const BirthDate.dirty([super.value = '']) : super.dirty();

  @override
  BirthDateValidatorError? validator(String value) {
    if (value.isEmpty) {
      return BirthDateValidatorError.empty;
    } else if (!RegExp(r'^[0-9]{2}/[0-9]{2}/[0-9]{4}$').hasMatch(value)) {
      return BirthDateValidatorError.invalid;
    }
    return null;
  }
}
