import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

import 'package:ems_app/src/models/DEMO/appointment.dart';
import 'package:ems_app/src/models/substitute.dart';
import 'package:ems_app/src/widgets/add_time_widget.dart';
import 'package:ems_app/src/util/date_utils.dart';

/// The add screen widget
class AddScreen extends StatefulWidget {
  State<StatefulWidget> createState() => AddScreenState();
}

/// The state for the add screen
class AddScreenState extends State<AddScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  Substitute _subDemo;
  List<AppointmentDEMO> _unApprovedAppointments;
  int _autoExpandedIndex;
  num _month;
  // Color _calendarIconColor;

  @override
  void initState() {
    super.initState();
    _autoExpandedIndex = -1;
    _subDemo = new Substitute(AppointmentDEMO.demodata);
    _unApprovedAppointments = _subDemo.unapprovedAppointments;
    _month = -1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _calendarIconColor = Theme.of(context).iconTheme.color;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    print("MONTH IS: $_month");
    MonthlySeparator separator;
    bool expanded = _autoExpandedIndex == index;
    final currentAppointment = _unApprovedAppointments[index];
    if (_month != currentAppointment.start.month) {
      _month = currentAppointment.start.month;
      separator = new MonthlySeparator(date: currentAppointment.start);
    }

    var addTime = AddTimeWidget(
      onExpansionChanged: (exp) => exp
          ? () {
              setState(() {
                _autoExpandedIndex = index;
              });
            }
          : null,
      expanded: expanded,
      appointment: currentAppointment,
      // color: _calendarIconColor,
      onAccepted: (_) => _acceptAppointment(
          currentAppointment, index, animation,
          dismissed: false),
      changeStartTime: (appointment) =>
          _selectStart(context, appointment, index),
      changeStopTime: (appointment) => _selectStop(context, appointment, index),
      changePauseTime: (appointment) =>
          _selectPause(context, appointment, index),
    );

    // _autoExpandedIndex = -1;

    var addTimeTile = Dismissible(
      child: addTime,
      key: UniqueKey(),
      background: ListTile(trailing: Icon(Icons.check, color: Colors.white)),
      onDismissed: (_) => _acceptAppointment(
          currentAppointment, index, animation,
          dismissed: true),
    );

    return ListTileWithSeparator(separator: separator, child: addTimeTile);
  }

  @override
  Widget build(BuildContext context) {
    _month = -1;
    debugPrint(
        "You have ${_unApprovedAppointments.length} missing registrations");
    return Scaffold(
        appBar: AppBar(title: Text("Pending Registrations")),
        body: AnimatedList(
            key: _listKey,
            initialItemCount: _unApprovedAppointments.length,
            itemBuilder:
                (BuildContext context, int index, Animation animation) {
              return SizeTransition(
                  sizeFactor: animation,
                  child: _buildItem(context, index, animation));
            }));
  }

  _acceptAppointment(
      AppointmentDEMO appointment, int index, Animation<double> animation,
      {bool dismissed}) {
    final String location = appointment.department;
    final String date = DateUtils.fullDayFormat(appointment.start);
    final snackBar = new SnackBar(
      action: new SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              // _month = -1;
              appointment.approvedByOwner = false;
              _unApprovedAppointments.insert(index, appointment);
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

    setState(() {
      _unApprovedAppointments.remove(appointment);
      appointment.approvedByOwner = true;
      Scaffold.of(context).showSnackBar(snackBar);
      removeAppointment(index, dismissed);
      // _month = -1;
    });
  }

  /// Edit start time of the appointment
  Future<Null> _selectStart(
      BuildContext context, AppointmentDEMO appointment, int index) async {
    _autoExpandedIndex = index;
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

  /// Edit stop time of the appointment
  Future<Null> _selectStop(
      BuildContext context, AppointmentDEMO appointment, int index) async {
    _autoExpandedIndex = index;
    TimeOfDay stopTime = DateUtils.asTimeOfDay(appointment.stop);
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
      BuildContext context, AppointmentDEMO appointment, int index) async {
    _autoExpandedIndex = index;
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

class MonthlySeparator extends StatelessWidget {
  final DateTime date;

  MonthlySeparator({@required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(DateFormat.MMMM().format(date)),
          Divider(height: 16),
        ],
      ),
    );
  }
}

class ListTileWithSeparator extends StatelessWidget {
  final MonthlySeparator separator;
  final Widget child;

  ListTileWithSeparator({@required this.separator, @required this.child});

  @override
  Widget build(BuildContext context) {
    if (separator == null) {
      return this.child;
    } else {
      return Column(
        children: <Widget>[separator, child],
      );
    }
  }
}
