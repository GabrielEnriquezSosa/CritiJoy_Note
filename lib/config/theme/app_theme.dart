import 'package:flutter/material.dart';

Color black = Colors.black;
Color white = const Color(0xFFFFFFFF);
Color blue = const Color(0xFF2898EE);
Color lightBlue = const Color.fromARGB(255, 243, 248, 255);
Color darkBlue = const Color(0xFF15297C);
Color grey = const Color(0xFF9E9E9E);
Color lightgrey = const Color(0xFFD9D9D9);
Color darkgrey = const Color(0xFF2E2E2E);
Color yellow = const Color(0xFFFFEB3B);

final colorList = <Color>[
  black,
  white,
  blue,
  lightBlue,
  darkBlue,
  grey,
  lightgrey,
  darkgrey,
  yellow,
];

class AppTheme {
  final int selectedColor;
  final int selectedModeCardColor;
  final bool isDarkMode;

  AppTheme({
    this.selectedColor = 0,
    this.selectedModeCardColor = 0,
    this.isDarkMode = false,
  }) : assert(selectedColor >= 0, 'El color seleccionado debe ser mayor que 0'),
       assert(
         selectedColor < colorList.length,
         'El color seleccionado debe ser menor que ${colorList.length - 1}',
       ),
       assert(
         selectedModeCardColor >= 0,
         'El color seleccionado debe ser mayor que 0',
       ),
       assert(
         selectedModeCardColor < colorList.length,
         'El color seleccionado debe ser menor que ${colorList.length - 1}',
       );

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorList[selectedColor],
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      cardTheme: CardTheme(color: colorList[selectedModeCardColor]),
    );
  }
}
