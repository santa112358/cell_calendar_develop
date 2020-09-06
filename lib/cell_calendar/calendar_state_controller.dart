import 'package:cell_calendar_develop/cell_calendar/event.dart';
import 'package:flutter/foundation.dart';

import 'constants.dart';

class CalendarStateController extends ChangeNotifier {
  CalendarStateController(this.events, this.onPageChangedFromUserArgument,
      this.onCellTappedFromUserArgument) {
    this._initialize();
  }

  final List<CalendarEvent> events;

  final Function(DateTime firstDate, DateTime lastDate)
      onPageChangedFromUserArgument;

  final void Function(DateTime) onCellTappedFromUserArgument;

  DateTime currentDateTime;

  void _initialize() {
    currentDateTime = DateTime.now();
    notifyListeners();
  }

  void onPageChanged(int index) {
    currentDateTime = index.currentDateTime;
    if (onPageChangedFromUserArgument != null) {
      onPageChangedFromUserArgument(
          currentDateTime, currentDateTime.add(Duration(days: 41)));
    }
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

  void onCellTapped(DateTime date) {
    if (onCellTappedFromUserArgument != null) {
      onCellTappedFromUserArgument(date);
    }
  }
}
