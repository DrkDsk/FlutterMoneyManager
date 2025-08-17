import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/core/shared/home/ui/builders/calendar/custom_calendar_builder.dart';
import 'package:flutter_money_manager/src/core/shared/home/ui/pages/header_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 300));
    _lastDay = _focusedDay.add(const Duration(days: 60));
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        HeaderCalendar(
          focusedDate: _focusedDay,
          onLeftTap: () {
            setState(() {
              _focusedDay = _focusedDay.subtract(const Duration(days: 30));
            });
          },
          onRightTap: () {
            setState(() {
              _focusedDay = _focusedDay.add(const Duration(days: 30));
            });
          }
        ),
        const SizedBox(height: 20),
        TableCalendar(
          headerVisible: false,
          focusedDay: _focusedDay,
          firstDay: _firstDay,
          lastDay: _lastDay,
          rowHeight: 60,
          selectedDayPredicate: (day) {
            return isSameDay(day, _selectedDate);
          },
          onDayLongPressed: (selectedDay, focusedDay) {},
          calendarFormat: CalendarFormat.month,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDate = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) {
              return date.dayName.substring(0, 3);
            },
            weekdayStyle:
                TextStyle(fontSize: 14.0, color: theme.colorScheme.secondary),
            weekendStyle: TextStyle(
                fontSize: 14.0,
                color: theme.colorScheme.secondary.withOpacity(0.45)),
          ),
          calendarBuilders: const CalendarBuilders(
            todayBuilder: CustomCalendarBuilder.todayBuilder,
            defaultBuilder: CustomCalendarBuilder.defaultBuilder,
            outsideBuilder: CustomCalendarBuilder.outsideBuilder,
            selectedBuilder: CustomCalendarBuilder.selectedBuilder,
          ),
        ),
      ],
    );
  }
}
