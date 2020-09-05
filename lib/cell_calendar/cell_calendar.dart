import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _monthLabelHeight = 52;

const double _weekDayLabelsHeight = 32;

const double _headerHeight = _monthLabelHeight + _weekDayLabelsHeight;

const List<String> _weekDays = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fry',
  'Sat'
];

class CellCalendar extends StatelessWidget {
  Widget _tableCell(double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 4,
          ),
          Text("day"),
        ],
      ),
    );
  }

  TableRow _tableRow(double height) {
    return TableRow(
      children: [
        _tableCell(height),
        _tableCell(height),
        _tableCell(height),
        _tableCell(height),
        _tableCell(height),
        _tableCell(height),
        _tableCell(height),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    final bodyHeight = box.size.height;
    final tableRowHeight = (bodyHeight - _headerHeight) / 6;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: _monthLabelHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
              "Month",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: _weekDayLabelsHeight,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text("Sun", textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("Mon", textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("Tue", textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("Wed", textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("Thu", textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("Fri", textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("Sat", textAlign: TextAlign.center)),
                      ],
                    ),
                  ),
                  Table(
                    border: TableBorder.all(
                        width: 1, color: Theme.of(context).dividerColor),
                    children: [
                      _tableRow(tableRowHeight),
                      _tableRow(tableRowHeight),
                      _tableRow(tableRowHeight),
                      _tableRow(tableRowHeight),
                      _tableRow(tableRowHeight),
                      _tableRow(tableRowHeight),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
