import 'package:poc_minsait/src/features/home/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.cep,
    required super.logradouro,
    required super.number,
    required super.bairro,
    required super.localidade,
    required super.uf,
    super.complemento,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: json['cep'] as String,
      logradouro: json['logradouro'] as String,
      number: json['number'] != null ? json['number'] as String : null,
      complemento:
          json['complemento'] != null ? json['complemento'] as String : null,
      bairro: json['bairro'] as String,
      localidade: json['localidade'] as String,
      uf: json['uf'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'number': number,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
    };
  }
}
