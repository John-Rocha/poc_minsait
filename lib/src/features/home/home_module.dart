import 'package:flutter_modular/flutter_modular.dart';
import 'package:poc_minsait/src/features/auth/auth_module.dart';
import 'package:poc_minsait/src/features/home/presentation/pages/form_page.dart';
import 'package:poc_minsait/src/features/home/presentation/pages/home_page.dart';

class HomeModule extends Module {
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
