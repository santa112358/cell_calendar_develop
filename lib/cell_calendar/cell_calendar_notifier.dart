import 'package:flutter/foundation.dart';

import 'constants.dart';

extension _DaysDuration on int {
  Duration get daysDuration {
    return Duration(days: (this == 7) ? 0 : -this);
  }
}

class CellCalendarNotifier extends ChangeNotifier {
  CellCalendarNotifier() {
    this._initialize();
  }

  DateTime currentDateTime;

  List<DateTime> currentDays = [];
  void _initialize() {
    currentDateTime = DateTime.now();
    currentDays = _getCurrentDays(currentDateTime);
    notifyListeners();
  }

  List<DateTime> _getCurrentDays(DateTime dateTime) {
    final List<DateTime> result = [];
    final firstDay = _getFirstDay(dateTime);
    result.add(firstDay);
    for (int i = 0; i + 1 < 42; i++) {
      result.add(firstDay.add(Duration(days: i + 1)));
    }
    return result;
  }

  DateTime _getFirstDay(DateTime dateTime) {
    final firstDayOfTheMonth = DateTime(dateTime.year, dateTime.month, 1);
    return firstDayOfTheMonth.add(firstDayOfTheMonth.weekday.daysDuration);
  }

  void onPageChanged(int index) {
    currentDateTime = index.currentDateTime;
    currentDays = _getCurrentDays(currentDateTime);
    notifyListeners();
  }
}
