import 'package:dartz/dartz.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/auth/data/datasource/auth_datesource.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/user_entity.dart';

import 'package:poc_minsait/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatesource _authDatesource;

  AuthRepositoryImpl({required AuthDatesource authDatesource})
      : _authDatesource = authDatesource;

  @override
  Future<Either<Failure, UserEntity>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authDatesource.signup(
        name: name,
        email: email,
        password: password,
      );
      return Right(user);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
