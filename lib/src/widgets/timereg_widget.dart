import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/util/date_utils.dart';
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
            margin: new EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new ListTile(
                      title: new Text(appointment.location),
                      subtitle:
                          new Text(DateUtils.fullDayFormat(appointment.start))),
                  new Divider(),
                  new ListTile(
                      leading:
                          const Text("Start", style: TextStyle(fontSize: 16.0)),
                      title: new Text(DateUtils.asTimeOfDay(appointment.start)
                          .format(context)),
                      onTap: () => onStartChanged(appointment)),
                  new ListTile(
                      leading:
                          const Text("Stop", style: TextStyle(fontSize: 16.0)),
                      title: new Text(DateUtils.asTimeOfDay(appointment.stop)
                          .format(context)),
                      onTap: () => onStopChanged(appointment)),
                  new ListTile(
                      leading:
                          const Text("Break", style: TextStyle(fontSize: 16.0)),
                      title: new Text("${appointment.pause.inMinutes} min"),
                      onTap: () => onPauseChanged(appointment)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
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
