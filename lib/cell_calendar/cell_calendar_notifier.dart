import 'package:flutter/foundation.dart';

extension _DaysDuration on int {
  Duration get daysDureation {
    return Duration(days: (this == 7) ? 0 : -this);
  }
}

class CellCalendarNotifier extends ChangeNotifier {
  List<DateTime> currentDays = [];
  CellCalendarNotifier() {
    this._initialize();
  }
  void _initialize() {
    final currentMonth = DateTime.now().month;
    currentDays = _getCurrentDays(currentMonth);
    notifyListeners();
  }

  List<DateTime> _getCurrentDays(int month) {
    final List<DateTime> result = [];
    final firstDay = _getFirstDay(month);
    result.add(firstDay);
    for (int i = 0; i + 1 < 42; i++) {
      result.add(firstDay.add(Duration(days: i + 1)));
    }
    return result;
  }

  DateTime _getFirstDay(int month) {
    final firstDayOfTheMonth = DateTime(2020, month, 1);
    return firstDayOfTheMonth.add(firstDayOfTheMonth.weekday.daysDureation);
  }
}
