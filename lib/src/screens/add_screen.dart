import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/models/substitute.dart';
import 'package:ems_app/src/widgets/timereg_widget.dart';
import 'package:ems_app/util/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

// TODO
// 1. REMOVE ITEM WITH ANIMATION ON ACCEPT
// 2. IMPLEMENT BLOC

class AddScreen extends StatefulWidget {
  State<StatefulWidget> createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> with TickerProviderStateMixin {
  Substitute subDemo;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    subDemo = new Substitute(Appointment.demodata);
    _animationController = new AnimationController(
        duration: new Duration(milliseconds: 250), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _handleSubmission(BuildContext context, Appointment appointment) {
    final String location = appointment.location;
    final String date = DateUtils.fullDayFormat(appointment.start);
    final snackBar = new SnackBar(
      action: new SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              appointment.approved = false;
            });
          }),
      duration: new Duration(seconds: 5),
      content: Wrap(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("$location on $date"),
                new Text(appointment.registeredMessage),
              ],
            ),
          ),
        ],
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget _buildItem(BuildContext context, int index) {
    TimeReg tr = TimeReg(
        appointment: subDemo.unapprovedAppointments[index],
        animationController: _animationController,
        onAccepted: (app) {
          setState(() {
            _animationController.reverse();
            app.approved = true;
            _handleSubmission(context, app);
          });
        },
        onStartChanged: (app) => _selectStart(context, app),
        onStopChanged: (app) => _selectStop(context, app),
        onPauseChanged: (app) => _selectPause(context, app));

    tr.animationController.forward();
    return tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
            child: new Text(
                "You have ${subDemo.unapprovedAppointments.length} missing registrations",
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
            margin: const EdgeInsets.only(top: 20.0, left: 16.0, bottom: 10.0)),
        new Flexible(
          child: new ListView.builder(
              itemBuilder: _buildItem,
              itemCount: subDemo.unapprovedAppointments.length),
        ),
      ],
    ));
  }

  Future<Null> _selectStart(
      BuildContext context, Appointment appointment) async {
    TimeOfDay startTime = DateUtils.asTimeOfDay(appointment.start);
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: startTime);
    debugPrint("Start selected: ${picked.toString()}");
    if (picked != startTime && picked != null) {
      setState(() {
        startTime = picked;
        appointment.start = DateUtils.changeTime(appointment.start, startTime);
      });
    }
  }

  Future<Null> _selectStop(
      BuildContext context, Appointment appointment) async {
    TimeOfDay stopTime = DateUtils.asTimeOfDay(appointment.start);
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: stopTime);
    print("Stop selected: ${picked.toString()}");
    if (picked != stopTime && picked != null) {
      setState(() {
        stopTime = picked;
        appointment.stop = DateUtils.changeTime(appointment.stop, stopTime);
      });
    }
  }

  Future<Null> _selectPause(
      BuildContext context, Appointment appointment) async {
    Duration pause = appointment.pause;
    final Duration picked = await showDurationPicker(
      context: context,
      initialTime: pause,
    );
    print("Pause selected: ${picked.toString()}");
    if (picked != pause && picked != null) {
      setState(() {
        appointment.pause = picked;
      });
    }
  }
}
