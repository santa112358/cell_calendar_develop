import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../calendar_state_controller.dart';
import '../constants.dart';

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
