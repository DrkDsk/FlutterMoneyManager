import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/payment_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];

        final paymentSourceType = transaction.sourceType;
        final transactionCategoryType = transaction.categoryType;
        PaymentSource? transactionSource;
        TransactionCategory? transactionCategory;

        if (paymentSourceType != null) {
          transactionSource = PaymentSource.fromType(paymentSourceType);
        }

        if (transactionCategoryType != null) {
          transactionCategory =
              TransactionCategory.fromType(transactionCategoryType);
        }

        if (transactionCategory == null || transactionSource == null) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TransactionListItem(
            amuount: transaction.amount,
            source: transactionCategory.name,
            transactionSource: transactionSource.name,
          ),
        );
      },
      separatorBuilder: (_, index) => const Divider(
        color: Colors.grey,
        thickness: 0.5,
      ),
    );
  }
}

class TransactionListItem extends StatelessWidget {
  const TransactionListItem(
      {super.key,
      required this.amuount,
      required this.source,
      required this.transactionSource});

  final int amuount;
  final String source;
  final String transactionSource;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green.shade200),
                  child: Icon(Icons.money,
                      size: 20, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 8),
                Text(
                  source,
                  style: theme.textTheme.bodyMedium,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$ $amuount",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.incomeColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  transactionSource,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
