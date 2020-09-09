import 'package:cell_calendar_develop/cell_calendar/calendar_month_controller.dart';
import 'package:cell_calendar_develop/cell_calendar/calendar_state_controller.dart';
import 'package:cell_calendar_develop/cell_calendar/cell_size_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../calendar_event.dart';
import '../date_extension.dart';
import 'components/days_of_the_week.dart';
import 'components/days_row.dart';
import 'components/month_year_label.dart';

/// Calendar widget like a Google Calendar
///
/// Expected to be used in full screen
class CellCalendar extends StatelessWidget {
  CellCalendar({this.events, this.onPageChanged, this.onCellTapped});

  final List<CalendarEvent> events;
  final Function(DateTime firstDate, DateTime lastDate) onPageChanged;
  final void Function(DateTime) onCellTapped;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              CalendarStateController(events, onPageChanged, onCellTapped),
        ),
        ChangeNotifierProvider(
          create: (_) => CellSizeController(),
        ),
      ],
      child: _CalendarBody(),
    );
  }
}

class _CalendarBody extends StatelessWidget {
  _CalendarBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MonthYearLabel(),
        Expanded(
          child: PageView.builder(
              controller: PageController(initialPage: 1200),
              itemBuilder: (context, index) {
                return _CalendarPage.wrapped(index.currentDateTime);
              },
              onPageChanged: (index) {
                Provider.of<CalendarStateController>(context, listen: false)
                    .onPageChanged(index);
              }),
        ),
      ],
    );
  }
}

class _CalendarPage extends StatelessWidget {
  const _CalendarPage._({
    Key key,
  }) : super(key: key);

  static Widget wrapped(DateTime currentPageDate) {
    return ChangeNotifierProvider(
      create: (_context) => CalendarMonthController(currentPageDate),
      child: _CalendarPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CalendarMonthController>(context);
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
