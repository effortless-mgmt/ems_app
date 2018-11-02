import 'package:ems_app/src/models/workperiod.dart';
import 'package:ems_app/src/widgets/calendar/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:duration/duration.dart';
import 'dart:async';

// TODO
// 1. IMPLEMENT BLOC
// 2. REMOVE ITEM WITH ANIMATION ON ACCEPT
// 3. CUPERTINO TIME PICKERS

class TimeReg extends StatefulWidget {
  final DateTime start, stop;
  final String location;
  final Duration pause;
  final AnimationController animationController;
  final VoidCallback onAccepted;

  TimeReg(
      {Key key,
      @required this.location,
      @required this.start,
      @required this.stop,
      @required this.pause,
      @required this.animationController,
      this.onAccepted})
      : assert(location != null),
        assert(start != null),
        assert(stop != null),
        assert(pause != null),
        assert(animationController != null),
        super(key: key);

  State<StatefulWidget> createState() => _TimeRegState();
}

class _TimeRegState extends State<TimeReg> {
  DateTime _date;
  DateTime _start, _stop;
  TimeOfDay _startTime, _stopTime;
  Duration _pause;
  WorkPeriod _wh;

  final List<String> _weekDays = <String>[
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];

  @override
  void initState() {
    super.initState();
    _start = widget.start;
    _stop = widget.stop;
    _pause = widget.pause;
    _startTime = Utils.asTimeOfDay(_start);
    _stopTime = Utils.asTimeOfDay(_stop);
  }

  Future<Null> _selectStart(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context, initialTime: Utils.asTimeOfDay(_start));
    debugPrint("Start selected: ${picked.toString()}");
    if (picked != _startTime && picked != null) {
      setState(() {
        _startTime = picked;
        _start = Utils.changeTime(_start, _startTime);
      });
    }
  }

  Future<Null> _selectStop(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _stopTime);
    print("Stop selected: ${picked.toString()}");
    if (picked != _stopTime && picked != null) {
      setState(() {
        _stopTime = picked;
        _stop = Utils.changeTime(_start, _stopTime);
      });
    }
  }

  Future<Null> _selectPause(BuildContext context) async {
    final Duration picked = await showDurationPicker(
      context: context,
      initialTime: _pause,
    );
    print("Pause selected: ${picked.toString()}");
    if (picked != _pause && picked != null) {
      setState(() {
        _pause = picked;
      });
    }
  }

  void _regTime() {
    if (_stop.hour < _start.hour) {
      debugPrint("Stops next day");
      debugPrint("Stop before adding day: ${_stop.toString()}");

      _stop = _stop.add(new Duration(days: 1));
      debugPrint("Start DateTime: ${_start.toString()}");
      debugPrint("Stop DateTime: ${_stop.toString()}");
    }
    _wh = new WorkPeriod(_start, _stop, _pause);
    printDuration(_wh.duration, abbreviated: true);
  }

  String getDateFormatted() {
    return "${_date.day}-${_date.month}-${_date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      // axis: Axis.horizontal,
      sizeFactor: new CurvedAnimation(
          parent: widget.animationController, curve: Curves.linear),
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
                      title: new Text(widget.location),
                      subtitle: new Text(_weekDays[widget.start.weekday - 1] +
                          " " +
                          Utils.fullDayFormat(_start))),
                  new ListTile(
                      leading:
                          const Text("Start", style: TextStyle(fontSize: 16.0)),
                      title:
                          new Text(Utils.asTimeOfDay(_start).format(context)),
                      onTap: () => _selectStart(context)),
                  new ListTile(
                      leading:
                          const Text("Stop", style: TextStyle(fontSize: 16.0)),
                      title: new Text(Utils.asTimeOfDay(_stop).format(context)),
                      onTap: () => _selectStop(context)),
                  new ListTile(
                      leading:
                          const Text("Break", style: TextStyle(fontSize: 16.0)),
                      title: new Text("${_pause.inMinutes} min"),
                      onTap: () => _selectPause(context)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new MaterialButton(
                          child: new Text("Accept",
                              style: new TextStyle(color: Colors.blueAccent)),
                          onPressed: () {
                            _regTime();
                            widget.onAccepted();
                          }),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
