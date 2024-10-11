import 'package:dartz/dartz.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';
import 'package:poc_minsait/src/features/home/domain/repositories/person_repository.dart';

abstract interface class CreatePersonUsecase {
  Future<Either<Failure, PersonEntity>> call({required PersonEntity person});
}

class CreatePersonUsecaseImpl implements CreatePersonUsecase {
  final PersonRepository _personRepository;

  CreatePersonUsecaseImpl({required PersonRepository personRepository})
      : _personRepository = personRepository;

  @override
  Future<Either<Failure, PersonEntity>> call({
    required PersonEntity person,
  }) {
    return _personRepository.createPerson(person: person);
  }
}
