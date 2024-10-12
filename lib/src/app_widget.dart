import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poc_minsait/src/core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Teste Minsait',
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
      theme: AppTheme.theme,
    );
  }
}
