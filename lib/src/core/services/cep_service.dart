import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:poc_minsait/src/core/errors/failure.dart';
import 'package:poc_minsait/src/features/home/data/models/address_model.dart';

class CepService {
  final Dio _dio;

  CepService({required Dio dio}) : _dio = dio;

  Future<Either<Failure, AddressModel>> getAddress(String cep) async {
    try {
      final response = await _dio.get('https://viacep.com.br/ws/$cep/json/');

      if (response.data['erro'] != null) {
        throw Failure(message: 'CEP not found');
      }

      final address = AddressModel.fromJson(response.data);
      return Right(address);
    } on Failure catch (e, s) {
      log('Erro ao buscar o endereço', error: e, stackTrace: s);
      return Left(Failure(message: 'Erro ao buscar o endereço'));
    }
  }
}
