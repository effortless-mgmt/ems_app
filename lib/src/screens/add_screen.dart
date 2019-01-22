import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

import 'package:ems_app/src/widgets/add_time_widget.dart';
import 'package:ems_app/src/util/date_utils.dart';
import 'package:ems_app/src/bloc/appointment/appointment.dart';
import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/providers/appointment_api_provider.dart';
import 'package:ems_app/src/widgets/loading_indicator.dart';

class AddScreen extends StatefulWidget {
  State<StatefulWidget> createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  AppointmentBloc _appointmentBloc;
  AppointmentApiProvider _appointmentApiProvider;
  List<Appointment> _appointments;
  int _autoExpandedIndex;
  num _month;
  // Color _calendarIconColor;

  @override
  void initState() {
    super.initState();
    _autoExpandedIndex = -1;
    _appointmentApiProvider = AppointmentApiProvider();
    _appointmentBloc =
        AppointmentBloc(appointmentApiProvider: _appointmentApiProvider);
    _appointmentBloc.dispatch(LoadUnapprovedAppointments());
    _month = -1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _calendarIconColor = Theme.of(context).iconTheme.color;
  }

  @override
  void dispose() {
    _appointmentBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _month = -1;
    // debugPrint("You have ${_appointments.length} missing registrations");
    return BlocProvider<AppointmentBloc>(
      bloc: _appointmentBloc,
      child: BlocBuilder(
        bloc: _appointmentBloc,
        builder: (BuildContext context, AppointmentState appointmentState) {
          if (appointmentState is AppointmentInitial) {
            return LoadingIndicator();
          }
          if (appointmentState is UnapprovedAppointmentList) {
            _appointments = appointmentState.appointments;
          }
          return Scaffold(
              appBar: AppBar(title: Text("Pending Registrations")),
              body: AnimatedList(
                  key: _listKey,
                  initialItemCount: _appointments.length,
                  itemBuilder:
                      (BuildContext context, int index, Animation animation) {
                    return SizeTransition(
                        sizeFactor: animation,
                        child: _buildItem(context, index, animation));
                  }));
        },
      ),
    );
  }

  _buildItem(BuildContext context, int index, Animation<double> animation) {
    MonthlySeparator separator;
    bool expanded = _autoExpandedIndex == index;
    final currentAppointment = _appointments[index];
    if (_month != currentAppointment.start.month) {
      _month = currentAppointment.start.month;
      separator = MonthlySeparator(date: currentAppointment.start);
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
      background: Container(
        color: Theme.of(context).primaryColor,
        child: ListTile(
            trailing: Icon(Icons.check,
                color: Theme.of(context).accentIconTheme.color)),
      ),
      onDismissed: (_) => _acceptAppointment(
          currentAppointment, index, animation,
          dismissed: true),
    );

    return ListTileWithSeparator(separator: separator, child: addTimeTile);
  }

  _acceptAppointment(
      Appointment appointment, int index, Animation<double> animation,
      {bool dismissed}) {
    final int id = appointment.id;
    final String location = appointment.department;
    final String date = DateUtils.fullDayFormat(appointment.start);
    bool _remove = true;
    Timer _timer;
    final snackBar = SnackBar(
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            // ohno.cancel();
            setState(() {
              _remove = false;
              // _month = -1;
              appointment.approvedByOwner = false;
              _appointments.insert(index, appointment);
              _listKey.currentState
                  .insertItem(index, duration: Duration(milliseconds: 300));
            });
          }),
      duration: Duration(seconds: 2),
      content: Wrap(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$location on $date"),
                Text(appointment.registeredMessage),
              ],
            ),
          ),
        ],
      ),
    );

    setState(() {
      _appointments.remove(appointment);
      appointment.approvedByOwner = true;
      Scaffold.of(context).showSnackBar(snackBar);
      _removeAppointment(index, dismissed);
      // _month = -1;
    });

    // send event to server after 3 second, but only if user hasn't clicked undo in the given timeframe.
    _timer = new Timer(const Duration(seconds: 3), () {
      if (_remove) {
        _appointmentBloc.dispatch(ApproveAppointment(id: id));
        debugPrint('removed');
      } else {
        debugPrint('cancelled');
      }
      _timer.cancel();
    });
  }

  /// Edit start time of the appointment
  Future<Null> _selectStart(
      BuildContext context, Appointment appointment, int index) async {
    _autoExpandedIndex = index;
    TimeOfDay startTime = DateUtils.asTimeOfDay(appointment.start);
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: startTime);
    debugPrint("Start selected: ${picked.toString()}");
    if (picked != startTime && picked != null) {
      setState(() {
        startTime = picked;
        appointment.start = DateUtils.changeTime(appointment.start, startTime);
        _appointmentBloc.dispatch(ModifyAppointment(appointment: appointment));
      });
    }
  }

  /// Edit stop time of the appointment
  Future<Null> _selectStop(
      BuildContext context, Appointment appointment, int index) async {
    _autoExpandedIndex = index;
    TimeOfDay stopTime = DateUtils.asTimeOfDay(appointment.stop);
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: stopTime);
    print("Stop selected: ${picked.toString()}");
    if (picked != stopTime && picked != null) {
      setState(() {
        stopTime = picked;
        appointment.stop = DateUtils.changeTime(appointment.stop, stopTime);
        _appointmentBloc.dispatch(ModifyAppointment(appointment: appointment));
      });
    }
  }

  /// Edit pause time of the appointment
  Future<Null> _selectPause(
      BuildContext context, Appointment appointment, int index) async {
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
        _appointmentBloc.dispatch(ModifyAppointment(appointment: appointment));
      });
    }
  }

  void _removeAppointment(int index, bool dismissed) {
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
