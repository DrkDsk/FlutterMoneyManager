import 'package:flutter/material.dart';

ColorScheme colorScheme = ColorScheme.light(
  primary: Colors.white24.withOpacity(0.20),
  onPrimary: Colors.white,
  secondary: Colors.blueAccent.shade400,
  onSecondary:  Colors.white38,
  surface: Colors.grey.shade700
);

ThemeData lightTheme () {
  return ThemeData(
      colorScheme: colorScheme,
      brightness: Brightness.light,
      fontFamily: "Outfit",
      textTheme: TextTheme(
          bodySmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: colorScheme.onPrimary
          ),
          bodyMedium: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: colorScheme.onPrimary
          ),
          bodyLarge: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
              color: colorScheme.onPrimary
          )
      )
  );
}