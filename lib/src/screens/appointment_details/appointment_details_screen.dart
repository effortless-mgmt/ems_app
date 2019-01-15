import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/appointment_details/appBarDescriptive.dart';
import 'package:ems_app/src/screens/appointment_details/maps_widget.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final Appointment appointment;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isJobOffer;

  AppointmentDetailsScreen(
      {@required this.appointment,
      this.scaffoldKey,
      @required this.isJobOffer});

  @override
  Widget build(BuildContext context) {
    bool notNull(Object o) => o != null;

    return Scaffold(
      appBar: AppBarDescriptive(
          title: isJobOffer ? Text("Job Offer") : Text("Appointment Details"),
          appointment: appointment),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Maps(address: appointment.address),
          Container(
              padding: const EdgeInsets.only(left: 16.0, top: 10.0),
              child: Text("${appointment.address}")),
          Container(
              padding: const EdgeInsets.all(16),
              child: Text("Contacts", style: TextStyle(fontSize: 16.0))),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: isJobOffer
                  ? Text("No job contacts displayed yet.",
                      style: TextStyle(fontSize: 12.0))
                  : Text(
                      "No job contacts displayed yet. You will be able to see contacts within 16 hours of your next appointment.")),
          Expanded(
            child: Center(
              child: isJobOffer
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                            child: Text("Accept Appointment",
                                style: TextStyle(
                                    color: Colors.green,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content: new Text("Job offer accepted."),
                                      duration: Duration(milliseconds: 1500)));
                            }),
                        FlatButton(
                            child: Text("Decline Appointment",
                                style: TextStyle(
                                    color: Colors.red,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content: new Text("Job offer declined"),
                                      duration: Duration(milliseconds: 1500)));
                            }),
                      ],
                    )
                  : null,
            ),
          ),
        ].where(notNull).toList(),
      ),
    );
  }
}
