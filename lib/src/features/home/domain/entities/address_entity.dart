import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String cep;
  final String logradouro;
  final String number;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;

  const AddressEntity({
    required this.cep,
    required this.logradouro,
    required this.number,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  @override
  List<Object> get props => [
        cep,
        logradouro,
        number,
        complemento,
        bairro,
        localidade,
        uf,
      ];
}
