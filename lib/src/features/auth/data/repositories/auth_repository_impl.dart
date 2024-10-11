import 'package:dartz/dartz.dart';
import 'package:poc_minsait/src/core/device/app_storage.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/auth/data/datasource/auth_datesource.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/auth_entity.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/user_entity.dart';

import 'package:poc_minsait/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatesource _authDatesource;
  final AppSecureStorage _appSecureStorage;

  AuthRepositoryImpl({
    required AuthDatesource authDatesource,
    required AppSecureStorage appSecureStorage,
  })  : _authDatesource = authDatesource,
        _appSecureStorage = appSecureStorage;

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

  @override
  Future<Either<Failure, AuthEntity>> signin({
    required String email,
    required String password,
  }) async {
    try {
      final authData = await _authDatesource.signin(
        email: email,
        password: password,
      );
      await _appSecureStorage.setSessionToken(authData.accessToken);
      return Right(authData);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
