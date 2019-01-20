import 'package:ems_app/src/models/DEMO/appointment.dart';
import 'package:ems_app/src/screens/appointment_details/appointment_details_screen.dart';
import 'package:ems_app/src/screens/home_screen/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentList extends StatelessWidget {
  final bool upcoming;
  final bool showAll;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<AppointmentDEMO> upcomingShifts = [
    AppointmentDEMO.demodata[0],
    AppointmentDEMO.demodata[1],
    AppointmentDEMO.demodata[2],
    AppointmentDEMO.demodata[3],
  ];

  final List<AppointmentDEMO> availableShifts = [
    AppointmentDEMO.demodata[4],
    AppointmentDEMO.demodata[5],
    AppointmentDEMO.demodata[6],
    AppointmentDEMO.demodata[7]
  ];

  AppointmentList({this.upcoming, this.scaffoldKey, this.showAll});

  @override
  Widget build(BuildContext context) {
    final int count = upcoming ? upcomingShifts.length : availableShifts.length;
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
                await Future.delayed(Duration(milliseconds: 350));
                Navigator.push(
                  context,
                  SlowMaterialPageRoute(
                    builder: (context) {
                      print("INDEX: $index");
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
              child: ListTile(
                leading: DateIcon(date: currentAppointment.start),
                title: Text(currentAppointment.department),
                subtitle: Text(
                    DateFormat.Hm().format(currentAppointment.start) +
                        " - " +
                        DateFormat.Hm().format(currentAppointment.stop)),
                trailing:
                    Text(DateFormat.EEEE().format(currentAppointment.start)),
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
      Divider(height: 2.0),
    ]);
  }
}

class DateIcon extends StatelessWidget {
  final DateTime date;

  DateIcon({this.date});

  @override
  Widget build(BuildContext context) {
    var day = DateFormat.d().format(date);
    var month = DateFormat.MMM().format(date);

    return Container(
      child: Stack(
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: Theme.of(context).iconTheme.color,
            // color: Colors.red.shade500,
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
                    color: Theme.of(context).iconTheme.color,
                    height: 0.75,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  month,
                  textScaleFactor: 0.75,
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    height: 0.75,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // return Container(
    //   child: Stack(
    //     children: <Widget>[
    //       Icon(
    //         Icons.calendar_today,
    //         color: Theme.of(context).primaryColor,
    //         size: 40.0,
    //       ),
    //       Positioned(
    //           top: 0.0,
    //           left: 0.0,
    //           child: Container(color: Colors.white, width: 60, height: 5)),
    //       Container(
    //         margin: EdgeInsets.only(top: 8, left: 4),
    //         height: 29.0,
    //         width: 32.0,
    //         decoration: BoxDecoration(

    //             borderRadius: BorderRadius.circular(2.0),
    //             color: Theme.of(context).canvasColor),
    //       ),
    //       Container(
    //         padding: EdgeInsets.only(top: 12),
    //         width: 40.0,
    //         height: 40.0,
    //         child: Column(
    //           children: <Widget>[
    //             Text(
    //               day,
    //               textScaleFactor: 0.75,
    //               style: TextStyle(
    //                 color: Theme.of(context).accentColor,
    //                 height: 0.75,
    //               ),
    //             ),
    //             Container(height: 4),
    //             Text(
    //               month,
    //               textScaleFactor: 0.75,
    //               style: TextStyle(
    //                 color: Theme.of(context).accentColor,
    //                 height: 0.75,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
