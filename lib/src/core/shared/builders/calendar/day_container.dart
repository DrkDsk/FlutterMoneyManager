import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';

class DayContainer extends StatelessWidget {
  const DayContainer(
      {super.key,
      this.textOpacity = 1.0,
      this.backgroundColor,
      this.textColor,
      required this.dayNumber});

  final Color? backgroundColor;
  final Color? textColor;
  final double textOpacity;
  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: backgroundColor != null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: backgroundColor,
            )
          : null,
      child: Center(
        child: Text(
          "$dayNumber",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: (textColor ?? Colors.black).customOpacity(textOpacity),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
