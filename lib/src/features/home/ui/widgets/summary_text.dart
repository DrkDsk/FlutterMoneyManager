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
    return Column(
      children: [
        Text(
          summaryLabel,
          style: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          "\$ $summaryValue",
          style: TextStyle(
              color: textValueColor, fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ],
    );
  }
}