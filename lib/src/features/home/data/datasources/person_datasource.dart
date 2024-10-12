import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:poc_minsait/src/core/device/app_storage.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/core/rest_client/interceptor/token_interceptor.dart';
import 'package:poc_minsait/src/features/home/data/models/person_model.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';

abstract interface class PersonDatasource {
  Future<List<PersonModel>> getPersons();
  Future<PersonModel> createPerson({
    required PersonEntity person,
  });
}

class PersonDatasourceImpl implements PersonDatasource {
  final Dio _restClient;
  final AppSecureStorage _appSecureStorage;

  PersonDatasourceImpl({
    required Dio restClient,
    required AppSecureStorage appSecureStorage,
  })  : _restClient = restClient,
        _appSecureStorage = appSecureStorage;

  @override
  Future<PersonModel> createPerson({
    required PersonEntity person,
  }) async {
    try {
      _restClient.interceptors.add(
        TokenInterceptor(
          appSecureStorage: _appSecureStorage,
        ),
      );
      final response = await _restClient.post(
        '/persons',
        data: {
          'document': person.cpf,
          'fullName': person.name,
          'birthDate': person.birthDate,
          'address': {
            'cep': person.address.cep,
            'logradouro': person.address.logradouro,
            'number': person.address.number,
            'complemento': person.address.complemento,
            'bairro': person.address.bairro,
            'localidade': person.address.localidade,
            'uf': person.address.uf,
          },
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao criar a pessoa');
      }

      return PersonModel.fromJson(response.data);
    } on Failure catch (e, s) {
      log('Erro ao criar a pessoa', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao criar a pessoa');
    }
  }

  @override
  Future<List<PersonModel>> getPersons() async {
    try {
      final response = await _restClient.get('/persons');

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar as pessoas');
      }

      final List<PersonModel> persons = (response.data as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();

      return persons;
    } on Failure catch (e, s) {
      log('Erro ao buscar as pessoas', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao buscar as pessoas');
    }
  }
}
