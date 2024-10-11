import 'package:equatable/equatable.dart';
import 'package:poc_minsait/src/features/home/domain/entities/address_entity.dart';

class PersonEntity extends Equatable {
  final String cpf;
  final String name;
  final String birthDate;
  final AddressEntity address;

  const PersonEntity({
    required this.cpf,
    required this.name,
    required this.birthDate,
    required this.address,
  });

  @override
  List<Object> get props => [
        cpf,
        name,
        birthDate,
        address,
      ];
}
