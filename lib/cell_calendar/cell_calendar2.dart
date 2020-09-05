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

const List<String> _sampleDays = ['test','hey','come on','good bye','ohh','ok','no'];

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
                  Expanded(
                    child: Row(
                      children: _sampleDays.map((day) => {
                        return Text(day);
                      }).toList();,
                    ),
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
