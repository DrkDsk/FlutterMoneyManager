import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';

class CustomCalendarBuilder {

  static Widget? todayBuilder(BuildContext context, DateTime day, DateTime focusedDay) {
    final theme = Theme.of(context);

    final dayNumber = day.day;
    final backgroundColor = AppColors.turquoise.withOpacity(0.65);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        child: InkWell(
          highlightColor: backgroundColor,
          onTap: () {},
          child: Ink(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              width: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: backgroundColor),
              child: Center(
                child: Text(
                  "$dayNumber",
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget? defaultBuilder(BuildContext context, DateTime day, DateTime focusedDay) {

    final theme = Theme.of(context);
    final dayNumber = day.day;
    final backgroundColor = theme.colorScheme.onPrimary.withOpacity(0.05);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        child: InkWell(
          highlightColor: backgroundColor,
          onTap: () {},
          child: Ink(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              width: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: backgroundColor),
              child: Center(
                child: Text(
                  "$dayNumber",
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.6), fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget? selectedBuilder(BuildContext context, DateTime day, DateTime focusedDay) {

    final theme = Theme.of(context);

    final dayNumber = day.day;
    final backgroundColor = Colors.greenAccent.shade100;


    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        child: InkWell(
          highlightColor: backgroundColor,
          onTap: () {},
          child: Ink(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              width: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: backgroundColor),
              child: Center(
                child: Text(
                  "$dayNumber",
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.6), fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget? outsideBuilder(BuildContext context, DateTime day, DateTime focusedDay) {

    final theme = Theme.of(context);
    final dayNumber = day.day;
    final backgroundColor = theme.colorScheme.onPrimary.withOpacity(0.05);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        child: InkWell(
          highlightColor: backgroundColor,
          onTap: () {},
          child: Ink(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              width: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Text(
                  "$dayNumber",
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.20), fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}