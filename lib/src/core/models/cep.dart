import 'package:formz/formz.dart';

enum CepValidatorError {
  invalid,
  empty,
}

class Cep extends FormzInput<String, CepValidatorError> {
  const Cep.pure() : super.pure('');
  const Cep.dirty([super.value = '']) : super.dirty();

  @override
  CepValidatorError? validator(String value) {
    if (value.isEmpty) {
      return CepValidatorError.empty;
    } else if (value.length != 9) {
      return CepValidatorError.invalid;
    }
    return null;
  }
}
