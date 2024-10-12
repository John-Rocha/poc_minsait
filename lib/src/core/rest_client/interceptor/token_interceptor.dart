import 'package:dio/dio.dart';
import 'package:poc_minsait/src/core/device/app_storage.dart';

class TokenInterceptor extends Interceptor {
  final AppSecureStorage _appSecureStorage;

  TokenInterceptor({required AppSecureStorage appSecureStorage})
      : _appSecureStorage = appSecureStorage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _appSecureStorage.getSessionToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }
}
