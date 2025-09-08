import 'package:flutter/material.dart';

class AccountTransactionRow extends StatelessWidget {
  const AccountTransactionRow(
      {super.key,
      required this.account,
      required this.icon,
      required this.amount,
      required this.textColor});

  final String account;
  final String icon;
  final int amount;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          Image.asset(
            icon,
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 10),
          Text(account,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w300, fontSize: 20))
        ],
      ),
      Text("\$ $amount",
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: textColor, fontSize: 20))
    ]);
  }
}
