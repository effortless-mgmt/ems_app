import 'package:flutter/material.dart';

import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/util/date_utils.dart';

class AppointmentWidget extends StatelessWidget {
  final Appointment appointment;
  final DateTime currentDateTime;
  final ValueChanged<Appointment> onAppointmentSelected;

  final TextStyle selectedStyle = TextStyle(color: Colors.white);
  AppointmentWidget(
      {Key key,
      this.appointment,
      this.currentDateTime,
      this.onAppointmentSelected});

  @override
  Widget build(BuildContext context) {
    final String startFormatted =
        DateUtils.asTimeOfDay(appointment.start).format(context);
    final String stopFormatted =
        DateUtils.asTimeOfDay(appointment.stop).format(context);
    final bool selected =
        DateUtils.isSameDay(currentDateTime, appointment.start);
    return Container(
        margin: const EdgeInsets.all(2.0),
        decoration: selected
            ? new BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(4.0)))
            : null,
        child: ListTile(
            trailing: new Text(DateUtils.fullDayFormat(appointment.start),
                style: selected ? selectedStyle : null),
            leading: new Text("$startFormatted-$stopFormatted",
                style: selected ? selectedStyle : null),
            title: new Text(appointment.department,
                style: selected ? selectedStyle : null),
            onTap: () => onAppointmentSelected(appointment)));
  }
}
