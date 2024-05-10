
import 'package:flutter/material.dart';
import 'package:talkindia/config/colors.dart';

var lightTheme = ThemeData();
var darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: darkPrimaryColor,
    onPrimary: darkOnBackgroundColor,
    background: darkBackgroundColor,
    onBackground: darkOnBackgroundColor,
    primaryContainer: darkContainerColor,
    onPrimaryContainer: darkContainerColor
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      color: darkPrimaryColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w800
    ),
    headlineMedium: TextStyle(
        fontSize: 30,
        color: darkOnBackgroundColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600
    ),
    headlineSmall: TextStyle(
        fontSize: 20,
        color: darkOnBackgroundColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600
    ),
    labelLarge: TextStyle(
        fontSize: 15,
        color: darkOnContainerColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600
    ),
    labelMedium: TextStyle(
        fontSize: 12,
        color: darkOnContainerColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600
    ),
    labelSmall: TextStyle(
        fontSize: 10,
        color: darkOnContainerColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w300
    ),

  )
);
