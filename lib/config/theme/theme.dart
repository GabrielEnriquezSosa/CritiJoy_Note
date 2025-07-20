import 'package:flutter/material.dart';

Color blue = const Color(0xFF2898EE);
Color lightgrey = const Color(0xFFD9D9D9);
Color grey = const Color(0xFF9E9E9E);
Color yellow = const Color(0xFFFFEB3B);
Color white = const Color(0xFFFFFFFF);
Color black = const Color(0xFF000000);
Color lightBlue = const Color.fromARGB(255, 243, 248, 255);
Color darkBlue = const Color(0xFF15297C);

ThemeData theme() {
  return ThemeData(
    primaryColor: blue,
    scaffoldBackgroundColor: white,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      accentColor: black,
      brightness: Brightness.light,
    ).copyWith(secondary: lightgrey, onPrimary: white, onSecondary: black),
  );
}
