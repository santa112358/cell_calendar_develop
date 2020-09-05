import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
k
const List<String> _DaysOfTheWeek = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fry',
  'Sat'
];

const List<String> _sampleDays = [
  'test',
  'hey',
  'come on',
  'good bye',
  'ohh',
  'ok',
  'no'
];

class CellCalendar2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Text(
            "Month",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: PageView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  DaysOfTheWeek(),
                  DaysRow(),
                  DaysRow(),
                  DaysRow(),
                  DaysRow(),
                  DaysRow(),
                  DaysRow(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class DaysOfTheWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: _DaysOfTheWeek.map((day) {
        return Expanded(
          child: Text(
            day,
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }
}

class DaysRow extends StatelessWidget {
  const DaysRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: _sampleDays.map((day) {
          return Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Theme.of(context).dividerColor, width: 1),
                  right: BorderSide(
                      color: Theme.of(context).dividerColor, width: 1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    day,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
