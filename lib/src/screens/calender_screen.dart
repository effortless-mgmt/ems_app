import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/widgets/appointment_widget.dart';
import 'package:ems_app/src/widgets/calendar/calendar_widget.dart';
import 'package:flutter/material.dart';

class CalenderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[
          new Calendar(
              appointments: Appointment.demodata,
              onDateSelected: (date) => setState(() => selected = date)),
          new Expanded(
            child: new ListView.builder(
                itemCount: Appointment.demodata.length,
                itemBuilder: _appointmentBuilder),
          ),
        ],
      ),
    );
  }

  Widget _appointmentBuilder(BuildContext context, int index) {
    bool isOldAppointment =
        Appointment.demodata[index].start.isBefore(DateTime.now());
    return isOldAppointment
        ? Container(height: 0.0, width: 0.0)
        : AppointmentWidget(Appointment.demodata[index], selected);
  }
}
