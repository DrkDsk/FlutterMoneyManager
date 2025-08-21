import 'package:flutter/material.dart';

class CreateTransactionItem extends StatelessWidget {
  const CreateTransactionItem(
      {super.key,
      this.largeStyle,
      this.mediumStyle,
      required this.label,
      this.value,
      this.child,
      required this.onTap});

  final void Function()? onTap;
  final TextStyle? largeStyle;
  final TextStyle? mediumStyle;
  final String? value;
  final String label;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final widget = child ?? Text(value ?? "", style: mediumStyle);

    return Row(
      children: [
        Text(label, style: largeStyle),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Align(alignment: Alignment.centerRight, child: widget),
          ),
        )
      ],
    );
  }
}
