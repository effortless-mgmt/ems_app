import 'package:flutter/material.dart';

class TimeReg extends StatefulWidget {
  final DateTime date;
  final String location;
  final TimeOfDay start;
  final TimeOfDay stop;
  final int pause;

  const TimeReg(
      {Key key, this.date, this.location, this.start, this.stop, this.pause})
      : super(key: key);
  State<StatefulWidget> createState() => _TimeRegState();
}

class _TimeRegState extends State<TimeReg> {
  TextStyle _headerStyle =
      new TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500);

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
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          margin: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
              new Divider(),

              new Row(children: <Widget>[
                new Text("Start"),
                new Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0)),
                new Text(widget.start.format(context)),
              ]),
              // new Container(padding: const EdgeInsets.symmetric(vertical: 5.0)),
              new Divider(height: 20.0),

              new Row(children: <Widget>[
                new Text("Stop"),
                new Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0)),
                new Text(widget.stop.format(context)),
              ]),
              new Divider(height: 20.0),

              // new Container(padding: const EdgeInsets.symmetric(vertical: 5.0)),
              new Row(children: <Widget>[
                new Text("Break"),
                new Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0)),
                new Text(widget.pause.toString() + " min"),
              ]),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 40.0,
                      child: new FloatingActionButton(
                          backgroundColor: Colors.blueAccent,
                          child: new Icon(Icons.check,
                              size: 20.0, color: Colors.white),
                          onPressed: () => debugPrint("Accept")),
                    )
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
