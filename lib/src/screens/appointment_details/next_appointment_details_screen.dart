import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/appointment_details/contact_widget.dart';
import 'package:ems_app/src/screens/appointment_details/maps_widget.dart';
import 'package:ems_app/src/screens/appointment_details/appBarDescriptive.dart';
import 'package:ems_app/src/util/user_list.dart';
import 'package:flutter/material.dart';

class NextAppointmentDetailsScreen extends StatefulWidget {
  final Appointment appointment;

  NextAppointmentDetailsScreen({@required this.appointment});

  @override
  State<StatefulWidget> createState() => new _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<NextAppointmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBarDescriptive(
                  title: Text("Next Appointment"),
                  appointment: widget.appointment)
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Maps(address: widget.appointment.address),
              Container(
                  padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                  child: Text("${widget.appointment.address}")),
              Container(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Text("Contacts", style: TextStyle(fontSize: 16.0))),
              Flexible(
                child: ListView.builder(
                    primary: true,
                    itemBuilder: _listBuilder,
                    itemCount: sampleUserList.userList.length),
              ),
            ],
          )),
    );
  }

  Widget _listBuilder(BuildContext context, int index) {
    return ContactListTile(user: sampleUserList.userList[index]);
  }
}
