import 'package:dartz/dartz.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/auth_entity.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthEntity>> signin({
    required String email,
    required String password,
  });
}
