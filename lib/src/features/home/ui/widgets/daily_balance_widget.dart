import 'package:flutter/material.dart';
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
        Positioned(
          bottom: 50,
          child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.blueAccent.shade100,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: theme.colorScheme.onPrimary,
                        offset: const Offset(3, 3),
                        blurRadius: 4
                    )
                  ]
              ),
              child: Icon(Icons.add, size: 36, color: theme.colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}