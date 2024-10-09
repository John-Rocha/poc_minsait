import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poc_minsait/src/core/device/app_storage.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.add<AppStorage>(AppStorageImpl.new);
  }

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
