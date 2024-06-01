import 'package:flutter/material.dart';

ThemeData darkMode() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    indicatorColor: Colors.white,
    dividerColor: Colors.grey[800],
    canvasColor: Colors.grey[900],
    shadowColor: Colors.grey[800],
    hintColor: Colors.grey[800],
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      labelMedium: TextStyle(color: Colors.white, fontSize: 15),
      titleMedium: TextStyle(color: Colors.white, fontSize: 15),
    ),
  );
}
