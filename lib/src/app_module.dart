import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(
      '/',
      child: (_) => Container(
        color: Colors.red,
      ),
    );
  }
}
