import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/home_screen/appointment_list.dart';
import 'package:flutter/material.dart';

class AllShiftsScreen extends StatefulWidget {
  final bool upcoming;
  final List<Appointment> appointments;

  AllShiftsScreen({this.upcoming, this.appointments});
  @override
  State<StatefulWidget> createState() => _AllShiftsScreenState();
}

class _AllShiftsScreenState extends State<AllShiftsScreen> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool upcoming;
  bool buildComplete;
  @override
  void initState() {
    super.initState();
    buildComplete = false;
    upcoming = widget.upcoming;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => setState(() => buildComplete = true));
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: upcoming ? "seeAllUpcoming" : "seeAllAvailable",
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
              iconTheme: Theme.of(context).accentIconTheme,
              title: upcoming
                  ? Text("Upcoming Appointments")
                  : Text("Available Appointments")),
          body: buildComplete
              ? AppointmentList(
                  upcoming: upcoming,
                  showAll: true,
                  scaffoldKey: scaffoldKey,
                  appointments: widget.appointments)
              : Container(),
        ));
  }
}
