import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/util/date_utils.dart';

class AddTimeWidget extends StatefulWidget {
  final ValueChanged<Appointment> onAccepted;
  final ValueChanged<Appointment> changeStartTime;
  final ValueChanged<Appointment> changeStopTime;
  final ValueChanged<Appointment> changePauseTime;
  final ValueChanged<bool> onExpansionChanged;
  final bool expanded;
  final Appointment appointment;
  // final Color color;

  AddTimeWidget({
    this.expanded,
    this.onAccepted,
    this.changeStartTime,
    this.changeStopTime,
    this.onExpansionChanged,
    this.changePauseTime,
    this.appointment,
    // this.color,
  });

  @override
  State<StatefulWidget> createState() => _AddTimeWidgetState();
}

class _AddTimeWidgetState extends State<AddTimeWidget> {
  // Color color;
  ValueChanged<bool> onExpansionChanged;
  bool _expanded;
  ThemeData theme;
  TextTheme textTheme;
  IconThemeData iconTheme;

  @override
  void initState() {
    super.initState();
    _expanded = false;
    onExpansionChanged = widget.onExpansionChanged;
    _expanded = widget.expanded;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    textTheme = Theme.of(context).textTheme;
    iconTheme = Theme.of(context).iconTheme;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: _expanded,
      leading: DateIcon(
          date: widget.appointment.start,
          color: _expanded ? theme.accentColor : iconTheme.color),
      // title: ListTile(
      //     title: Text("${widget.appointment.department}",
      //         style: TextStyle(
      //             color: _expanded
      //                 ? Theme.of(context).accentColor
      //                 : Theme.of(context).textTheme.subhead.color)),
      //     subtitle: Text(
      //         "${DateUtils.scheduleTimeFormat(widget.appointment.start, widget.appointment.stop)}",
      //         style: TextStyle(
      //             color: _expanded
      //                 ? Theme.of(context).accentColor
      //                 : Theme.of(context)
      //                     .textTheme
      //                     .subhead
      //                     .color
      //                     .withAlpha(150)))),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${widget.appointment.department}",
              style: TextStyle(
                  color:
                      _expanded ? theme.accentColor : textTheme.subhead.color,
                  fontSize: textTheme.subhead.fontSize)),
          _expanded
              ? Container(height: 0.0)
              : Text(
                  "${DateUtils.scheduleTimeFormat(widget.appointment.start, widget.appointment.stop)}",
                  style: TextStyle(
                      color: _expanded
                          ? theme.accentColor.withAlpha(100)
                          : textTheme.subhead.color.withAlpha(100),
                      fontSize: textTheme.subtitle.fontSize)),
        ],
      ),
      children: <Widget>[
        ListTile(
          // leading: Container(width: 56),
          leading: Container(child: Icon(Icons.access_time)),
          title: Text("Start"),
          trailing: Text(widget.appointment.startTimeFormatted),
          onTap: () => widget.changeStartTime(widget.appointment),
        ),
        ListTile(
          // leading: Container(width: 56),
          leading: Container(child: Icon(Icons.access_time)),
          title: Text("Stop"),
          trailing: Text(widget.appointment.stopTimeFormatted),
          onTap: () => widget.changeStopTime(widget.appointment),
        ),
        ListTile(
          // leading: Container(width: 56),
          leading: Container(child: Icon(Icons.access_time)),
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
      onExpansionChanged: (expanded) => setState(() {
            // expanded
            //     ? color = Theme.of(context).accentColor
            //     : color = Theme.of(context).iconTheme.color;
            _expanded = expanded;
            widget.onExpansionChanged(expanded);
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
                    // fontWeight: FontWeight.bold,
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
