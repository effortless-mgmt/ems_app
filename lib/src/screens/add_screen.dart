import 'package:ems_app/src/widgets/timereg_widget.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  State<StatefulWidget> createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  List<TimeReg> _unregHours = <TimeReg>[
    new TimeReg(
        date: new DateTime(2018, 10, 26),
        location: "Netto Spot",
        start: new TimeOfDay(hour: 09, minute: 00),
        stop: new TimeOfDay(hour: 17, minute: 00),
        pause: 30),
    new TimeReg(
        date: new DateTime(2018, 10, 27),
        location: "H&M Incoming",
        start: new TimeOfDay(hour: 08, minute: 30),
        stop: new TimeOfDay(hour: 16, minute: 30),
        pause: 30),
    new TimeReg(
        date: new DateTime(2018, 10, 28),
        location: "L'oréal CPD Standard",
        start: new TimeOfDay(hour: 06, minute: 00),
        stop: new TimeOfDay(hour: 14, minute: 30),
        pause: 30),
    new TimeReg(
        date: new DateTime(2018, 10, 29),
        location: "Netto Kolonial",
        start: new TimeOfDay(hour: 07, minute: 30),
        stop: new TimeOfDay(hour: 15, minute: 30),
        pause: 30)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new ListView.builder(
            itemCount: _unregHours.length,
            itemBuilder: (BuildContext context, int index) =>
                _unregHours[index]));
  }
}
