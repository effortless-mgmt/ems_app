import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'dart:async';

// TODO
// 1. HEADLINE
// 2. SNACKBAR ON ACCEPT (UNDO FUNCTION)
// 3. REMOVE ITEM WITH ANIMATION ON ACCEPT
// 4. CUPERTINO TIME PICKERS

class TimeReg extends StatefulWidget {
  final DateTime date;
  final String location;
  final TimeOfDay start;
  final TimeOfDay stop;
  final int pause;
  final AnimationController animationController;
  final VoidCallback onAccepted;

  TimeReg(
      {Key key,
      @required this.date,
      @required this.location,
      @required this.start,
      @required this.stop,
      @required this.pause,
      @required this.animationController,
      this.onAccepted})
      : assert(date != null),
        assert(location != null),
        assert(start != null),
        assert(stop != null),
        assert(pause != null),
        assert(animationController != null),
        super(key: key);

  State<StatefulWidget> createState() => _TimeRegState();
}

class _TimeRegState extends State<TimeReg> {
  DateTime _date;
  TimeOfDay _start;
  TimeOfDay _stop;
  int _pause;
  WorkHours _wh;

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
    _date = widget.date;
    _start = widget.start;
    _stop = widget.stop;
    _pause = widget.pause;
  }

  Future<Null> _selectStart(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _start,
    );
    debugPrint("Start selected: ${picked.toString()}");
    if (picked != _start && picked != null) {
      setState(() {
        _start = picked;
      });
    }
  }

  Future<Null> _selectStop(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _stop,
    );
    print("Stop selected: ${picked.toString()}");
    if (picked != _stop && picked != null) {
      setState(() {
        _stop = picked;
      });
    }
  }

  Future<Null> _selectPause(BuildContext context) async {
    final Duration picked = await showDurationPicker(
      context: context,
      initialTime: new Duration(minutes: _pause),
    );
    print("Pause selected: ${picked.toString()}");
    if (picked.inMinutes != _pause && picked != null) {
      setState(() {
        _pause = picked.inMinutes;
      });
    }
  }

  void _regTime() {
    DateTime start = new DateTime(
        _date.year, _date.month, _date.day, _start.hour, _start.minute);
    DateTime stop = new DateTime(
        _date.year, _date.month, _date.day, _stop.hour, _stop.minute);
    if (stop.hour < start.hour) {
      debugPrint("Stops next day");
      debugPrint("Stop before adding day: ${stop.toString()}");

      stop = stop.add(new Duration(days: 1));
      debugPrint("Start DateTime: ${start.toString()}");
      debugPrint("Stop DateTime: ${stop.toString()}");
    }
    stop = stop.subtract(new Duration(minutes: _pause));
    _wh = new WorkHours(stop.difference(start).inMinutes, widget.date);
    debugPrint("Registered: ${_wh.getHours()}h ${_wh.getMinutes()}m");
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
                      subtitle: new Text(_weekDays[widget.date.weekday - 1] +
                          " " +
                          getDateFormatted())),
                  new ListTile(
                      leading:
                          const Text("From", style: TextStyle(fontSize: 16.0)),
                      title: new Text(_start.format(context)),
                      onTap: () => _selectStart(context)),
                  new ListTile(
                      leading:
                          const Text("To", style: TextStyle(fontSize: 16.0)),
                      title: new Text(_stop.format(context)),
                      onTap: () => _selectStop(context)),
                  new ListTile(
                      leading:
                          const Text("Break", style: TextStyle(fontSize: 16.0)),
                      title: new Text(" " + _pause.toString() + " min"),
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

class WorkHours {
  int _durationMinutes;
  int _minutes = 0;
  double _hours = 0.0;
  DateTime _date;

  WorkHours(int durationMinutes, DateTime date) {
    this._durationMinutes = durationMinutes;
    this._date = date;
    convertHours();
  }

  void convertHours() {
    _minutes = _durationMinutes % 60;
    _hours = (_durationMinutes - _minutes) / 60;
  }

  int getHours() {
    return _hours.toInt();
  }

  int getMinutes() {
    return _minutes;
  }

  int getDurationMinutes() {
    return _durationMinutes;
  }

  String getDateFormatted() {
    return "${_date.day}-${_date.month}-${_date.year}";
  }
}
