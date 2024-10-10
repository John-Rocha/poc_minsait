import 'package:dartz/dartz.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/user_entity.dart';
import 'package:poc_minsait/src/features/auth/domain/repositories/auth_repository.dart';

abstract interface class SignupUsecase {
  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
    required String password,
  });
}

class SignupUsecaseImpl implements SignupUsecase {
  final AuthRepository _repository;

  SignupUsecaseImpl({required AuthRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.signup(
      name: name,
      email: email,
      password: password,
    );
  }
}
