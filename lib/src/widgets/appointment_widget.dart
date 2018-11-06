import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/util/date_utils.dart';
import 'package:flutter/material.dart';

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
                color: Colors.blueAccent[200],
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                border: new Border.all(color: Colors.blueAccent, width: 0.0))
            : null,
        child: ListTile(
            trailing: new Text(DateUtils.fullDayFormat(appointment.start),
                style: selected ? selectedStyle : null),
            leading: new Text("$startFormatted-$stopFormatted",
                style: selected ? selectedStyle : null),
            title: new Text(appointment.location,
                style: selected ? selectedStyle : null),
            onTap: () => onAppointmentSelected(appointment)));
  }
}
