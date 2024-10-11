import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/home/domain/entities/address_entity.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';
import 'package:poc_minsait/src/features/home/domain/repositories/person_repository.dart';
import 'package:poc_minsait/src/features/home/domain/usecases/create_person_usecase.dart';

class MockPersonRepository extends Mock implements PersonRepository {}

void main() {
  late CreatePersonUsecase usecase;
  late PersonRepository mockPersonRepository;

  setUp(() {
    mockPersonRepository = MockPersonRepository();
    usecase = CreatePersonUsecaseImpl(personRepository: mockPersonRepository);
  });

  const person = PersonEntity(
    cpf: '12345678900',
    name: 'John Doe',
    birthDate: '1990-01-01',
    address: AddressEntity(
      cep: '12345-678',
      logradouro: 'Rua Principal',
      number: '100',
      complemento: 'Apto 202',
      bairro: 'Centro',
      localidade: 'Cidade Exemplo',
      uf: 'EX',
    ),
  );

  group('CreatePersonUsecase', () {
    test('should return PersonEntity when creation is successful', () async {
      when(
        () => mockPersonRepository.createPerson(person: person),
      ).thenAnswer((_) async => const Right(person));

      final result = await usecase.call(person: person);

      expect(result, const Right(person));
      verify(() => mockPersonRepository.createPerson(person: person)).called(1);
      verifyNoMoreInteractions(mockPersonRepository);
    });

    test('should return Failure when creation fails', () async {
      final failure = Failure(message: 'Creation failed');
      when(
        () => mockPersonRepository.createPerson(person: person),
      ).thenAnswer((_) async => Left(failure));

      final result = await usecase.call(person: person);

      expect(result, Left(failure));
      verify(() => mockPersonRepository.createPerson(person: person)).called(1);
      verifyNoMoreInteractions(mockPersonRepository);
    });
  });
}
