import 'package:flutter/material.dart';

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
