import 'package:cell_calendar_develop/cell_calendar/cell_size_controller.dart';
import 'package:cell_calendar_develop/cell_calendar/widget/components/measure_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../calendar_event.dart';
import '../../calendar_state_controller.dart';

const _dayLabelContentHeight = 14;
const _dayLabelVerticalMargin = 4;
const _dayLabelHeight = _dayLabelContentHeight + (_dayLabelVerticalMargin * 2);

const _eventLabelContentHeight = 13;
const _eventLabelBottomMargin = 3;
const _eventLabelHeight = _eventLabelContentHeight + _eventLabelBottomMargin;

/// Show cells of days with events
class DaysRow extends StatelessWidget {
  const DaysRow({
    @required this.dates,
    Key key,
  }) : super(key: key);

  final List<DateTime> dates;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: dates.map((date) {
          return _DayCell(date);
        }).toList(),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  _DayCell(this.date);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Provider.of<CalendarStateController>(context, listen: false)
              .onCellTapped(date);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
              right:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1),
            ),
          ),
          child: MeasureSize(
            onChange: (size) {
              Provider.of<CellSizeController>(context, listen: false)
                  .onChanged(size);
            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  height: 14,
                  child: Text(
                    date.day.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Events(date),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Events extends StatelessWidget {
  Events(this.date);

  final DateTime date;

  List<CalendarEvent> _eventsOnTheDay(
      DateTime date, List<CalendarEvent> events) {
    final res = events
        .where((event) =>
            event.eventDate.year == date.year &&
            event.eventDate.month == date.month &&
            event.eventDate.day == date.day)
        .toList();
    return res;
  }

  bool _hasEnoughSpace(double cellHeight, int eventsLength) {
    final eventsTotalHeight = _eventLabelHeight * eventsLength;
    final spaceForEvents = cellHeight - _dayLabelHeight;
    return spaceForEvents > eventsTotalHeight;
  }

  @override
  Widget build(BuildContext context) {
    final cellHeight = Provider.of<CellSizeController>(context).cellHeight;
    return Selector<CalendarStateController, List<CalendarEvent>>(
      builder: (context, events, _) {
        if (cellHeight == null) {
          return const SizedBox.shrink();
        }
        final eventsOnTheDay = _eventsOnTheDay(date, events);
        final hasEnoughSpace =
            _hasEnoughSpace(cellHeight, eventsOnTheDay.length);
        final indexWithPlot = eventsOnTheDay.length - 3;
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: eventsOnTheDay.length ?? 0,
          reverse: true,
          itemBuilder: (context, index) {
            if (hasEnoughSpace) {
              return _EventLabel(eventsOnTheDay[index]);
            } else if (index > indexWithPlot) {
              return _EventLabel(eventsOnTheDay[index]);
            } else if (index == indexWithPlot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _EventLabel(
                    eventsOnTheDay[index],
                  ),
                  Icon(
                    Icons.more_horiz,
                    size: 13,
                  )
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        );
      },
      selector: (context, controller) => controller.events,
    );
  }
}

class _EventLabel extends StatelessWidget {
  _EventLabel(this.event);

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4, bottom: 3),
      height: 13,
      width: double.infinity,
      color: event.eventBackgroundColor,
      child: Text(
        event.eventName,
        style: TextStyle(
            color: event.eventTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 11),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
