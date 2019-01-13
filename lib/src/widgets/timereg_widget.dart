import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/util/date_utils.dart';
import 'package:flutter/material.dart';

// TODO
// 1. CUPERTINO TIME PICKERS

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
    return SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.linear),
      child: Container(
        margin: new EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Card(
          elevation: 4.0,
          child: Container(
            margin: new EdgeInsets.only(
                top: 12.0, left: 12.0, right: 12.0, bottom: 12.0),
            child: new Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new ListTile(
                      title: new Text(appointment.location),
                      subtitle:
                          new Text(DateUtils.fullDayFormat(appointment.start))),
                  new Divider(height: 0.0),
                  new ListTile(
                      leading:
                          const Text("Start", style: TextStyle(fontSize: 16.0)),
                      trailing: new Text(
                          DateUtils.asTimeOfDay(appointment.start)
                              .format(context)),
                      onTap: () => onStartChanged(appointment)),
                  new Divider(height: 0.0),
                  new ListTile(
                      leading:
                          const Text("Stop", style: TextStyle(fontSize: 16.0)),
                      trailing: new Text(DateUtils.asTimeOfDay(appointment.stop)
                          .format(context)),
                      onTap: () => onStopChanged(appointment)),
                  new Divider(height: 0.0),
                  new ListTile(
                      leading:
                          const Text("Break", style: TextStyle(fontSize: 16.0)),
                      trailing: new Text("${appointment.pause.inMinutes} min"),
                      onTap: () => onPauseChanged(appointment)),
                  new Divider(height: 0.0),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Container(width: 100.0),
                      new MaterialButton(
                          child: new Text("Accept",
                              style: new TextStyle(color: Colors.blueAccent)),
                          onPressed: () => onAccepted(appointment)),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
