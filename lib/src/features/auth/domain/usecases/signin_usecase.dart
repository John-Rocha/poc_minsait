import 'package:dartz/dartz.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/auth_entity.dart';
import 'package:poc_minsait/src/features/auth/domain/repositories/auth_repository.dart';

abstract interface class SigninUsecase {
  Future<Either<Failure, AuthEntity>> call({
    required String email,
    required String password,
  });
}

class SigninUsecaseImpl implements SigninUsecase {
  final AuthRepository _repository;

  SigninUsecaseImpl({required AuthRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, AuthEntity>> call({
    required String email,
    required String password,
  }) {
    return _repository.signin(
      email: email,
      password: password,
    );
  }
}
