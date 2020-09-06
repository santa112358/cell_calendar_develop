import 'package:cell_calendar_develop/cell_calendar/calendar_month_controller.dart';
import 'package:cell_calendar_develop/cell_calendar/calendar_state_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'event.dart';

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
  CellCalendar({this.events, this.onPageChanged, this.onCellTapped});

  final List<CalendarEvent> events;
  final Function(DateTime firstDate, DateTime lastDate) onPageChanged;
  final void Function(DateTime) onCellTapped;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          CalendarStateController(events, onPageChanged, onCellTapped),
      child: CellCalendarFrame(),
    );
  }
}

class CellCalendarFrame extends StatelessWidget {
  CellCalendarFrame();

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
                return CalendarBody.wrapped(index.currentDateTime);
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

class MonthYearLabel extends StatelessWidget {
  const MonthYearLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CalendarStateController>(context);
    final monthLabel = controller.currentDateTime?.month?.monthName ?? "";
    final yearLabel = controller.currentDateTime?.year?.toString();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Text(
        monthLabel + " " + yearLabel,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CalendarBody extends StatelessWidget {
  const CalendarBody._({
    Key key,
  }) : super(key: key);

  static Widget wrapped(DateTime currentPageDate) {
    return ChangeNotifierProvider(
      create: (_context) => CalendarMonthController(currentPageDate),
      child: CalendarBody._(),
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

class DaysOfTheWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: _DaysOfTheWeek.map((day) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              day,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
          return DayCell(date);
        }).toList(),
      ),
    );
  }
}

class DayCell extends StatelessWidget {
  DayCell(this.date);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Provider.of<CalendarStateController>(context, listen: false)
              .onCellTapped(date);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
              right:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  date.day.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: Provider.of<CalendarStateController>(context)
                    .eventsOnTheDay(date)
                    .map(
                      (event) => EventLabel(event),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EventLabel extends StatelessWidget {
  EventLabel(this.event);

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4, bottom: 3),
      width: double.infinity,
      color: event.eventBackgroundColor,
      child: Text(
        event.eventName,
        style:
            TextStyle(color: event.eventTextColor, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
