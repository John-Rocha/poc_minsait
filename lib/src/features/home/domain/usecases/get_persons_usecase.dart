import 'package:dartz/dartz.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';
import 'package:poc_minsait/src/features/home/domain/repositories/person_repository.dart';

abstract interface class GetPersonsUsecase {
  Future<Either<Failure, List<PersonEntity>>> call();
}

class GetPersonsUsecaseImpl implements GetPersonsUsecase {
  final PersonRepository _repository;

  GetPersonsUsecaseImpl({required PersonRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<PersonEntity>>> call() {
    return _repository.getPersons();
  }
}
