import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';

ColorScheme colorScheme = ColorScheme.light(
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
);

ThemeData get lightTheme => ThemeData(
    colorScheme: colorScheme,
    brightness: Brightness.light,
    fontFamily: "Outfit",
    textTheme: TextTheme(
        bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: colorScheme.onPrimary),
        bodyMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: colorScheme.onPrimary),
        bodyLarge: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: colorScheme.onPrimary)));
