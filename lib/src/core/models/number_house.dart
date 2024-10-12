import 'package:formz/formz.dart';

enum NumberHouseValidatorError {
  invalid,
}

class NumberHouse extends FormzInput<String, NumberHouseValidatorError> {
  const NumberHouse.pure() : super.pure('');
  const NumberHouse.dirty([super.value = '']) : super.dirty();

  @override
  NumberHouseValidatorError? validator(String value) {
    if (value.isEmpty) {
      return NumberHouseValidatorError.invalid;
    }
    return null;
  }
}
