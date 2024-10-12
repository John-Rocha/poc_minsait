import 'package:flutter_modular/flutter_modular.dart';
import 'package:poc_minsait/src/core/services/cep_service.dart';
import 'package:poc_minsait/src/features/auth/auth_module.dart';
import 'package:poc_minsait/src/features/home/data/datasources/person_datasource.dart';
import 'package:poc_minsait/src/features/home/data/repositories/person_repository_impl.dart';
import 'package:poc_minsait/src/features/home/domain/repositories/person_repository.dart';
import 'package:poc_minsait/src/features/home/domain/usecases/create_person_usecase.dart';
import 'package:poc_minsait/src/features/home/domain/usecases/get_persons_usecase.dart';
import 'package:poc_minsait/src/features/home/presentation/cubits/form_page/form_page_cubit.dart';
import 'package:poc_minsait/src/features/home/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:poc_minsait/src/features/home/presentation/pages/form_page.dart';
import 'package:poc_minsait/src/features/home/presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton<PersonDatasource>(PersonDatasourceImpl.new);
    i.addLazySingleton<PersonRepository>(PersonRepositoryImpl.new);
    i.addLazySingleton<CreatePersonUsecase>(CreatePersonUsecaseImpl.new);
    i.addLazySingleton<GetPersonsUsecase>(GetPersonsUsecaseImpl.new);
    i.addLazySingleton(CepService.new);
    i.addLazySingleton(FormPageCubit.new);
    i.addLazySingleton(HomePageCubit.new);
  }

  @override
  List<Module> get imports => [
        AuthModule(),
      ];
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const HomePage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/form',
      child: (context) => const FormPage(),
      transition: TransitionType.fadeIn,
    );
  }
}
