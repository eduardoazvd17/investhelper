import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _kCenterTitle = true;
  static const _kPrimaryColor = Colors.deepPurple;
  static const _kSecondaryColor = Colors.blueGrey;
  static const _kBorderRadius = 12.5;
  static const _kLightBackgroundColor = Colors.white;
  static final kSecondaryLightBackgroundColor = Colors.grey[100];
  static const _kDarkBackgroundColor = Colors.black;
  static final kSecondaryDarkBackgroundColor = Colors.grey[900];
  static final _kFontFamilly = GoogleFonts.roboto().fontFamily;
  static const _kToolbarHeight = 62.5;
  static final kShadowColor = Colors.grey.withOpacity(0.3);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: _kFontFamilly,
        primaryColor: _kPrimaryColor,
        scaffoldBackgroundColor: _kLightBackgroundColor,
        shadowColor: kShadowColor,
        hoverColor: kShadowColor,
        colorScheme: ColorScheme.fromSeed(
            seedColor: _kPrimaryColor,
            brightness: Brightness.light,
            surface: kSecondaryLightBackgroundColor,
            surfaceTint: kSecondaryLightBackgroundColor,
            secondary: _kSecondaryColor,
            shadow: kShadowColor),
        appBarTheme: const AppBarTheme(
          toolbarHeight: _kToolbarHeight,
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
          color: kSecondaryLightBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: kSecondaryLightBackgroundColor,
          actionsPadding: const EdgeInsets.only(
            bottom: 25,
            left: 25,
            right: 25,
            top: 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: kSecondaryLightBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(_kBorderRadius),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          selectedItemColor: _kPrimaryColor,
          backgroundColor: kSecondaryLightBackgroundColor,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: _kPrimaryColor,
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: kSecondaryLightBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: kSecondaryLightBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        fontFamily: _kFontFamilly,
        primaryColor: _kPrimaryColor[200],
        scaffoldBackgroundColor: _kDarkBackgroundColor,
        shadowColor: kShadowColor,
        hoverColor: kShadowColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _kPrimaryColor[200]!,
          brightness: Brightness.dark,
          surface: kSecondaryDarkBackgroundColor,
          surfaceTint: kSecondaryDarkBackgroundColor,
          secondary: _kSecondaryColor,
          shadow: kShadowColor,
        ),
        appBarTheme: const AppBarTheme(
          toolbarHeight: _kToolbarHeight,
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
          color: kSecondaryDarkBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: kSecondaryDarkBackgroundColor,
          actionsPadding: const EdgeInsets.only(
            bottom: 25,
            left: 25,
            right: 25,
            top: 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: kSecondaryDarkBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(_kBorderRadius),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          selectedItemColor: _kPrimaryColor[200],
          backgroundColor: kSecondaryDarkBackgroundColor,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.black,
          backgroundColor: _kPrimaryColor[200],
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: kSecondaryDarkBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: kSecondaryDarkBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
        ),
      );
}
