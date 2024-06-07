import 'package:flutter/material.dart';

import 'package:pink_ai/main.dart';

ThemeData lightMode() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColorNotifier.value,
    indicatorColor: Colors.white,
    canvasColor: Colors.white,
    shadowColor: Colors.grey[300],
    dividerColor: Colors.grey[800],
    hintColor: Colors.grey[800],
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      labelMedium: TextStyle(
        color: Colors.grey[900],
        fontSize: 14,
      ),
      labelSmall: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
      titleMedium: TextStyle(
          color: Colors.grey[900], fontSize: 15, fontWeight: FontWeight.bold),
      headlineLarge: const TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
    ),
  );
}
