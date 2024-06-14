import 'package:flutter/material.dart';

import 'package:pink_ai/main.dart';

ThemeData darkMode() {
  return ThemeData(
    fontFamily: 'Lato',
    brightness: Brightness.dark,
    primaryColor: primaryColorNotifier.value,
    indicatorColor: Colors.white,
    dividerColor: Colors.grey[800],
    canvasColor: Colors.grey[800],
    shadowColor: Colors.grey[800],
    hintColor: Colors.grey[800],
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      labelSmall: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
      labelMedium: TextStyle(color: Colors.white, fontSize: 14),
      titleMedium: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
    ),
  );
}
