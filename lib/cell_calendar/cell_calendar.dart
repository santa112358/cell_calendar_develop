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
  CellCalendar({this.events, this.onPageChanged});

  final List<CalendarEvent> events;
  final Function(DateTime firstDate, DateTime lastDate) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_context) => CalendarStateController(events),
      child: CellCalendarFrame(events),
    );
  }
}

class CellCalendarFrame extends StatelessWidget {
  CellCalendarFrame(this.events);

  final List<CalendarEvent> events;

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
              return CalendarBody.wrapped(index.currentDateTime, events);
            },
            onPageChanged:
                Provider.of<CalendarStateController>(context, listen: false)
                    .onPageChanged,
          ),
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
  const CalendarBody._(
    this.events, {
    Key key,
  }) : super(key: key);

  final List<CalendarEvent> events;

  static Widget wrapped(DateTime currentPageDate, List<CalendarEvent> events) {
    return ChangeNotifierProvider(
      create: (_context) => CalendarMonthController(currentPageDate),
      child: CalendarBody._(events),
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
                child: DayCell(date)),
          );
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
    return Column(
      children: [
        Text(
          date.day.toString(),
          textAlign: TextAlign.center,
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
        style: TextStyle(color: event.eventTextColor),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
