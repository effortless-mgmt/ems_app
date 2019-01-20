import 'package:ems_app/src/bloc/appointment/appointment_bloc.dart';
import 'package:ems_app/src/bloc/appointment/appointment_event.dart';
import 'package:ems_app/src/bloc/appointment/appointment_state.dart';
import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/providers/appointment_api_provider.dart';
import 'package:ems_app/src/screens/appointment_details/contact_widget.dart';
import 'package:ems_app/src/screens/appointment_details/maps_widget.dart';
import 'package:ems_app/src/screens/appointment_details/appBarDescriptive.dart';
import 'package:ems_app/src/models/DEMO/user_list.dart';
import 'package:ems_app/src/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextAppointmentDetailsScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<NextAppointmentDetailsScreen> {
  AppointmentBloc _appointmentBloc;
  AppointmentApiProvider _appointmentApiProvider;
  Appointment _appointment;

  @override
  void initState() {
    super.initState();
    _appointmentApiProvider = AppointmentApiProvider();
    _appointmentBloc =
        AppointmentBloc(appointmentApiProvider: _appointmentApiProvider);
    _appointmentBloc.dispatch(LoadNextAppointment());
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
          if (appointmentState is UpcomingAppointmentItem) {
            _appointment = appointmentState.appointment;
          }
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBarDescriptive(
                        title: Text("Next Appointment"),
                        appointment: _appointment)
                  ];
                },
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Maps(address: _appointment.address),
                    Container(
                        padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                        child: Text("${_appointment.address}")),
                    Container(
                        padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                        child:
                            Text("Contacts", style: TextStyle(fontSize: 16.0))),
                    Flexible(
                      child: ListView.builder(
                          primary: true,
                          itemBuilder: _listBuilder,
                          itemCount: sampleUserList.userList.length),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget _listBuilder(BuildContext context, int index) {
    return ContactListTile(user: sampleUserList.userList[index]);
  }
}
