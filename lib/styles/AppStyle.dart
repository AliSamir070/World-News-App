import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppStyle{
  static Color lightPrimaryColor = Color(0xff39A552);
  static Color lightBusinessColor = Color(0xffCF7E48);
  static Color lightPoliticsColor = Color(0xff003E90);
  static Color lightScienceColor = Color(0xffF2D352);
  static Color lightSportsColor = Color(0xffC91C22);
  static Color lightHealthColor = Color(0xffED1E79);
  static Color lightEnvironmentColor = Color(0xff4882CF);
  static ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: lightPrimaryColor
      ),
      backgroundColor: lightPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: lightPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 22
      ),
      headlineLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25
      ),
      headlineMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22
        ),
      titleMedium: TextStyle(
        fontSize: 22,
        color: Colors.white
      ),
      displayMedium: TextStyle(
          fontSize: 18,
          color: Colors.black
      ),
      bodyMedium: TextStyle(
        fontSize: 14
      ),
      bodySmall: TextStyle(
            fontSize: 13,
            color: Colors.grey
        ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 40
      ),
      displaySmall: TextStyle(
        color: Colors.grey,
        fontSize: 14
      ),
      titleSmall: TextStyle(
          color: Colors.black,
          fontSize: 14
      ),
      labelLarge: TextStyle(
        fontSize: 22,
        color: Colors.blue,
        decoration: TextDecoration.underline,
        decorationColor: Colors.blue
    ),
    )
  );
}