import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/widgets/calendar/calendar_widget.dart';
import 'package:flutter/material.dart';

class CalenderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: new Calendar(appointments: Appointment.demodata)),
    );
  }
}
