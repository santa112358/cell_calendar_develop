import 'package:cell_calendar_develop/cell_calendar/cell_calendar_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List<String> _DaysOfTheWeek = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fry',
  'Sat'
];

class CellCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Text(
            "Month",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: PageController(initialPage: 1200),
            itemBuilder: (context, index) {
              return CalendarBody.wrapped();
            },
          ),
        ),
      ],
    );
  }
}

class CalendarBody extends StatelessWidget {
  const CalendarBody._({
    Key key,
  }) : super(key: key);

  static Widget wrapped() {
    return ChangeNotifierProvider(
      create: (_context) => CellCalendarNotifier(),
      child: const CalendarBody._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CellCalendarNotifier>(context);
    final days = controller.currentDays;
    return Column(
      children: [
        DaysOfTheWeek(),
        DaysRow(dates: days.getRange(0, 7).toList()),
        DaysRow(dates: days.getRange(7, 14).toList()),
        DaysRow(dates: days.getRange(14, 21).toList()),
        DaysRow(dates: days.getRange(21, 28).toList()),
        DaysRow(dates: days.getRange(28, 35).toList()),
        DaysRow(dates: days.getRange(35, 42).toList()),
      ],
    );
  }
}

class DaysOfTheWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: _DaysOfTheWeek.map((day) {
        return Expanded(
          child: Text(
            day,
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }
}

class DaysRow extends StatelessWidget {
  const DaysRow({
    @required this.dates,
    Key key,
  }) : super(key: key);

  final List<DateTime> dates;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: dates.map((date) {
          return Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Theme.of(context).dividerColor, width: 1),
                  right: BorderSide(
                      color: Theme.of(context).dividerColor, width: 1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    date.day.toString(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
