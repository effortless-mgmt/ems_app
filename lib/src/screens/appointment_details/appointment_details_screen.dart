import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/appointment_details/maps.dart';
import 'package:ems_app/src/screens/appointment_details/testRoute.dart';
import 'package:ems_app/src/screens/appointment_details/appBarDescriptive.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final bool isJobOffer;

  AppointmentDetailsScreen({@required this.isJobOffer});

  @override
  State<StatefulWidget> createState() => new _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetailsScreen> {
  Appointment _appointment = Appointment.demodata[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDescriptive(
          title: Text("Next Appointment"), appointment: _appointment),
      body: Maps(address: _appointment.address),
      // body: RaisedButton(
      //     child: Text("Test"),
      //     onPressed: () => Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => AppointmentDetailsScreen2()))));
    );
  }
}
