import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/widgets/transactions_list.dart';

class DailyBalancePage extends StatelessWidget {
  const DailyBalancePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          "Transaction on August",
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        const Expanded(child: TransactionsList()),
      ],
    );
  }
}
