import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/auth/data/datasource/auth_datesource.dart';
import 'package:poc_minsait/src/features/auth/data/models/user_model.dart';

class MockRestClient extends Mock implements Dio {}

void main() {
  late AuthDatesource datasource;
  late Dio restClient;

  setUp(() {
    restClient = MockRestClient();
    datasource = AuthDatesourceImpl(restClient: restClient);
  });

  const name = 'John Doe';
  const email = 'john.doe@example.com';
  const password = 'password123';

  const userModel = UserModel(
    id: 1,
    name: name,
    email: email,
    password: password,
  );

  test('should return UserModel when signup is successful', () async {
    when(
      () => restClient.post(
        any(),
        data: any(named: 'data'),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: {
          'id': 1,
          'name': name,
          'email': email,
          'password': password,
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: '/users'),
      ),
    );

    final result = await datasource.signup(
      name: name,
      email: email,
      password: password,
    );

    expect(result, equals(userModel));
    verify(
      () => restClient.post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      ),
    ).called(1);
  });

  test('should throw Failure when signup fails with non-200 status code',
      () async {
    when(
      () => restClient.post(
        any(),
        data: any(named: 'data'),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: {},
        statusCode: 400,
        requestOptions: RequestOptions(path: '/users'),
      ),
    );

    expect(
      () => datasource.signup(
        name: name,
        email: email,
        password: password,
      ),
      throwsA(isA<Failure>()),
    );
    verify(
      () => restClient.post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      ),
    ).called(1);
  });

  test('should log and throw Failure on exception', () async {
    when(
      () => restClient.post(
        any(),
        data: any(named: 'data'),
      ),
    ).thenThrow(Exception());

    expect(
      () => datasource.signup(
        name: name,
        email: email,
        password: password,
      ),
      throwsA(isA<Failure>()),
    );
    verify(
      () => restClient.post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      ),
    ).called(1);
  });
}
