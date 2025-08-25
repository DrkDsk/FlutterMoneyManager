import 'package:flutter/material.dart';

class CreateTransactionItem extends StatelessWidget {
  const CreateTransactionItem({
    super.key,
    required this.label,
    this.onTap,
    this.value,
    this.child,
    this.mediumStyle,
  });

  final String label;
  final String? value;
  final Widget? child;
  final TextStyle? mediumStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final valueTextStyle = mediumStyle ??
        theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400);

    final displayWidget = child ??
        Text(
          value ?? "",
          style: valueTextStyle,
          textAlign: TextAlign.right,
        );

    return Row(
      children: [
        Text(label,
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w400)),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child:
                Align(alignment: Alignment.centerRight, child: displayWidget),
          ),
        )
      ],
    );
  }
}
