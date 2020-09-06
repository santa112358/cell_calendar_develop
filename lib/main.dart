import 'package:cell_calendar_develop/cell_calendar/widget/cell_calendar.dart';
import 'package:flutter/material.dart';

import 'cell_calendar/calendar_event.dart';
import 'cell_calendar/date_extension.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  List<CalendarEvent> sampleEvents() {
    final today = DateTime.now();
    final res = [
      CalendarEvent(eventName: "Final exam", eventDate: today),
      CalendarEvent(
          eventName: "Lunch with Mike",
          eventDate: today.add(Duration(days: 1))),
      CalendarEvent(
          eventName: "Movie", eventDate: today.add(Duration(days: 7))),
      CalendarEvent(
          eventName: "Job Interview", eventDate: today.add(Duration(days: 7))),
      CalendarEvent(
          eventName: "デート",
          eventDate: today.add(Duration(days: 42)),
          eventBackgroundColor: Colors.pink),
      CalendarEvent(eventName: "課題", eventDate: today.add(Duration(days: 49))),
    ];
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: CellCalendar(
          events: sampleEvents(),
          onCellTapped: (date) {
            showDialog(
                context: context,
                builder: (context) {
                  final events = sampleEvents()
                      .where((event) =>
                          event.eventDate.year == date.year &&
                          event.eventDate.month == date.month &&
                          event.eventDate.day == date.day)
                      .toList();
                  return AlertDialog(
                    title:
                        Text(date.month.monthName + " " + date.day.toString()),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: events
                          .map(
                            (event) => Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.only(bottom: 12),
                              color: event.eventBackgroundColor,
                              child: Text(
                                event.eventName,
                                style: TextStyle(color: event.eventTextColor),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                });
          },
        ) // This trailing comma makes auto-formatting
        // nicer for build methods.
        );
  }
}
