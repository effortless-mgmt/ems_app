import 'dart:async';

import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/widgets/calendar/calendar_utils.dart';
import 'package:ems_app/src/widgets/calendar/calendar_widget.dart';
import 'package:flutter/material.dart';

class CalenderScreen extends StatelessWidget {
  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[
          new Calendar(
              appointments: Appointment.demodata,
              onDateSelected: (date) => selected = date),
          new Expanded(
            child: new ListView.builder(
                itemCount: Appointment.demodata.length,
                itemBuilder: _appointmentBuilder
                // Utils.isSameDay(Appointment.demodata[index].date, selected)
                ),
          ),
        ],
      ),
    );
  }

  Widget _appointmentBuilder(BuildContext context, int index) {
    bool isOldAppointment =
        Appointment.demodata[index].date.isBefore(DateTime.now());
    return isOldAppointment
        ? AppointmentWidget(Appointment.demodata[index], selected)
        : Container(height: 0.0, width: 0.0);
  }
  // void _handleAppointmentCallback(bool isSelected) {

  // }
}
