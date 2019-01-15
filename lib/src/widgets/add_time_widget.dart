// import 'package:ems_app/src/models/appointment.dart';
// import 'package:ems_app/util/date_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class AddTimeWidget extends ExpansionTile {
//   // final ValueChanged<Appointment> onAccepted;

//   AddTimeWidget(Appointment appointment,
//       {ValueChanged<Appointment> onAccepted,
//       ValueChanged<Appointment> changeStartTime,
//       ValueChanged<Appointment> changeStopTime,
//       ValueChanged<Appointment> changePauseTime,
//       ValueChanged<bool> onExpansionChanged,
//       Color color})
//       : super(
//             leading: DateIcon(date: appointment.start, color: color),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 // Text(DateUtils.fullDayFormat(appointment.start)),
//                 Text("${appointment.location}"),
//                 Text(
//                     "${DateUtils.scheduleTime(appointment.start, appointment.stop)}")
//               ],
//             ),
//             children: <Widget>[
//               ListTile(
//                 title: Text("Start"),
//                 trailing: Text(appointment.startTimeFormatted),
//                 onTap: () => changeStartTime(appointment),
//               ),
//               ListTile(
//                 title: Text("Stop"),
//                 trailing: Text(appointment.stopTimeFormatted),
//                 onTap: () => changeStopTime(appointment),
//               ),
//               ListTile(
//                 title: Text("Pause"),
//                 trailing: Text(appointment.pauseTimeFormatted),
//                 onTap: () => changePauseTime(appointment),
//               ),
//               ButtonBar(
//                 children: <Widget>[
//                   OutlineButton(
//                     child: Text("Accept"),
//                     onPressed: () => onAccepted(appointment),
//                   )
//                 ],
//               ),
//             ],
//             onExpansionChanged: (exp) => onExpansionChanged);
// }
