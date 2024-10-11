import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/auth/data/models/auth_model.dart';
import 'package:poc_minsait/src/features/auth/data/models/user_model.dart';

abstract interface class AuthDatesource {
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthModel> signin({
    required String email,
    required String password,
  });
}

class AuthDatesourceImpl implements AuthDatesource {
  final Dio _restClient;

  AuthDatesourceImpl({required Dio restClient}) : _restClient = restClient;

  @override
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _restClient.post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        throw Failure(message: 'Erro ao criar o usuário');
      }

      return UserModel.fromJson(response.data);
    } on Exception catch (e, s) {
      log('Erro ao criar o usuário', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao criar o usuário');
    }
  }

  @override
  Future<AuthModel> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _restClient.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        throw Failure(message: 'Erro ao autenticar o usuário');
      }

      return AuthModel.fromJson(response.data);
    } on Exception catch (e, s) {
      log('Erro ao autenticar o usuário', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao autenticar o usuário');
    }
  }
}
