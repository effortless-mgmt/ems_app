import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/util/date_utils.dart';
import 'package:flutter/material.dart';

class LargeTime extends StatelessWidget {
  final int time;
  final String trailing;
  final appendZero;

  LargeTime(this.time, this.trailing, {this.appendZero: false});

  Widget build(BuildContext context) {
    String timeFormatted = appendZero
        ? this.time.toString().padLeft(2, "0")
        : this.time.toString();
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(timeFormatted, style: Theme.of(context).textTheme.headline),
        Text(this.trailing),
      ],
    );
  }
}

/// Large time diplay used as `leading` to the `Card`.
// class TimeDisplay extends StatelessWidget {
//   final Appointment appointment;

//   TimeDisplay(this.appointment);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//             children: <Widget>[
//               LargeTime(this.appointment.durationHour, "h"),
//               LargeTime(this.appointment.durationMinute, "m", appendZero: true,)
//             ],
//       ),
//     );
//   }
// }

class TimeContainer extends StatelessWidget {
  final Appointment appointment;

  TimeContainer({this.appointment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("Start", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(this.appointment.startTimeFormatted)
          ],
        ),
        Column(
          children: <Widget>[
            Text("Stop", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(this.appointment.stopTimeFormatted)
          ],
        ),
        Column(
          children: <Widget>[
            Text("Break", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(this.appointment.pauseTimeFormatted)
          ],
        ),
      ],
    );
  }
}

/// Registration item used in the `add_screen`.
class TimeReg extends StatelessWidget {
  final Appointment appointment;
  final AnimationController animationController;
  final ValueChanged<Appointment> onAccepted;
  final ValueChanged<Appointment> onStartChanged;
  final ValueChanged<Appointment> onStopChanged;
  final ValueChanged<Appointment> onPauseChanged;

  TimeReg(
      {Key key,
      this.appointment,
      this.animationController,
      this.onAccepted,
      this.onStartChanged,
      this.onStopChanged,
      this.onPauseChanged});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: <Widget>[
    //     Container(color: Colors.amber,),
    //     Container()
    // ],);
    return Center(
      child:
          // Card(
          //   child: Row(
          //     children: <Widget>[
          //       TimeDisplay(this.appointment),
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Container(
          //             child: Column(
          //               children: <Widget>[
          //                 Text(this.appointment.location, style: Theme.of(context).textTheme.subhead),
          //                 Text(this.appointment.startDateIso, style: Theme.of(context).textTheme.caption,),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          //             child: Text("Main Content")
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          // Card(
          //   child:
          ExpansionTile(
        title: Column(children: <Widget>[
          ListTile(
            leading: SizedBox(
              width: 64,
              child: Text(
                  // this.appointment.durationFormatted,
                  "24h 00m"),
            ),
            title: Text(this.appointment.location),
            subtitle: Text(this.appointment.startDateIso),
            trailing: Column(
              children: <Widget>[
                Text(this.appointment.startTimeFormatted),
                Text(this.appointment.stopTimeFormatted),
              ],
            ),
          ),
          // Divider()
        ]),
        children: <Widget>[
          ListTile(
            title: Text("Start"),
            trailing: Text(this.appointment.startTimeFormatted),
            onTap: () => onStartChanged(appointment),
          ),
          ListTile(
            title: Text("Stop"),
            trailing: Text(this.appointment.stopTimeFormatted),
            onTap: () => onStopChanged(appointment),
          ),
          ListTile(
            title: Text("Break"),
            trailing: Text(this.appointment.pauseTimeFormatted),
            onTap: () => onPauseChanged(appointment),
          ),
          ButtonBar(
            children: <Widget>[
              // OutlineButton(
              //   child: Text("Cancel"),
              //   // textColor: Colors.red,
              //   onPressed: () => {},
              // ),
              OutlineButton(
                child: Text("Accept"),
                color: Theme.of(context).accentColor,
                splashColor: Colors.lightGreen,
                onPressed: () => onAccepted(appointment),
              ),
            ],
          )
        ],
      ),
    );
    // );

    // return Center(
    //   child: Card(

    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         ListTile(
    //           leading: TimeDisplay(this.appointment,),
    //           title: Text(this.appointment.location),
    //           subtitle: Text(this.appointment.startDateIso),

    //         ),
    //         TimeContainer(appointment: this.appointment),
    //         Container(height: 18),
    //       ],
    //     ),
    //   )
    // );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SizeTransition(
  //     sizeFactor: new CurvedAnimation(
  //         parent: animationController, curve: Curves.linear),
  //     child: Container(
  //       margin: new EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
  //       child: Card(
  //         elevation: 4.0,
  //         child: Container(
  //           margin: new EdgeInsets.only(
  //               top: 12.0, left: 12.0, right: 12.0, bottom: 12.0),
  //           child: new Column(
  //               // crossAxisAlignment: CrossAxisAlignment.center,
  //               children: <Widget>[
  //                 new ListTile(
  //                     title: new Text(appointment.location),
  //                     subtitle:
  //                         new Text(DateUtils.fullDayFormat(appointment.start))),
  //                 new Divider(height: 0.0),
  //                 new ListTile(
  //                     leading:
  //                         const Text("Start", style: TextStyle(fontSize: 16.0)),
  //                     trailing: new Text(
  //                         DateUtils.asTimeOfDay(appointment.start)
  //                             .format(context)),
  //                     onTap: () => onStartChanged(appointment)),
  //                 new Divider(height: 0.0),
  //                 new ListTile(
  //                     leading:
  //                         const Text("Stop", style: TextStyle(fontSize: 16.0)),
  //                     trailing: new Text(DateUtils.asTimeOfDay(appointment.stop)
  //                         .format(context)),
  //                     onTap: () => onStopChanged(appointment)),
  //                 new Divider(height: 0.0),
  //                 new ListTile(
  //                     leading:
  //                         const Text("Break", style: TextStyle(fontSize: 16.0)),
  //                     trailing: new Text("${appointment.pause.inMinutes} min"),
  //                     onTap: () => onPauseChanged(appointment)),
  //                 new Divider(height: 0.0),
  //                 new Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: <Widget>[
  //                     new Container(width: 100.0),
  //                     new MaterialButton(
  //                         child: new Text("Accept",
  //                             style: new TextStyle(color: Colors.blueAccent)),
  //                         onPressed: () => onAccepted(appointment)),
  //                   ],
  //                 ),
  //               ]),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
