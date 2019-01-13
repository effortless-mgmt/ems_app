import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/util/date_utils.dart';
import 'package:flutter/material.dart';

class AppBarDescriptive extends AppBar {
  static TextStyle departmentTextStyle = TextStyle(
    // fontFamily: 'Roboto',
    fontSize: 16.0,
    color: Colors.white,
  );

  static TextStyle dateTextStyle = TextStyle(
      color: Colors.white,
      // fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      fontSize: 14.0);

  static TextStyle descriptionTextStyle =
      TextStyle(color: Colors.white, fontSize: 12.0);
  // final TextStyle _salaryTextStyle;

  AppBarDescriptive(
      {Widget title, Appointment appointment, BuildContext context})
      : super(
          title: title,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(200.0),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
              height: 200.0,
              width: double.infinity,
              // color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${appointment.department}", style: departmentTextStyle),
                  Text(
                      "${DateUtils.dateToString(appointment.start)}\n${DateUtils.timeIntervalToString(appointment.start, appointment.stop)}",
                      style: dateTextStyle),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  Text("${appointment.description}",
                      style: descriptionTextStyle),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("${appointment.hourlyWage} kr. / h",
                          style: departmentTextStyle),
                    ],
                  )
                ],
              ),
              // Text("${appointment.department}",
              //     style: _departmentTextStyle),
              // Text("${appointment.description}")
            ),
          ),
        );
  // final String description;
  // final String department;
  // final DateTime start;
  // final Text title;
  // final PreferredSizeWidget bottom;
  // final MaterialColor backgroundColor;

  // AppbarDescriptive(
  //     {this.description,
  //     this.department,
  //     this.start,
  //     this.title,
  //     this.bottom,
  //     this.backgroundColor});

  // Widget build(BuildContext context) {
  //   return AppbarDescriptive(
  //       backgroundColor: Colors.grey,
  //       title: Text("Appointment Details $department"),
  //       bottom: PreferredSize(
  //           preferredSize: Size.fromHeight(200.0),
  //           child: Container(
  //               height: 200.0,
  //               child: Column(
  //                 children: <Widget>[Text("Test1"), Text("Test2")],
  //               ))));
  // }
}
