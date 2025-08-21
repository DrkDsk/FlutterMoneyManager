import 'package:flutter/material.dart';

class SummaryText extends StatelessWidget {
  const SummaryText({
    super.key,
    required this.summaryLabel,
    required this.summaryValue,
    required this.textValueColor,
  });

  final String summaryLabel;
  final String summaryValue;
  final Color textValueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          summaryLabel,
          style: theme.textTheme.bodyMedium,
        ),
        Text(
          "\$ $summaryValue",
          style: theme.textTheme.bodyLarge
              ?.copyWith(color: textValueColor, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
