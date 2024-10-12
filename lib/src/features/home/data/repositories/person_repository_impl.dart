import 'package:dartz/dartz.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/home/data/datasources/person_datasource.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';
import 'package:poc_minsait/src/features/home/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonDatasource _personDatasource;

  PersonRepositoryImpl({required PersonDatasource personDatasource})
      : _personDatasource = personDatasource;

  @override
  Future<Either<Failure, PersonEntity>> createPerson({
    required PersonEntity person,
  }) async {
    try {
      final result = await _personDatasource.createPerson(person: person);

      return Right(result);
    } on Failure catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
