import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/add_summary_button.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/expense_list.dart';

class DailyBalancePage extends StatelessWidget {
  const DailyBalancePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        SingleChildScrollView(
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.90,
                child: const ExpenseList(),
              ),
            ],
          ),
        ),
        const Positioned(
          bottom: 40,
          right: 0,
          child: AddSummaryButton(),
        ),
      ],
    );
  }
}