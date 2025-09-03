import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transactions_list.dart';

class TransactionListContainer extends StatelessWidget {
  const TransactionListContainer({
    super.key,
    required this.date,
    required this.transactions,
  });

  final DateTime date;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              "${date.monthName} ${date.day}",
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary.customOpacity(0.08),
                  borderRadius: BorderRadius.circular(4)),
              child: Text(date.dayName, style: theme.textTheme.bodyMedium),
            ),
            const SizedBox(width: 10),
            Text("${date.year}"),
          ],
        ),
        const SizedBox(height: 10),
        TransactionsList(transactions: transactions),
      ],
    );
  }
}
