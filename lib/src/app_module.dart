import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poc_minsait/src/core/device/app_storage.dart';
import 'package:poc_minsait/src/features/auth/auth_module.dart';
import 'package:poc_minsait/src/features/home/home_module.dart';
import 'package:poc_minsait/src/features/splash/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.add<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: 'http://10.0.2.2:8080',
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 60),
        ),
      )..interceptors.addAll(
          [
            LogInterceptor(
              requestBody: true,
              responseBody: true,
              requestHeader: true,
              responseHeader: true,
            ),
          ],
        ),
    );
    i.add(FlutterSecureStorage.new);
    i.add(AppSecureStorage.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(
      '/',
      child: (_) => const SplashPage(),
    );
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
  }
}
