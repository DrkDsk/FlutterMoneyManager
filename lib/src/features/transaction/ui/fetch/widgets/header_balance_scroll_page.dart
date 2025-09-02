import 'package:flutter/material.dart';

class HeaderBalanceScrollPage extends StatelessWidget {
  const HeaderBalanceScrollPage({
    super.key,
    required this.monthName,
    this.leftTap,
    this.rightTap,
  });

  final void Function()? leftTap;
  final void Function()? rightTap;
  final String monthName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: leftTap,
          icon: const Icon(
            Icons.keyboard_arrow_left_sharp,
            size: 35,
          ),
          iconSize: 35,
        ),
        Text(monthName),
        IconButton(
          onPressed: rightTap,
          icon: const Icon(
            Icons.keyboard_arrow_right_sharp,
            size: 35,
          ),
        )
      ],
    );
  }
}
