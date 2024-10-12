import 'package:flutter_test/flutter_test.dart';
import 'package:poc_minsait/src/features/home/domain/entities/address_entity.dart';

void main() {
  const address1 = AddressEntity(
    cep: '12345-678',
    logradouro: 'Rua Principal',
    number: '100',
    complemento: 'Apto 202',
    bairro: 'Centro',
    localidade: 'Cidade Exemplo',
    uf: 'EX',
  );

  const address2 = AddressEntity(
    cep: '12345-678',
    logradouro: 'Rua Principal',
    number: '100',
    complemento: 'Apto 202',
    bairro: 'Centro',
    localidade: 'Cidade Exemplo',
    uf: 'EX',
  );

  const address3 = AddressEntity(
    cep: '98765-432',
    logradouro: 'Avenida Secundária',
    number: '200',
    complemento: '',
    bairro: 'Bairro Novo',
    localidade: 'Outra Cidade',
    uf: 'OC',
  );

  group('AddressEntity tests', () {
    test('should correctly expose properties', () {
      expect(address1.cep, '12345-678');
      expect(address1.logradouro, 'Rua Principal');
      expect(address1.number, '100');
      expect(address1.complemento, 'Apto 202');
      expect(address1.bairro, 'Centro');
      expect(address1.localidade, 'Cidade Exemplo');
      expect(address1.uf, 'EX');
    });

    test('should return true when two AddressEntities have the same properties',
        () {
      expect(address1, equals(address2));
    });

    test(
        'should return false when two AddressEntities have different properties',
        () {
      expect(address1 == address3, false);
    });

    test('props should return a list of properties', () {
      expect(
        address1.props,
        [
          '12345-678',
          'Rua Principal',
          '100',
          'Apto 202',
          'Centro',
          'Cidade Exemplo',
          'EX',
        ],
      );
    });
  });
}
