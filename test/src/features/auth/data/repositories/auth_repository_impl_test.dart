import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_minsait/src/core/device/app_storage.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/auth/data/datasource/auth_datesource.dart';
import 'package:poc_minsait/src/features/auth/data/models/auth_model.dart';
import 'package:poc_minsait/src/features/auth/data/models/user_model.dart';
import 'package:poc_minsait/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:poc_minsait/src/features/auth/domain/repositories/auth_repository.dart';

class MockAuthDatesource extends Mock implements AuthDatesource {}

class MockAppSecureStorage extends Mock implements AppSecureStorage {}

void main() {
  late AuthRepository repository;
  late AuthDatesource datasource;
  late AppSecureStorage appSecureStorage;

  setUp(() {
    datasource = MockAuthDatesource();
    appSecureStorage = MockAppSecureStorage();
    repository = AuthRepositoryImpl(
      authDatesource: datasource,
      appSecureStorage: appSecureStorage,
    );
  });

  const userModel = UserModel(
    id: 1,
    name: 'John Doe',
    email: 'john.doe@example.com',
    password: 'password123',
  );

  const authModel = AuthModel(
    accessToken: 'access_token',
    refreshToken: 'refresh_token',
  );

  const name = 'John Doe';
  const email = 'john.doe@example.com';
  const password = 'password123';

  group('Signup tests', () {
    test('should return UserEntity when the signup is successful', () async {
      when(
        () => datasource.signup(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userModel);

      final result = await repository.signup(
        name: name,
        email: email,
        password: password,
      );

      expect(result, const Right(userModel));
      verify(
        () => datasource.signup(
          name: name,
          email: email,
          password: password,
        ),
      ).called(1);
    });

    test('should return Failure when the signup fails', () async {
      final failure = Failure(message: 'Signup failed');
      when(
        () => datasource.signup(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(failure);

      final result = await repository.signup(
        name: name,
        email: email,
        password: password,
      );

      expect(result, Left(failure));
      verify(
        () => datasource.signup(
          name: name,
          email: email,
          password: password,
        ),
      ).called(1);
    });
  });

  group('Signin tests', () {
    test(
        'should return AuthEntity and store session token when signin is successful',
        () async {
      when(
        () => datasource.signin(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => authModel);

      when(
        () => appSecureStorage.setSessionToken(any()),
      ).thenAnswer((_) async => true);

      final result = await repository.signin(
        email: email,
        password: password,
      );

      expect(result, const Right(authModel));
      verify(
        () => datasource.signin(
          email: email,
          password: password,
        ),
      ).called(1);
      verify(
        () => appSecureStorage.setSessionToken(authModel.accessToken),
      ).called(1);
    });

    test('should return Failure when the signin fails', () async {
      final failure = Failure(message: 'Signin failed');
      when(
        () => datasource.signin(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(failure);

      final result = await repository.signin(
        email: email,
        password: password,
      );

      expect(result, Left(failure));
      verify(
        () => datasource.signin(
          email: email,
          password: password,
        ),
      ).called(1);
      verifyNever(() => appSecureStorage.setSessionToken(any()));
    });
  });
}
