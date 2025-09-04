import 'package:flutter/material.dart';

class InfoBloc extends StatelessWidget {
  const InfoBloc(
      {super.key, required this.title, required this.value, this.titleStyle});

  final String title;
  final String value;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultTitleStyle = titleStyle ??
        theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary, fontWeight: FontWeight.w600);

    return Column(
      children: [
        Text(
          title,
          style: defaultTitleStyle,
        ),
        Text(value,
            style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary, fontWeight: FontWeight.w400))
      ],
    );
  }
}
