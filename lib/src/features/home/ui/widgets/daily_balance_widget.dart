import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/expense_list.dart';

class DailyBalancePage extends StatelessWidget {
  const DailyBalancePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "Transaction on August",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          const SizedBox(
            height: 400,
            child: ExpenseList(),
          ),
        ],
      ),
    );
  }
}