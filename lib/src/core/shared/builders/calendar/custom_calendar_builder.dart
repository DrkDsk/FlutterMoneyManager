import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';

class CustomCalendarBuilder {
  static Widget? todayBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    final theme = Theme.of(context);

    final dayNumber = day.day;
    final backgroundColor = AppColors.turquoise.customOpacity(0.65);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: backgroundColor),
      child: Center(
        child: Text(
          "$dayNumber",
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.primary, fontSize: 16),
        ),
      ),
    );
  }

  static Widget? defaultBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    final theme = Theme.of(context);
    final dayNumber = day.day;
    final backgroundColor = theme.colorScheme.onPrimary.customOpacity(0.05);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: backgroundColor),
      child: Center(
        child: Text(
          "$dayNumber",
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: Colors.black.customOpacity(0.6), fontSize: 16),
        ),
      ),
    );
  }

  static Widget? selectedBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    final theme = Theme.of(context);

    final dayNumber = day.day;
    final backgroundColor = Colors.greenAccent.shade100;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: backgroundColor),
      child: Center(
        child: Text(
          "$dayNumber",
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: Colors.black.customOpacity(0.6), fontSize: 16),
        ),
      ),
    );
  }

  static Widget? outsideBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    final theme = Theme.of(context);
    final dayNumber = day.day;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: Text(
          "$dayNumber",
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: Colors.black.customOpacity(0.20), fontSize: 16),
        ),
      ),
    );
  }
}
