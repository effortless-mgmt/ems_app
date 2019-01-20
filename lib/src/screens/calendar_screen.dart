import 'package:flutter/material.dart';

import 'package:ems_app/src/models/DEMO/appointment.dart';
import 'package:ems_app/src/widgets/appointment_widget.dart';
import 'package:ems_app/src/widgets/calendar/calendar_widget.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selected;

  @override
  void initState() {
    super.initState();
    selected = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendar")),
      body: new Column(
        children: <Widget>[
          new Calendar(
              selectedDate: selected,
              appointments: AppointmentDEMO.demodata,
              onDateSelected: (date) => setState(() => selected = date)),
          new Expanded(
            child: new ListView.builder(
                itemCount: AppointmentDEMO.demodata.length,
                itemBuilder: _appointmentBuilder),
          ),
        ],
      ),
    );
  }

  Widget _appointmentBuilder(BuildContext context, int index) {
    bool isOldAppointment =
        AppointmentDEMO.demodata[index].stop.isBefore(DateTime.now());
    return isOldAppointment
        ? Container(height: 0.0, width: 0.0)
        : AppointmentWidget(
            appointment: AppointmentDEMO.demodata[index],
            currentDateTime: selected,
            onAppointmentSelected: (app) =>
                setState(() => selected = app.start));
  }
}
