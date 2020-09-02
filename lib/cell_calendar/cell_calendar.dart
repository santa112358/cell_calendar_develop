import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _headerHeight = 80;

class CellCalendar extends StatelessWidget {
  Widget _tableCell(double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Column(
        children: [
          Text("d"),
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
      children: [
        SizedBox(
          height: _headerHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {},
              ),
              Text("Month"),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Table(
          border:
              TableBorder.all(width: 1, color: Theme.of(context).dividerColor),
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
  }
}
