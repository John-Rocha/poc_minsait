import 'package:formz/formz.dart';

enum DocumentValidatorError {
  empty,
  invalid,
}

class Document extends FormzInput<String, DocumentValidatorError> {
  const Document.pure() : super.pure('');
  const Document.dirty([super.value = '']) : super.dirty();

  @override
  DocumentValidatorError? validator(String value) {
    if (value.isEmpty) {
      return DocumentValidatorError.empty;
    } else if (!RegExp(r'^[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}$')
        .hasMatch(value)) {
      return DocumentValidatorError.invalid;
    }
    return null;
  }
}
