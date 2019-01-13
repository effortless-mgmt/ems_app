import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/appointment_details/testRoute.dart';
import 'package:ems_app/src/screens/appointment_details/widgets.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppbarDescriptive(
      //   department: "test",
      // ),
      appBar: AppBarDescriptive(
          title: Text("Next Appointment"),
          appointment: Appointment.demodata[0],
          context: context),
      // body: RaisedButton(
      //     child: Text("Test"),
      //     onPressed: () => Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => AppointmentDetailsScreen2()))));
    );
  }
}
