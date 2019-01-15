import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/util/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTimeWidget extends StatefulWidget {
  final ValueChanged<Appointment> onAccepted;
  final ValueChanged<Appointment> changeStartTime;
  final ValueChanged<Appointment> changeStopTime;
  final ValueChanged<Appointment> changePauseTime;
  final Appointment appointment;
  final Color color;

  AddTimeWidget({
    this.onAccepted,
    this.changeStartTime,
    this.changeStopTime,
    this.changePauseTime,
    this.appointment,
    this.color,
  });

  @override
  State<StatefulWidget> createState() => _AddTimeWidgetState();
}

class _AddTimeWidgetState extends State<AddTimeWidget> {
  Color color;

  @override
  void initState() {
    super.initState();
    color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: DateIcon(date: widget.appointment.start, color: color),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${widget.appointment.location}"),
          Text(
              "${DateUtils.scheduleTime(widget.appointment.start, widget.appointment.stop)}")
        ],
      ),
      children: <Widget>[
        ListTile(
          title: Text("Start"),
          trailing: Text(widget.appointment.startTimeFormatted),
          onTap: () => widget.changeStartTime(widget.appointment),
        ),
        ListTile(
          title: Text("Stop"),
          trailing: Text(widget.appointment.stopTimeFormatted),
          onTap: () => widget.changeStopTime(widget.appointment),
        ),
        ListTile(
          title: Text("Pause"),
          trailing: Text(widget.appointment.pauseTimeFormatted),
          onTap: () => widget.changePauseTime(widget.appointment),
        ),
        ButtonBar(
          children: <Widget>[
            OutlineButton(
              child: Text("Accept"),
              onPressed: () => widget.onAccepted(widget.appointment),
            )
          ],
        ),
      ],
      onExpansionChanged: (col) => setState(() {
            print("Expanded");
            col ? color = Theme.of(context).accentColor : color = Colors.grey;
          }),
    );
  }
}

class DateIcon extends StatelessWidget {
  final DateTime date;
  final Color color;
  DateIcon({this.date, this.color});

  @override
  Widget build(BuildContext context) {
    var day = DateFormat.d().format(date);
    var month = DateFormat("EEE").format(date);
    return Container(
      child: Stack(
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: color,
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
                    color: color,
                    height: 0.75,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  month,
                  textScaleFactor: 0.75,
                  style: TextStyle(
                    color: color,
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
  }
}
