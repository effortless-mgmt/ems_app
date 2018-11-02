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
  final bool appointmentIsOld;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;

  CalendarTile(
      {this.onDateSelected,
      this.date,
      this.child,
      this.dateStyles,
      this.dayOfWeek,
      this.dayOfWeekStyles,
      this.isDayOfWeek: false,
      this.isSelected: false,
      this.hasAppointment,
      this.appointmentIsOld});

  Widget renderDateOrDayOfWeek(BuildContext context) {
    bool notNull(Object o) => o != null;

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
        child: new Container(
          decoration: isSelected
              ? new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                )
              : new BoxDecoration(),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: hasAppointment ? const EdgeInsets.only(top: 5.0) : null,
                child: new Text(
                  Utils.formatDay(date).toString(),
                  style: isSelected
                      ? Utils.isSameDay(date, DateTime.now())
                          ? new TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)
                          : new TextStyle(color: Colors.white)
                      : dateStyles,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(height: 5.0),
              hasAppointment
                  ? appointmentIsOld
                      ? new CircleAvatar(
                          backgroundColor: Colors.grey, radius: 3.0)
                      : new CircleAvatar(
                          backgroundColor: Colors.blueAccent, radius: 3.0)
                  : null,
            ].where(notNull).toList(),
          ),
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
