import 'package:flutter/material.dart';

sealed class AppTheme {
  static final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1b3b48),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1b3b48),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    useMaterial3: true,
  );
}
