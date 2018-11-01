import 'package:ems_app/src/widgets/calendar/calendar_utils.dart';
import 'package:flutter/material.dart';
// import 'package:widgets/calendar/calendar_tile.dart';

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool hasAppointment;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyles,
    this.isDayOfWeek: false,
    this.isSelected: false,
    this.hasAppointment: true,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return new InkWell(
        child: new Container(
          alignment: Alignment.center,
          child: new Text(
            dayOfWeek,
            style: dayOfWeekStyles,
          ),
        ),
      );
    } else {
      return new InkWell(
        onTap: onDateSelected,
        child: Column(
          children: <Widget>[
            Expanded(
              child: new Container(
                decoration: isSelected
                    ? new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      )
                    : new BoxDecoration(),
                alignment: Alignment.center,
                child: new Text(
                  Utils.formatDay(date).toString(),
                  style: isSelected
                      ? new TextStyle(color: Colors.white)
                      : dateStyles,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            new CircleAvatar(backgroundColor: Colors.blueAccent, radius: 3.0),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return new InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: renderDateOrDayOfWeek(context),
    );
  }
}
