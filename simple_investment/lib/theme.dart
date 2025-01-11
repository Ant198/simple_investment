import 'package:flutter/material.dart';

class AppColors {
  static Color appBarColor = const Color.fromRGBO(19, 19, 19, 1);
  static Color primeColor = const Color.fromRGBO(25, 25, 25, 1);
  static Color secondaryColor = const Color.fromRGBO(34, 34, 34, 1);
  static Color titleColor = const Color.fromRGBO(210, 205, 216, 1);
  static Color secondaryTitleColor = const Color.fromRGBO(247, 247, 247, 1);
  static Color textColor = const Color.fromRGBO(234, 224, 200, 1);
  static Color permitColor = const Color.fromRGBO(118, 200, 131, 1);
  static Color alertColor = const Color.fromRGBO(211, 75, 86, 1);
  static Color yellowColor = const Color.fromRGBO(252, 229, 102, 1);
  static Color focusColor = const Color.fromRGBO(54, 53, 55, 1);
}

ThemeData primeTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primeColor,
  ),

  scaffoldBackgroundColor: AppColors.primeColor,

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.appBarColor,
    foregroundColor: AppColors.titleColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),

  textTheme: TextTheme(
    bodyMedium: TextStyle(
    color: AppColors.textColor,
    fontSize: 16,
    letterSpacing: 1
    ),
    titleMedium: TextStyle(
      color:AppColors.titleColor,
      fontSize: 16,
      letterSpacing: 1
    ),
    headlineMedium: TextStyle(
      color: AppColors.textColor.withOpacity(0.5),
      fontSize: 16,
      letterSpacing: 1
    )
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.focusColor,
    border: InputBorder.none,
    labelStyle: TextStyle(color: AppColors.textColor.withOpacity(0.2)),
    prefixIconColor: AppColors.textColor,
    hintStyle: TextStyle(
      color: AppColors.textColor.withOpacity(0.5)
    )
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(AppColors.focusColor),
    )
  )
);