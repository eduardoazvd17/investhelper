import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const _kCenterTitle = true;
  static const _kPrimaryColor = Colors.deepPurple;
  static const _kSecondaryColor = Colors.blueGrey;
  static const _kBorderRadius = 10.0;
  static const _kLightBackgroundColor = Colors.white;
  static final _kSecondaryLightBackgroundColor = Colors.grey[100];
  static const _kDarkBackgroundColor = Colors.black;
  static final _kSecondaryDarkBackgroundColor = Colors.grey[900];

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        primaryColor: _kPrimaryColor[200],
        scaffoldBackgroundColor: _kLightBackgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _kPrimaryColor,
          brightness: Brightness.light,
          surface: _kLightBackgroundColor,
          surfaceTint: _kLightBackgroundColor,
          secondary: _kSecondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: _kCenterTitle,
          backgroundColor: _kLightBackgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
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
        cardTheme: CardTheme(
          color: _kSecondaryLightBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: _kSecondaryLightBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_kBorderRadius),
              topRight: Radius.circular(_kBorderRadius),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          selectedItemColor: _kPrimaryColor,
          backgroundColor: _kSecondaryLightBackgroundColor,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: _kPrimaryColor,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        primaryColor: _kPrimaryColor[200],
        scaffoldBackgroundColor: _kDarkBackgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _kPrimaryColor,
          brightness: Brightness.dark,
          surface: Colors.transparent,
          surfaceTint: Colors.transparent,
          secondary: _kSecondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: _kCenterTitle,
          backgroundColor: _kDarkBackgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
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
        cardTheme: CardTheme(
          color: _kSecondaryDarkBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: _kSecondaryDarkBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_kBorderRadius),
              topRight: Radius.circular(_kBorderRadius),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          selectedItemColor: _kPrimaryColor[200],
          backgroundColor: _kSecondaryDarkBackgroundColor,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.black,
          backgroundColor: _kPrimaryColor[200],
        ),
      );
}
