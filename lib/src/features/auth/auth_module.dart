import 'package:flutter_modular/flutter_modular.dart';
import 'package:poc_minsait/src/app_module.dart';
import 'package:poc_minsait/src/features/auth/data/datasource/auth_datesource.dart';
import 'package:poc_minsait/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:poc_minsait/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:poc_minsait/src/features/auth/domain/usecases/signin_usecase.dart';
import 'package:poc_minsait/src/features/auth/domain/usecases/signup_usecase.dart';
import 'package:poc_minsait/src/features/auth/presentation/pages/auth_page.dart';
import 'package:poc_minsait/src/features/auth/presentation/pages/cubits/auth/auth_cubit.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton<AuthDatesource>(AuthDatesourceImpl.new);
    i.addLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.addLazySingleton<SignupUsecase>(SignupUsecaseImpl.new);
    i.addLazySingleton<SigninUsecase>(SigninUsecaseImpl.new);
    i.addLazySingleton(AuthCubit.new);
  }

  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(
      '/',
      child: (context) => const AuthPage(),
    );
  }
}
