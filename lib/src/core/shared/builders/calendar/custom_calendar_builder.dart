import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/core/shared/builders/calendar/day_container.dart';

class CustomCalendarBuilder {
  static Widget? todayBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    final theme = Theme.of(context);

    final dayNumber = day.day;
    final backgroundColor = AppColors.turquoise.customOpacity(0.65);

    return DayContainer(
        dayNumber: dayNumber,
        backgroundColor: backgroundColor,
        textColor: theme.colorScheme.primary);
  }

  static Widget? defaultBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    final theme = Theme.of(context);
    final dayNumber = day.day;
    final backgroundColor = theme.colorScheme.onPrimary.customOpacity(0.05);

    return DayContainer(
        dayNumber: dayNumber,
        backgroundColor: backgroundColor,
        textOpacity: 0.6,
        textColor: Colors.black);
  }

  static Widget? selectedBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    final dayNumber = day.day;
    final backgroundColor = Colors.greenAccent.shade100;

    return DayContainer(
        dayNumber: dayNumber,
        backgroundColor: backgroundColor,
        textColor: Colors.black,
        textOpacity: 0.6);
  }

  static Widget? outsideBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    final dayNumber = day.day;

    return DayContainer(
        dayNumber: dayNumber, textColor: Colors.black, textOpacity: 0.20);
  }
}
