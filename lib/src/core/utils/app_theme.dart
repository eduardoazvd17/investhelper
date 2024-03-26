import 'package:flutter/material.dart';

class AppTheme {
  static const _kCenterTitle = true;
  static const _kPrimaryColor = Colors.deepPurple;
  static const _kBorderRadius = 10.0;
  static const _kLightBackgroundColor = Colors.white;
  static const _kDarkBackgroundColor = Colors.black;

  static ThemeData get lightTheme => ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: _kCenterTitle,
          backgroundColor: _kLightBackgroundColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_kBorderRadius),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: _kPrimaryColor,
            foregroundColor: _kLightBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_kBorderRadius),
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: _kPrimaryColor,
          brightness: Brightness.light,
          surface: _kLightBackgroundColor,
          surfaceTint: _kLightBackgroundColor,
          secondary: Colors.blueGrey,
        ),
        scaffoldBackgroundColor: _kLightBackgroundColor,
        useMaterial3: true,
      );

  static ThemeData get darkTheme => ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: _kCenterTitle,
          backgroundColor: _kDarkBackgroundColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_kBorderRadius),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: _kPrimaryColor[200],
            foregroundColor: _kDarkBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_kBorderRadius),
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: _kPrimaryColor,
          brightness: Brightness.dark,
          surface: Colors.transparent,
          surfaceTint: Colors.transparent,
          secondary: Colors.blueGrey,
        ),
        primaryColor: _kPrimaryColor[200],
        scaffoldBackgroundColor: _kDarkBackgroundColor,
        useMaterial3: true,
      );
}
