import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'dart:async';

class TimeReg extends StatefulWidget {
  final DateTime date;
  final String location;
  final TimeOfDay start;
  final TimeOfDay stop;
  final int pause;

  TimeReg(
      {Key key, this.date, this.location, this.start, this.stop, this.pause})
      : super(key: key);
  State<StatefulWidget> createState() => _TimeRegState();
}

class _TimeRegState extends State<TimeReg> {
  TextStyle _headerStyle =
      new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);

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
    print("Start selected: ${picked.toString()}");
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
    _wh = new WorkHours(stop.difference(start).inMinutes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          margin: new EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(
                      _weekDays[widget.date.weekday - 1] +
                          " " +
                          widget.date.day.toString(),
                      style: _headerStyle),
                  new Text(" " + widget.location, style: _headerStyle),
                ],
              ),
              new Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0)),
              // new Divider(height: 26.0),
              new ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  // dense: true,
                  leading:
                      const Text("Start:", style: TextStyle(fontSize: 16.0)),
                  title: new Text(_start.format(context)),
                  onTap: () => _selectStart(context)),
              new ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  // dense: true,
                  leading:
                      const Text("Stop:", style: TextStyle(fontSize: 16.0)),
                  title: new Text(_stop.format(context)),
                  onTap: () => _selectStop(context)),
              new ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  // dense: true,
                  leading:
                      const Text("Break:", style: TextStyle(fontSize: 16.0)),
                  title: new Text(" " + _pause.toString() + " MIN"),
                  onTap: () => _selectPause(context)),

              // new GestureDetector(
              //     onTap: () => _selectStart(context),
              //     child: new Row(children: <Widget>[
              //       new Text("Start"),
              //       new Container(
              //           padding: const EdgeInsets.symmetric(horizontal: 10.0)),
              //       new Text(_start.format(context)),
              //     ])),
              // new Container(padding: const EdgeInsets.symmetric(vertical: 5.0)),
              // new Divider(height: 26.0),
              // new GestureDetector(
              //   onTap: () => _selectStop(context),
              //   child: new Row(children: <Widget>[
              //     new Text("Stop"),
              //     new Container(
              //         padding: const EdgeInsets.symmetric(horizontal: 10.0)),
              //     new Text(_stop.format(context)),
              //   ]),
              // ),
              // new Divider(height: 26.0),

              // new Container(padding: const EdgeInsets.symmetric(vertical: 5.0)),
              // new Row(children: <Widget>[
              //   new Text("Break"),
              //   new Container(
              //       padding: const EdgeInsets.symmetric(horizontal: 10.0)),
              //   new Text(_pause.toString() + " min"),
              // ]),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 8.0, right: 2.0),
                      width: 40.0,
                      child: new FloatingActionButton(
                        backgroundColor: Colors.blueAccent,
                        child: new Icon(Icons.check,
                            size: 20.0, color: Colors.white),
                        onPressed: () {
                          _regTime();
                          debugPrint(
                              "Registered: ${_wh.getHours()}h ${_wh.getMinutes()}m");
                        },
                      ),
                    )
                  ])
            ],
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

  WorkHours(int _durationMinutes) {
    this._durationMinutes = _durationMinutes;
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
}
