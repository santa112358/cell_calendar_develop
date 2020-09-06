import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../calendar_event.dart';
import '../../calendar_state_controller.dart';

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
