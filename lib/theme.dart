import 'package:dukka_finance/constants/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: const MaterialColor(
      AppColors.appThemeColor,
      {
        50: Color.fromRGBO(72, 162, 214, .1),
        100: Color.fromRGBO(72, 162, 214, .2),
        200: Color.fromRGBO(72, 162, 214, .3),
        300: Color.fromRGBO(72, 162, 214, .4),
        400: Color.fromRGBO(72, 162, 214, .5),
        500: Color.fromRGBO(72, 162, 214, .6),
        600: Color.fromRGBO(72, 162, 214, .7),
        700: Color.fromRGBO(72, 162, 214, .8),
        800: Color.fromRGBO(72, 162, 214, .9),
        900: Color.fromRGBO(72, 162, 214, 1),
      },
    ),
    primaryColor: const Color(AppColors.appThemeColor),
    iconTheme: const IconThemeData(color: Colors.black, size: 24),
    backgroundColor: Colors.white,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
    }),
    textTheme: const TextTheme(
        headline1: TextStyle(
          fontFamily: "Mulish",
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        headline2: TextStyle(
          fontFamily: "Mulish",
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        bodyText1: TextStyle(
          fontFamily: "Mulish",
          fontSize: 15,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontFamily: "Mulish",
          fontSize: 12,
          color: Colors.black,
        ),
        headline3: TextStyle(
          fontFamily: "Mulish",
          fontSize: 20,
          color: Colors.black,
        )),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      // foregroundColor: AppColors.headerTextColor,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            // side: const BorderSide(color: AppColors.redColor),
            )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: AppColors.disabledBtnColor,
        disabledForegroundColor: AppColors.disableBtnFontColor,
      ),
    ),
  );
}
