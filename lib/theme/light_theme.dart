import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
  ),
  colorScheme: ColorScheme.light(
      background: Colors.grey[300]!,
      primary: Colors.grey[200]!,
      secondary: Colors.grey[300]!,
      outline: Colors.black),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.black),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.black),
  ),
);
