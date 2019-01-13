import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/appointment_details/contact_widget.dart';
import 'package:ems_app/src/screens/appointment_details/maps_widget.dart';
import 'package:ems_app/src/screens/appointment_details/testRoute.dart';
import 'package:ems_app/src/screens/appointment_details/appBarDescriptive.dart';
import 'package:ems_app/util/user_list.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final bool isJobOffer;

  AppointmentDetailsScreen({@required this.isJobOffer});

  @override
  State<StatefulWidget> createState() => new _AppointmentDetailsState();
}

// SLIVER APP BAR
class _AppointmentDetailsState extends State<AppointmentDetailsScreen> {
  Appointment _appointment = Appointment.demodata[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              AppBarDescriptive(
                  title: Text("Next Appointment"), appointment: _appointment)
            ];
          },
          body: Column(
            children: <Widget>[
              Maps(address: _appointment.address),
              Flexible(
                child: ListView.builder(
                    primary: true,
                    itemBuilder: _listBuilder,
                    itemCount: sampleUserList.userList.length),
              )
            ],
          )),
    );
  }

  /*########################################### 
    STANDARD APP BAR IMPLEMENTATION. FUNCTIONAL 
    ########################################### */

  // class _AppointmentDetailsState extends State<AppointmentDetailsScreen> {
  // Appointment _appointment = Appointment.demodata[0];
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBarDescriptive(
  //         title: Text("Next Appointment"), appointment: _appointment),
  //     body: Column(
  //       children: <Widget>[
  //         Maps(address: _appointment.address),
  //         Flexible(
  //           child: ListView.builder(
  //               itemBuilder: _listBuilder,
  //               itemCount: sampleUserList.userList.length),
  //         ),
  //         // ContactListTile(user: sampleUserList.userList[0])
  //       ],
  //     ),
  //   );
  // }

  Widget _listBuilder(BuildContext context, int index) {
    return ContactListTile(user: sampleUserList.userList[index]);
  }
}
