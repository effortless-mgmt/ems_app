import 'package:ems_app/src/widgets/timereg_widget.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  State<StatefulWidget> createState() => AddScreenState();
}

//delete later
class AddScreenState extends State<AddScreen> with TickerProviderStateMixin {
  AnimationController _animationController;
  List<TimeReg> _unregHours;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        duration: new Duration(milliseconds: 250), vsync: this);
    _unregHours = <TimeReg>[];
    TimeReg tr1 = new TimeReg(
      date: new DateTime(2018, 10, 26),
      location: "Netto Spot",
      start: new TimeOfDay(hour: 09, minute: 00),
      stop: new TimeOfDay(hour: 17, minute: 00),
      pause: 30,
      animationController: _animationController,
    );

    TimeReg tr2 = new TimeReg(
        date: new DateTime(2018, 10, 27),
        location: "H&M Incoming",
        start: new TimeOfDay(hour: 08, minute: 30),
        stop: new TimeOfDay(hour: 16, minute: 30),
        pause: 30,
        animationController: _animationController);

    TimeReg tr3 = new TimeReg(
        date: new DateTime(2018, 10, 28),
        location: "L'oréal CPD Standard",
        start: new TimeOfDay(hour: 06, minute: 00),
        stop: new TimeOfDay(hour: 14, minute: 30),
        pause: 30,
        animationController: _animationController);

    TimeReg tr4 = new TimeReg(
        date: new DateTime(2018, 10, 29),
        location: "Netto Kolonial",
        start: new TimeOfDay(hour: 07, minute: 30),
        stop: new TimeOfDay(hour: 15, minute: 30),
        pause: 30,
        animationController: _animationController);

    _unregHours.insert(_unregHours.length, tr1);
    tr1.animationController.forward();

    _unregHours.insert(_unregHours.length, tr2);
    tr2.animationController.forward();

    _unregHours.insert(_unregHours.length, tr3);
    tr3.animationController.forward();

    _unregHours.insert(_unregHours.length, tr4);
    tr4.animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _regTime(BuildContext context, int index) {
    TimeReg tr = _unregHours.removeAt(index);
    DateTime start = new DateTime(tr.date.year, tr.date.month, tr.date.day,
        tr.start.hour, tr.start.minute);
    DateTime stop = new DateTime(
        tr.date.year, tr.date.month, tr.date.day, tr.stop.hour, tr.stop.minute);
    if (stop.hour < start.hour) {
      debugPrint("Stops next day");
      debugPrint("Stop before adding day: ${stop.toString()}");

      stop = stop.add(new Duration(days: 1));
      debugPrint("Start DateTime: ${start.toString()}");
      debugPrint("Stop DateTime: ${stop.toString()}");
    }
    stop = stop.subtract(new Duration(minutes: tr.pause));
    WorkHours wh = new WorkHours(stop.difference(start).inMinutes, tr.date);
    debugPrint("Registered: ${wh.getHours()}h ${wh.getMinutes()}m");
    _showUndoSnackBar(context, wh, tr, index);
  }

  void _showUndoSnackBar(
      BuildContext context, WorkHours wh, TimeReg tr, int index) {
    final snackBar = new SnackBar(
      action: new SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _unregHours.insert(index, tr);
              // _buildItem(context, index);
            });
          }),
      duration: new Duration(seconds: 5),
      content: Container(
        height: 40.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("${tr.location} on ${wh.getDateFormatted()}"),
            new Text(
                "Registered ${wh.getHours()}h ${wh.getMinutes()}m work, ${tr.pause}m break"),
          ],
        ),
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget _buildItem(BuildContext context, int index) {
    return TimeReg(
        date: _unregHours[index].date,
        location: _unregHours[index].location,
        start: _unregHours[index].start,
        stop: _unregHours[index].stop,
        pause: _unregHours[index].pause,
        animationController: _unregHours[index].animationController,
        onAccepted: () {
          setState(() {
            _unregHours[index].animationController.forward();
            _regTime(context, index);
            debugPrint("Removed at $index");
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
            child: new Text(
                "You have ${_unregHours.length} missing registrations",
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
            margin: const EdgeInsets.only(top: 20.0, left: 16.0, bottom: 10.0)),
        new Flexible(
          child: new ListView.builder(
              itemBuilder: _buildItem,
              // itemBuilder: (_, int index) => _unregHours[index],
              itemCount: _unregHours.length),
        ),
      ],
    ));
  }
}
