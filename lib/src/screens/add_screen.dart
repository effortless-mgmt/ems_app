import 'package:duration/duration.dart';
import 'package:ems_app/src/models/workperiod.dart';
import 'package:ems_app/src/widgets/calendar/calendar_utils.dart';
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
      location: "Netto Spot",
      start: new DateTime(2018, 10, 26, 09, 00),
      stop: new DateTime(2018, 10, 26, 17, 00),
      pause: new Duration(minutes: 30),
      animationController: _animationController,
    );

    TimeReg tr2 = new TimeReg(
        location: "H&M Incoming",
        start: new DateTime(2018, 10, 26, 08, 30),
        stop: new DateTime(2018, 10, 26, 16, 30),
        pause: new Duration(minutes: 30),
        animationController: _animationController);

    TimeReg tr3 = new TimeReg(
        location: "L'oréal CPD Standard",
        start: new DateTime(2018, 10, 26, 06, 00),
        stop: new DateTime(2018, 10, 26, 14, 30),
        pause: new Duration(minutes: 30),
        animationController: _animationController);

    TimeReg tr4 = new TimeReg(
        location: "Netto Kolonial",
        start: new DateTime(2018, 10, 26, 07, 30),
        stop: new DateTime(2018, 10, 26, 15, 30),
        pause: new Duration(minutes: 30),
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
    // if (tr.stop.hour < tr.start.hour) {
    //   debugPrint("Stops next day");
    //   debugPrint("Stop before adding day: ${stop.toString()}");

    //   stop = stop.add(new Duration(days: 1));
    //   debugPrint("Start DateTime: ${start.toString()}");
    //   debugPrint("Stop DateTime: ${stop.toString()}");
    // }
    // stop = stop.subtract(new Duration(minutes: tr.pause));
    WorkPeriod workPeriod = new WorkPeriod(tr.start, tr.stop, tr.pause);
    _showUndoSnackBar(context, workPeriod, tr, index);
  }

  void _showUndoSnackBar(
      BuildContext context, WorkPeriod workPeriod, TimeReg tr, int index) {
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
        height: 65.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
                "${tr.location} on ${Utils.fullDayFormat(workPeriod.start)}"),
            new Text(workPeriod.registeredMessage),
          ],
        ),
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget _buildItem(BuildContext context, int index) {
    return TimeReg(
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
