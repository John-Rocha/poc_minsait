import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/user_entity.dart';
import 'package:poc_minsait/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:poc_minsait/src/features/auth/domain/usecases/signup_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignupUsecase usecase;
  late AuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignupUsecaseImpl(repository: repository);
  });

  const userMock = UserEntity(
    id: 1,
    name: 'John Doe',
    email: 'john.doe@example.com',
    password: 'password123',
  );

  const name = 'John Doe';
  const email = 'john.doe@example.com';
  const password = 'password123';

  test('should return UserEntity when signup is successful', () async {
    when(
      () => repository.signup(
        name: any(named: 'name'),
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(userMock));

    final result =
        await usecase.call(name: name, email: email, password: password);

    expect(result, const Right(userMock));
    verify(
      () => repository.signup(
        name: name,
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Failure when signup fails', () async {
    final failure = Failure(message: 'Signup failed');
    when(
      () => repository.signup(
        name: any(named: 'name'),
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => Left(failure));

    final result =
        await usecase.call(name: name, email: email, password: password);

    expect(result, Left(failure));
    verify(
      () => repository.signup(
        name: name,
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
