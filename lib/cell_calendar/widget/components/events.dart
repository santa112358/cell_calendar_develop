import 'package:cell_calendar_develop/cell_calendar/widget/components/measure_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../calendar_event.dart';
import '../../calendar_state_controller.dart';

class Events extends StatefulWidget {
  Events(this.date);

  final DateTime date;

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  double cellHeight;

  @override
  Widget build(BuildContext context) {
    return MeasureSize(
      onChange: (size) {
        cellHeight = size.height;
      },
      child: Selector<CalendarStateController, List<CalendarEvent>>(
        builder: (context, events, _) => Column(
          children: Provider.of<CalendarStateController>(context)
              .eventsOnTheDay(widget.date)
              .map(
            (event) {
              print(cellHeight);
              return _EventLabel(event);
            },
          ).toList(),
        ),
        selector: (context, controller) => controller.events,
      ),
    );
  }
}

class _EventLabel extends StatelessWidget {
  _EventLabel(this.event);

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4, bottom: 3),
      width: double.infinity,
      color: event.eventBackgroundColor,
      child: Text(
        event.eventName,
        style: TextStyle(
            color: event.eventTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 11),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
