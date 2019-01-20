import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/providers/appointment_api_provider.dart';
import 'package:ems_app/src/screens/home_screen/all_shifts_screen.dart';
import 'package:ems_app/src/screens/home_screen/appointment_list.dart';
import 'package:ems_app/src/screens/home_screen/page_routes.dart';
import 'package:ems_app/src/screens/home_screen/show_all_button.dart';
import 'package:ems_app/src/bloc/appointment/appointment.dart';
import 'package:ems_app/src/widgets/loading_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  AppointmentBloc _appointmentBloc;
  AppointmentApiProvider _appointmentApiProvider;
  List<Appointment> _upcomingAppointments;
  List<Appointment> _availableAppointments;

  bool tapped;

  @override
  void initState() {
    super.initState();
    _appointmentApiProvider = AppointmentApiProvider();
    _appointmentBloc =
        AppointmentBloc(appointmentApiProvider: _appointmentApiProvider);
    _appointmentBloc.dispatch(LoadUpcomingAndAvailableAppointments());
    tapped = false;
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
          if (appointmentState is UpcomingAndAvailableAppointmentList) {
            _availableAppointments = appointmentState.availableAppointments;
            _upcomingAppointments = appointmentState.upcomingAppointments;
          }

          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(title: Text("Overview")),
              body: ListView(
                children: <Widget>[
                  _shiftCard(context, true),
                  _shiftCard(context, false)
                ],
              ));
        },
      ),
    );
  }

  Widget _shiftCard(context, bool upcoming) {
    final activateShowAll = upcoming
        ? _upcomingAppointments.length > 3
        : _availableAppointments.length > 3;

    return Hero(
      tag: upcoming ? "seeAllUpcoming" : "seeAllAvailable",
      child: Card(
        // margin: null,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                HeadingTile(
                    title: upcoming ? "Upcoming Shifts" : "Available Shifts"),
                AppointmentList(
                    appointmentBloc: _appointmentBloc,
                    upcoming: upcoming,
                    scaffoldKey: scaffoldKey,
                    showAll: false),
                activateShowAll
                    ? ShowAllButton(
                        tapped: tapped,
                        upcoming: upcoming,
                        onTap: () async {
                          setState(() {
                            tapped = true;
                          });
                          await Future.delayed(Duration(milliseconds: 200));
                          Navigator.push(
                            context,
                            SlowMaterialPageRoute(
                              builder: (context) =>
                                  AllShiftsScreen(upcoming: upcoming),
                              fullscreenDialog: false,
                            ),
                          ).then((value) {
                            tapped = false;
                          });
                        })
                    : Container(height: 16.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
