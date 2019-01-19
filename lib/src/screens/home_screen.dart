import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/home_screen/all_shifts_screen.dart';
import 'package:ems_app/src/screens/home_screen/appointment_list.dart';
import 'package:ems_app/src/screens/home_screen/page_routes.dart';
import 'package:ems_app/src/screens/home_screen/show_all_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Appointment> upcomingShifts = [
    Appointment.demodata[0],
    Appointment.demodata[1],
    Appointment.demodata[2],
    Appointment.demodata[3],
  ];

  final List<Appointment> availableShifts = [
    Appointment.demodata[3],
    Appointment.demodata[4],
    Appointment.demodata[5],
    Appointment.demodata[6]
  ];

  bool tapped;

  @override
  void initState() {
    super.initState();
    tapped = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(title: Text("Overview")),
        body: ListView(
          children: <Widget>[
            _shiftCard(context, true),
            _shiftCard(context, false)
          ],
        ));
  }

  Widget _shiftCard(context, bool upcoming) {
    final activateShowAll =
        upcoming ? upcomingShifts.length > 3 : availableShifts.length > 3;

    return Hero(
      tag: upcoming ? "seeAllUpcoming" : "seeAllAvailable",
      child: Card(
        // margin: null,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                HeadingTile(
                    title: upcoming ? "Upcoming Shifts" : "Available Shifts"),
                AppointmentList(
                    upcoming: upcoming,
                    scaffoldKey: scaffoldKey,
                    showAll: false),
                activateShowAll
                    ? ShowAllButton(
                        tapped: tapped,
                        upcoming: upcoming,
                        onTap: () async {
                          setState(() {
                            tapped = true;
                          });
                          await Future.delayed(Duration(milliseconds: 200));
                          Navigator.push(
                            context,
                            SlowMaterialPageRoute(
                              builder: (context) =>
                                  AllShiftsScreen(upcoming: upcoming),
                              fullscreenDialog: false,
                            ),
                          ).then((value) {
                            tapped = false;
                          });
                        })
                    : Container(height: 16.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//########################################
//#####Sebastian wanted to keep this######
//########################################

// class ShiftItem extends ListItem {
//   final Appointment appointment;

//   ShiftItem.protected(this.appointment);

// factory ShiftItem.fromJson(Map<dynamic, dynamic> json) {
// Appointment appointment = Appointment();
// appointment.start = DateTime.parse(json["shiftStart"]);
// appointment.stop = DateTime.parse(json["shiftStart"]);
// appointment.department = json["department"];
// appointment.address = json["address"];
// appointment.description = json["description"];
// appointment.hourlyWage = json["salary"];

// if (json["type"] == "available") {
//   return AvailableShift(appointment: appointment);
// } else if (json["type"] == "upcoming") {
//   return UpcomingShift(
//     status: json["status"],
//     appointment: appointment,
//   );
// } else {
//   return null;
// }
// }
