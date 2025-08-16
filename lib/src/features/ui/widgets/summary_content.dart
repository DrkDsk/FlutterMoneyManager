import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/ui/widgets/summary_text.dart';

class SummaryContent extends StatelessWidget {
  const SummaryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SummaryText(
          summaryLabel: "Income",
          summaryValue: "840.00",
          textValueColor: Colors.green,
        ),
        SizedBox(
          width: 10,
        ),
        SummaryText(
          summaryLabel: "Expense",
          summaryValue: "560.00",
          textValueColor: Colors.redAccent,
        ),
        SizedBox(
          width: 10,
        ),
        SummaryText(
          summaryLabel: "Total",
          summaryValue: "280.00",
          textValueColor: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        SummaryText(
          summaryLabel: "Balance",
          summaryValue: "280.00",
          textValueColor: Colors.white,
        ),
      ],
    );
  }
}