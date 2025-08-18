import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/shared/home/ui/widgets/body_calendar.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/expense_list.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {

    return const SingleChildScrollView(
      child: Column(
        children: [
          BodyCalendar(),
          SizedBox(height: 40,),
          SizedBox(
            height: 400,
            child: ExpenseList(),
          )
        ],
      ),
    );
  }
}
