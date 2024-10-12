import 'package:dartz/dartz.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';

abstract interface class PersonRepository {
  Future<Either<Failure, PersonEntity>> createPerson({
    required PersonEntity person,
  });

  Future<Either<Failure, List<PersonEntity>>> getPersons();
}
