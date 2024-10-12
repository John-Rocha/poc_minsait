import 'package:poc_minsait/src/features/home/data/models/address_model.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required super.cpf,
    required super.name,
    required super.birthDate,
    required super.address,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      cpf: json['document'],
      name: json['fullName'],
      birthDate: json['birthDate'],
      address: AddressModel.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document': cpf,
      'fullName': name,
      'birthDate': birthDate,
      'address': (address as AddressModel).toJson(),
    };
  }
}
