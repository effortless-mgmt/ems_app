import 'package:ems_app/src/screens/home_screen/appointment_list.dart';
import 'package:flutter/material.dart';

class AllShiftsScreen extends StatelessWidget {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final bool upcoming;

  AllShiftsScreen({this.upcoming});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: upcoming ? "seeAllUpcoming" : "seeAllAvailable",
        child: Scaffold(
          // key: scaffoldKey,
          appBar: AppBar(
              title: upcoming
                  ? Text("Upcoming Appointments")
                  : Text("Available Appointments")),
          body: new AppointmentList(upcoming: upcoming, showAll: true),
        ));
  }
}
