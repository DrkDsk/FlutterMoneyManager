import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem(
      {super.key,
      required this.amount,
      required this.category,
      required this.transactionSource,
      required this.iconAssetCategory,
      required this.type});

  final int amount;
  final String category;
  final String? transactionSource;
  final TransactionTypEnum type;
  final String iconAssetCategory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final transactionTypeColor = type == TransactionTypEnum.income
        ? AppColors.incomeColor
        : AppColors.expenseColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: transactionTypeColor.customOpacity(0.15)),
              child: Image.asset(
                iconAssetCategory,
                width: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              category,
              style: theme.textTheme.bodyMedium,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "\$ $amount",
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: transactionTypeColor),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "$transactionSource",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        )
      ],
    );
  }
}
