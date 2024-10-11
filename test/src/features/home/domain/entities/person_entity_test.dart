import 'package:flutter_test/flutter_test.dart';
import 'package:poc_minsait/src/features/home/domain/entities/address_entity.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';

void main() {
  const address = AddressEntity(
    cep: '12345-678',
    logradouro: 'Rua Principal',
    number: '100',
    complemento: 'Apto 202',
    bairro: 'Centro',
    localidade: 'Cidade Exemplo',
    uf: 'EX',
  );

  const person1 = PersonEntity(
    cpf: '12345678900',
    name: 'John Doe',
    birthDate: '1990-01-01',
    address: address,
  );

  const person2 = PersonEntity(
    cpf: '12345678900',
    name: 'John Doe',
    birthDate: '1990-01-01',
    address: address,
  );

  const person3 = PersonEntity(
    cpf: '98765432100',
    name: 'Jane Doe',
    birthDate: '1985-05-05',
    address: address,
  );

  group('PersonEntity tests', () {
    test('should correctly expose properties', () {
      expect(person1.cpf, '12345678900');
      expect(person1.name, 'John Doe');
      expect(person1.birthDate, '1990-01-01');
      expect(person1.address, address);
    });

    test('should return true when two PersonEntities have the same properties',
        () {
      expect(person1, equals(person2));
    });

    test(
        'should return false when two PersonEntities have different properties',
        () {
      expect(person1 == person3, false);
    });

    test('props should return a list of properties', () {
      expect(person1.props, ['12345678900', 'John Doe', '1990-01-01', address]);
    });
  });
}
