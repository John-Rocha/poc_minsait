part of 'form_page_cubit.dart';

class FormPageState extends Equatable {
  const FormPageState({
    required this.document,
    required this.fullName,
    required this.birthDate,
    required this.cep,
    required this.logradouro,
    required this.number,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.isLoading,
    required this.isSaved,
    this.complemento,
    this.errorMessage,
  });

  final Document document;
  final FullName fullName;
  final BirthDate birthDate;

  final Cep cep;
  final String logradouro;
  final NumberHouse number;
  final String? complemento;
  final String bairro;
  final String localidade;
  final String uf;

  final bool isLoading;
  final String? errorMessage;

  final bool isSaved;

  const FormPageState.initial()
      : document = const Document.pure(),
        fullName = const FullName.pure(),
        birthDate = const BirthDate.pure(),
        cep = const Cep.pure(),
        logradouro = '',
        number = const NumberHouse.pure(),
        complemento = '',
        bairro = '',
        localidade = '',
        uf = '',
        isLoading = false,
        errorMessage = null,
        isSaved = false;

  bool get isFormValid =>
      Formz.validate([
        document,
        fullName,
        birthDate,
        cep,
        number,
      ]) &&
      logradouro.isNotEmpty &&
      bairro.isNotEmpty &&
      localidade.isNotEmpty &&
      uf.isNotEmpty;

  FormPageState copyWith({
    Document? document,
    FullName? fullName,
    BirthDate? birthDate,
    Cep? cep,
    String? logradouro,
    NumberHouse? number,
    String? complemento,
    String? bairro,
    String? localidade,
    String? uf,
    bool? isLoading,
    String? errorMessage,
    bool? isSaved,
  }) {
    return FormPageState(
      document: document ?? this.document,
      fullName: fullName ?? this.fullName,
      birthDate: birthDate ?? this.birthDate,
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      number: number ?? this.number,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      localidade: localidade ?? this.localidade,
      uf: uf ?? this.uf,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [
        document,
        fullName,
        birthDate,
        cep,
        logradouro,
        number,
        complemento,
        bairro,
        localidade,
        uf,
        isLoading,
        errorMessage,
        isSaved,
      ];
}
