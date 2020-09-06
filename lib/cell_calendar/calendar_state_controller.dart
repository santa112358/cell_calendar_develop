import 'package:cell_calendar_develop/cell_calendar/event.dart';
import 'package:flutter/foundation.dart';

import 'constants.dart';

class CalendarStateController extends ChangeNotifier {
  CalendarStateController(this.events) {
    this._initialize();
  }

  final List<CalendarEvent> events;

  DateTime currentDateTime;

  void _initialize() {
    currentDateTime = DateTime.now();
    notifyListeners();
  }

  void onPageChanged(int index) {
    currentDateTime = index.currentDateTime;
    notifyListeners();
  }

  List<CalendarEvent> eventsOnTheDay(DateTime date) {
    final res = events
        .where((event) =>
            event.eventDate.year == date.year &&
            event.eventDate.month == date.month &&
            event.eventDate.day == date.day)
        .toList();
    return res;
  }
}
