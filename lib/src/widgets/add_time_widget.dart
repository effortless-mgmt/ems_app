import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/util/date_utils.dart';
import 'package:flutter/material.dart';

class AddTimeWidget extends ExpansionTile {
  // final ValueChanged<Appointment> onAccepted;

  AddTimeWidget(Appointment appointment, {
    ValueChanged<Appointment> onAccepted,
    ValueChanged<Appointment> changeStartTime,
    ValueChanged<Appointment> changeStopTime,
    ValueChanged<Appointment> changePauseTime
    })
      : super(title: Text(appointment.location), children: <Widget>[
          ListTile(
            title: Text("Start"),
            trailing: Text(appointment.startTimeFormatted),
            onTap: () => changeStartTime(appointment),
          ),
          ListTile(
            title: Text("Stop"),
            trailing: Text(appointment.stopTimeFormatted),
            onTap: () => changeStopTime(appointment),
          ),
          ListTile(
            title: Text("Pause"),
            trailing: Text(appointment.pauseTimeFormatted),
            onTap: () => changePauseTime(appointment),
          ),
          ButtonBar(
            children: <Widget>[
              OutlineButton(
                child: Text("Accept"),
                onPressed: () => onAccepted(appointment),
              )
            ],
          ),
        ]);
}
