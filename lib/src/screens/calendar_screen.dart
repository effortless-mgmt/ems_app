import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/widgets/appointment_widget.dart';
import 'package:ems_app/src/widgets/calendar/calendar_widget.dart';
import 'package:flutter/material.dart';

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
        Appointment.demodata[index].stop.isBefore(DateTime.now());
    return isOldAppointment
        ? Container(height: 0.0, width: 0.0)
        : AppointmentWidget(
            appointment: Appointment.demodata[index],
            currentDateTime: selected,
            onAppointmentSelected: (app) =>
                setState(() => selected = app.start));
  }
}
