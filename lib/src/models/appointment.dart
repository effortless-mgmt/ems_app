import 'package:ems_app/src/widgets/calendar/calendar_utils.dart';
import 'package:flutter/material.dart';

class Appointment {
  Appointment([this.date, this.location, this.start, this.stop]);

  DateTime date;
  TimeOfDay start, stop;
  String location;
  static List<Appointment> appointments = <Appointment>[
    new Appointment(
        new DateTime(2018, 10, 26),
        "Netto Spot",
        new TimeOfDay(hour: 07, minute: 30),
        new TimeOfDay(hour: 15, minute: 30)),
    new Appointment(
        new DateTime(2018, 10, 27),
        "L'oréal CPD",
        new TimeOfDay(hour: 09, minute: 00),
        new TimeOfDay(hour: 19, minute: 00)),
    new Appointment(
        new DateTime(2018, 10, 28),
        "H&M Incoming",
        new TimeOfDay(hour: 04, minute: 30),
        new TimeOfDay(hour: 13, minute: 00)),
    new Appointment(
        new DateTime(2018, 10, 29),
        "Netto Kolonial",
        new TimeOfDay(hour: 07, minute: 00),
        new TimeOfDay(hour: 15, minute: 00)),
  ];

  static List<Appointment> get demodata => appointments;
}

// class AppointmentWidget extends StatefulWidget {
//   // final ValueChanged<bool> isSelectedUpdate;
//   final Appointment appointment;
//   final bool isSelected;

//   AppointmentWidget(this.appointment, this.isSelected);

//   @override
//   State<StatefulWidget> createState() => _AppointmentWidgetState();
// }

// class _AppointmentWidgetState extends State<AppointmentWidget> {
//   Appointment appointment;
//   bool isSelected;

//   @override
//   initState() {
//     super.initState();
//     appointment = widget.appointment;
//     isSelected = widget.isSelected;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//         trailing: new Text(Utils.fullDayFormat(appointment.date)),
//         leading: new Text(
//             "${appointment.start.format(context)}-${appointment.stop.format(context)}"),
//         title: new Text(appointment.location),
//         selected: isSelected);
//   }
// }

class AppointmentWidget extends StatelessWidget {
  final Appointment appointment;
  final DateTime currentDatetime;

  AppointmentWidget(this.appointment, this.currentDatetime);

  @override
  Widget build(BuildContext context) {
    print("Building appointment listTile");
    return ListTile(
        trailing: new Text(Utils.fullDayFormat(appointment.date)),
        leading: new Text(
            "${appointment.start.format(context)}-${appointment.stop.format(context)}"),
        title: new Text(appointment.location),
        selected: Utils.isSameDay(currentDatetime, appointment.date));
  }
}
