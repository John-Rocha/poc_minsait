import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/home/domain/entities/address_entity.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';
import 'package:poc_minsait/src/features/home/domain/repositories/person_repository.dart';
import 'package:poc_minsait/src/features/home/domain/usecases/get_persons_usecase.dart';

class MockPersonRepository extends Mock implements PersonRepository {}

void main() {
  late GetPersonsUsecase usecase;
  late PersonRepository repository;

  setUp(() {
    repository = MockPersonRepository();
    usecase = GetPersonsUsecaseImpl(repository: repository);
  });

  final personsList = [
    const PersonEntity(
      cpf: '12345678901',
      name: 'John Doe',
      birthDate: '01/01/1990',
      address: AddressEntity(
        cep: '12345-678',
        logradouro: 'Rua A',
        number: '123',
        complemento: '',
        bairro: 'Centro',
        localidade: 'São Paulo',
        uf: 'SP',
      ),
    ),
    const PersonEntity(
      cpf: '98765432100',
      name: 'Jane Doe',
      birthDate: '02/02/1991',
      address: AddressEntity(
        cep: '87654-321',
        logradouro: 'Rua B',
        number: '456',
        complemento: 'Apt 12',
        bairro: 'Bairro B',
        localidade: 'Rio de Janeiro',
        uf: 'RJ',
      ),
    ),
  ];

  test(
      'should return a list of persons when the call to repository is successful',
      () async {
    // Arrange
    when(() => repository.getPersons()).thenAnswer(
      (_) async => Right(personsList),
    );

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(personsList));
    verify(() => repository.getPersons()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Failure when the call to repository fails', () async {
    // Arrange
    final failure = Failure(message: 'Error fetching persons');
    when(() => repository.getPersons()).thenAnswer(
      (_) async => Left(failure),
    );

    // Act
    final result = await usecase();

    // Assert
    expect(result, Left(failure));
    verify(() => repository.getPersons()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
