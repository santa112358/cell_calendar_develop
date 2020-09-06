import 'package:cell_calendar_develop/cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

import 'cell_calendar/event.dart';

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
      CalendarEvent(eventName: "Test", eventDate: today),
      CalendarEvent(
          eventName: "Mike Lunch", eventDate: today.add(Duration(days: 1))),
      CalendarEvent(
          eventName: "Movie", eventDate: today.add(Duration(days: 7))),
      CalendarEvent(
          eventName: "Interview", eventDate: today.add(Duration(days: 7))),
    ];
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: CellCalendar(
          events: sampleEvents(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
