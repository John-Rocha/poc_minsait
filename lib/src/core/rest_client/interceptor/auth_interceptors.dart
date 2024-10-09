import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poc_minsait/src/core/device/app_storage.dart';

class AuthInterceptors extends Interceptor {
  final AppStorage _appStorage;

  AuthInterceptors({AppStorage? appStorage})
      : _appStorage = appStorage ?? Modular.get<AppStorage>();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _appStorage.read('accessToken');
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
    super.onRequest(options, handler);
  }
}
