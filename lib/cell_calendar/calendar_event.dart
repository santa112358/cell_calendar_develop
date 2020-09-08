import 'package:cell_calendar_develop/cell_calendar/widget/cell_calendar.dart';
import 'package:flutter/material.dart';

/// DataModel of event
///
/// [eventName] and [eventDate] is essential to show in [CellCalendar]
class CalendarEvent {
  CalendarEvent({
    @required this.eventName,
    @required this.eventDate,
    this.eventBackgroundColor = Colors.blue,
    this.eventTextColor = Colors.white,
  });

  final String eventName;
  final DateTime eventDate;
  final Color eventBackgroundColor;
  final Color eventTextColor;
}
