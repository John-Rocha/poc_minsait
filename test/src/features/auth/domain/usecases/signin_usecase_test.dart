import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/auth_entity.dart';
import 'package:poc_minsait/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:poc_minsait/src/features/auth/domain/usecases/signin_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SigninUsecase usecase;
  late AuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    usecase = SigninUsecaseImpl(repository: repository);
  });

  const email = 'test@example.com';
  const password = 'password123';
  const authEntity = AuthEntity(
    accessToken: 'access_token_123',
    refreshToken: 'refresh_token_123',
  );

  test('should return AuthEntity when the signin is successful', () async {
    when(
      () => repository.signin(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(authEntity));

    final result = await usecase.call(email: email, password: password);

    expect(result, const Right(authEntity));
    verify(
      () => repository.signin(
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Failure when the signin fails', () async {
    final failure = Failure(message: 'Erro de autenticação');
    when(
      () => repository.signin(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => Left(failure));

    final result = await usecase.call(email: email, password: password);

    expect(result, Left(failure));
    verify(
      () => repository.signin(
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
