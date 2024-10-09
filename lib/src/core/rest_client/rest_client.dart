import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:poc_minsait/src/core/rest_client/interceptor/auth_interceptors.dart';

late AuthInterceptors _authInterceptors;

class RestClient extends DioForNative {
  RestClient()
      : super(
          BaseOptions(
            baseUrl: 'http://localhost:8081',
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    _authInterceptors = AuthInterceptors();
  }

  RestClient auth() {
    interceptors.add(_authInterceptors);
    return this;
  }

  RestClient unauth() {
    interceptors.remove(_authInterceptors);
    return this;
  }
}
