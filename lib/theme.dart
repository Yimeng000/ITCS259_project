import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6A4DF4);  
  static const Color textDark = Color(0xFF333333);
  static const Color subtitle = Color(0xFF777777);
  static const Color lightGray = Color(0xFFF5F5F5);

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: textDark,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
    ),
  );
}
