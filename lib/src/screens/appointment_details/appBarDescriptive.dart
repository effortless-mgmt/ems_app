import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/util/date_utils.dart';
import 'package:flutter/material.dart';

class AppBarDescriptive extends SliverAppBar {
  static TextStyle titleTextStyle =
      TextStyle(fontSize: 16.0, color: Colors.white);

  static TextStyle subTitleTextStyle = TextStyle(
      color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14.0);

  static TextStyle bodyTextStyle =
      TextStyle(color: Colors.white, fontSize: 12.0);

  AppBarDescriptive({Widget title, Appointment appointment})
      : super(
          expandedHeight: 200.0,
          pinned: true,
          title: title,
          forceElevated: true, // Make so that it is elevated when scrolled
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                height: 168.0,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${appointment.department}", style: titleTextStyle),
                    Text(
                        "${DateUtils.dateToString(appointment.start)}\n${DateUtils.timeIntervalToString(appointment.start, appointment.stop)}",
                        style: subTitleTextStyle),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
                    Text("${appointment.description}", style: bodyTextStyle),
                    Padding(padding: const EdgeInsets.only(top: 8.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("${appointment.hourlyWage} kr. / h",
                              style: titleTextStyle),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
}

/*########################################### 
  STANDARD APP BAR IMPLEMENTATION. FUNCTIONAL 
  ########################################### */

// class AppBarDescriptive extends AppBar {
//   static TextStyle titleTextStyle =
//       TextStyle(fontSize: 16.0, color: Colors.white);

//   static TextStyle subTitleTextStyle = TextStyle(
//       color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14.0);

//   static TextStyle bodyTextStyle =
//       TextStyle(color: Colors.white, fontSize: 12.0);

//   AppBarDescriptive({Widget title, Appointment appointment})
//       : super(
//           title: title,
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(168.0),
//             child: Container(
//               padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
//               height: 168.0,
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text("${appointment.department}", style: titleTextStyle),
//                   Text(
//                       "${DateUtils.dateToString(appointment.start)}\n${DateUtils.timeIntervalToString(appointment.start, appointment.stop)}",
//                       style: subTitleTextStyle),
//                   Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
//                   Text("${appointment.description}", style: bodyTextStyle),
//                   Padding(padding: const EdgeInsets.only(top: 8.0)),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       Container(
//                         padding: const EdgeInsets.only(bottom: 8.0),
//                         child: Text("${appointment.hourlyWage} kr. / h",
//                             style: titleTextStyle),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
// }
