import 'package:ems_app/src/bloc/appointment/appointment.dart';
import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/providers/appointment_api_provider.dart';
import 'package:ems_app/src/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

import 'package:ems_app/src/widgets/appointment_widget.dart';
import 'package:ems_app/src/widgets/calendar/calendar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  AppointmentBloc _appointmentBloc;
  AppointmentApiProvider _appointmentApiProvider;
  List<Appointment> _appointments;
  DateTime selected;

  @override
  void initState() {
    super.initState();
    selected = DateTime.now();
    _appointmentApiProvider = AppointmentApiProvider();
    _appointmentBloc =
        AppointmentBloc(appointmentApiProvider: _appointmentApiProvider);
    _appointmentBloc.dispatch(LoadAppointments());
  }

  @override
  void dispose() {
    _appointmentBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentBloc>(
      bloc: _appointmentBloc,
      child: BlocBuilder(
        bloc: _appointmentBloc,
        builder: (BuildContext context, AppointmentState appointmentState) {
          if (appointmentState is AppointmentInitial) {
            return LoadingIndicator();
          }
          if (appointmentState is AllAppointmentList) {
            _appointments = appointmentState.appointments;
          }
          return Scaffold(
            appBar: AppBar(title: Text("Calendar")),
            body: new Column(
              children: <Widget>[
                new Calendar(
                    selectedDate: selected,
                    appointments: _appointments,
                    onDateSelected: (date) => setState(() => selected = date)),
                new Expanded(
                  child: new ListView.builder(
                      itemCount: _appointments.length,
                      itemBuilder: _appointmentBuilder),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _appointmentBuilder(BuildContext context, int index) {
    bool isOldAppointment = _appointments[index].stop.isBefore(DateTime.now());
    return isOldAppointment
        ? Container(height: 0.0, width: 0.0)
        : AppointmentWidget(
            appointment: _appointments[index],
            currentDateTime: selected,
            onAppointmentSelected: (app) =>
                setState(() => selected = app.start));
  }
}
