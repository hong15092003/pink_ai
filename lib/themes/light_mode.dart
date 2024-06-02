import 'package:flutter/material.dart';

ThemeData lightMode() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    indicatorColor: Colors.white,
    canvasColor: Colors.grey[200],
    shadowColor: Colors.grey[300],
    dividerColor: Colors.grey[300],
    hintColor: Colors.grey[800],
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      labelMedium: TextStyle(color: Colors.black, fontSize: 15),
      titleMedium: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: Colors.black, fontSize: 20),
    ),
  );
}
