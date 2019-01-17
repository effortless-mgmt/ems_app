import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/appointment_details/appointment_details_screen.dart';
import 'package:ems_app/src/screens/home_screen/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentList extends StatelessWidget {
  final bool upcoming;
  final bool showAll;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<Appointment> upcomingShifts = [
    Appointment.demodata[0],
    Appointment.demodata[1],
    Appointment.demodata[2],
    Appointment.demodata[3],
  ];

  final List<Appointment> availableShifts = [
    Appointment.demodata[4],
    Appointment.demodata[5],
    Appointment.demodata[6],
    Appointment.demodata[7]
  ];

  AppointmentList({this.upcoming, this.scaffoldKey, this.showAll});

  @override
  Widget build(BuildContext context) {
    int count = upcoming ? upcomingShifts.length : availableShifts.length;
    print("COUNT: $count");
    return showAll
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: count,
            itemBuilder: _buildAppointments)
        : Container(
            constraints: BoxConstraints(maxHeight: 200.0),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: _buildAppointments));
  }

  Widget _buildAppointments(BuildContext context, int index) {
    var currentAppointment =
        upcoming ? upcomingShifts[index] : availableShifts[index];
    return Hero(
      tag: upcoming ? "seeUpcoming$index" : "seeAvailable$index",
      child: Stack(
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 300));
                Navigator.push(
                  context,
                  SlowMaterialPageRoute(
                    builder: (context) {
                      return AppointmentDetailsScreen(
                          appointment: currentAppointment,
                          upcoming: upcoming,
                          index: index,
                          scaffoldKey: scaffoldKey);
                    },
                    fullscreenDialog: false,
                  ),
                );
              },
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     SlowMaterialPageRoute(
              //       builder: (context) {
              //         return AppointmentDetailsScreen(
              //             appointment: currentAppointment,
              //             upcoming: upcoming,
              //             index: index,
              //             scaffoldKey: scaffoldKey);
              //       },
              //       fullscreenDialog: false,
              //     ),
              //   );
              // },
              child: ListTile(
                leading: DateIcon(date: currentAppointment.start),
                title: Text(DateFormat.Hm().format(currentAppointment.start) +
                    " - " +
                    DateFormat.Hm().format(currentAppointment.stop)),
                subtitle: Text(currentAppointment.department),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeadingTile extends StatelessWidget {
  final String title;

  HeadingTile({this.title});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(title),
      ),
      Divider(
        height: 0.0,
      ),
    ]);
  }
}

class DateIcon extends StatelessWidget {
  final DateTime date;

  DateIcon({this.date});

  @override
  Widget build(BuildContext context) {
    {
      var day = DateFormat.d().format(date);
      var month = DateFormat.MMM().format(date);

      return Container(
        child: Stack(
          children: <Widget>[
            Icon(
              Icons.calendar_today,
              color: Colors.grey,
              size: 40.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              width: 40.0,
              height: 40.0,
              child: Column(
                children: <Widget>[
                  Text(
                    day,
                    textScaleFactor: 0.75,
                    style: TextStyle(
                      color: Colors.grey,
                      height: 0.75,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    month,
                    textScaleFactor: 0.75,
                    style: TextStyle(
                      color: Colors.grey,
                      height: 0.75,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
