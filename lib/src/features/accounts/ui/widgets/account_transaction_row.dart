import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';

class AccountTransactionRow extends StatelessWidget {
  const AccountTransactionRow(
      {super.key,
      required this.account,
      required this.icon,
      required this.amount});

  final String account;
  final String icon;
  final int amount;

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
              ?.copyWith(color: AppColors.expenseColor, fontSize: 20))
    ]);
  }
}
