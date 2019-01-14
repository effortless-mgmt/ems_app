import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/models/substitute.dart';
import 'package:ems_app/src/widgets/add_time_widget.dart';
import 'package:ems_app/util/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

/// The add screen widget
class AddScreen extends StatefulWidget {
  State<StatefulWidget> createState() => AddScreenState();
}

/// The state for the add screen
class AddScreenState extends State<AddScreen> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  Substitute subDemo;
  List<Appointment> unApprovedAppointments;

  @override
  void initState() {
    super.initState();
    subDemo = new Substitute(Appointment.demodata);
    unApprovedAppointments = subDemo.unapprovedAppointments;
  }

  @override
  void dispose() {
    super.dispose();
  }

  var appointmentNo = 3;
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    final currentAppointment = unApprovedAppointments[index];

    var addTime = AddTimeWidget(
      currentAppointment,
      onAccepted: (appointment) =>
          _acceptAppointment(appointment, index, animation, dismissed: false),
      changeStartTime: (appointment) => _selectStart(context, appointment),
      changeStopTime: (appointment) => _selectStop(context, appointment),
      changePauseTime: (appointment) => _selectPause(context, appointment),
    );

    return Dismissible(
      child: addTime,
      key: UniqueKey(),
      background: Container(
          color: Colors.lightGreen,
          child: ListTile(trailing: Icon(Icons.check, color: Colors.red))),
      onDismissed: (_) => _acceptAppointment(
          currentAppointment, index, animation,
          dismissed: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
            child: new Text(
                "You have ${unApprovedAppointments.length} missing registrations",
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
            margin: const EdgeInsets.only(top: 20.0, left: 16.0, bottom: 10.0)),
        new Flexible(
          child: AnimatedList(
              key: _listKey,
              initialItemCount: unApprovedAppointments.length,
              itemBuilder:
                  (BuildContext context, int index, Animation animation) {
                return SizeTransition(
                    sizeFactor: animation,
                    child: _buildItem(context, index, animation));
              }),
          //  new ListView.builder(
          //     itemBuilder: _buildItem,
          //     itemCount: unApprovedAppointments.length),
        ),
      ],
    ));
  }

  _acceptAppointment(
      Appointment appointment, int index, Animation<double> animation,
      {bool dismissed}) {
    final String location = appointment.location;
    final String date = DateUtils.fullDayFormat(appointment.start);
    final snackBar = new SnackBar(
      action: new SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              appointment.approved = false;
              unApprovedAppointments.insert(index, appointment);
              _listKey.currentState
                  .insertItem(index, duration: Duration(milliseconds: 300));
            });
          }),
      duration: new Duration(seconds: 2),
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

    removeAppointment(index, dismissed);

    setState(() {
      // _animationController.reverse();
      appointment.approved = true;
      unApprovedAppointments.remove(appointment);
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  /// Edit staqrt time of the appointment
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

  /// Edit stop trime of the appointment
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

  /// Edit pause time of the appointment
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

  void removeAppointment(int index, bool dismissed) {
    dismissed
        ? _listKey.currentState.removeItem(index,
            (BuildContext context, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: _buildItem(context, index, animation),
            );
          }, duration: Duration(milliseconds: 0))
        : _listKey.currentState.removeItem(index,
            (BuildContext context, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: _buildItem(context, index, animation),
            );
          });
  }
}
