import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';

class AppColors {
  static Color primary = const Color(0xFFFFFFFF);
  static Color onPrimary = Colors.grey.shade600;
  static Color secondary = Colors.blueAccent;
  static Color onSecondary = Colors.white38;
  static Color incomeColor = Colors.green.shade600;
  static Color expenseColor = Colors.redAccent;
  static Color turquoise = const Color(0xE268C2E0);
  static Color keyboardBackgroundColor = onPrimary.customOpacity(0.85);
}
