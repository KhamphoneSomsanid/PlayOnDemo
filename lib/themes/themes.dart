import 'package:flutter/material.dart';
import 'package:mobile/themes/colors.dart';

class POThemes {
  static ThemeData getLightTheme() {
    return ThemeData(
      fontFamily: 'Roboto',
      brightness: Brightness.light,
      primaryColor: POColors.primaryColor,
      secondaryHeaderColor: POColors.secondaryColor,
      scaffoldBackgroundColor: POColors.scaffoldColor,
      accentColor: POColors.accentColor,
      hintColor: POColors.dividerColor,
      focusColor: POColors.accentColor,
      appBarTheme: AppBarTheme(
        elevation: 2,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: POColors.black),
        // backgroundColor: POColors.primaryColor,
        color: POColors.primaryColor,
      ),
      dividerTheme: DividerThemeData(
        color: POColors.dividerColor,
        thickness: 0.5,
      ),
      textTheme: lightTextTheme,
    );
  }

  static const TextTheme lightTextTheme = TextTheme(
    headline6: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: POColors.black),
    headline5: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: POColors.black),
    headline4: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: POColors.darkGray),
    headline3: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: POColors.darkGray),
    headline2: TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w700, color: POColors.darkGray),
    headline1: TextStyle(
        fontSize: 28.0, fontWeight: FontWeight.w700, color: POColors.darkGray),
    subtitle1: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: POColors.darkGray),
    subtitle2: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: POColors.darkGray),
    bodyText2: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: POColors.black),
    bodyText1: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: POColors.black),
    caption: TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w300, color: POColors.darkGray),
  );
}
