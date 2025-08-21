import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/body_calendar.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/expense_list.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(4),
              decoration: kWidgetRoundedDecoration,
              child: const BodyCalendar()),
          const SizedBox(height: 20),
          Container(
            height: 400,
            decoration: kWidgetRoundedDecoration,
            child: const ExpenseList(),
          )
        ],
      ),
    );
  }
}
