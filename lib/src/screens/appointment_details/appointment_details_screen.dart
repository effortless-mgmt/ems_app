import 'package:flutter/material.dart';
import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/appointment_details/appBarDescriptive.dart';
import 'package:ems_app/src/screens/appointment_details/maps_widget.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final Appointment appointment;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool upcoming;
  final int index;

  AppointmentDetailsScreen(
      {@required this.appointment,
      this.scaffoldKey,
      @required this.upcoming,
      @required this.index});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: upcoming ? "seeUpcoming$index" : "seeAvailable$index",
      child: Scaffold(
        appBar: AppBarDescriptive(
            appointment: appointment,
            upcoming: upcoming,
            iconTheme: Theme.of(context).accentIconTheme),
        body: Column(children: <Widget>[
          Column(
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
                    child: upcoming
                        ? Text(
                            "No job contacts displayed yet. You will be able to see contacts within 16 hours of your next appointment.")
                        : Text("No job contacts displayed yet.",
                            style: TextStyle(fontSize: 12.0)))
              ]),
          upcoming
              ? Container()
              : Expanded(
                  child: ButtonTheme.bar(
                    child: ButtonBar(
                      mainAxisSize: MainAxisSize.max,
                      alignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton(
                            child: Text("Decline",
                                style: TextStyle(
                                    color: Theme.of(context).errorColor)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              scaffoldKey.currentState.showSnackBar(
                                new SnackBar(
                                  content: new Text("Job offer declined"),
                                  duration: Duration(milliseconds: 1500),
                                ),
                              );
                            }),
                        RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text("Accept",
                                style:
                                    Theme.of(context).primaryTextTheme.button),
                            onPressed: () {
                              Navigator.of(context).pop();
                              scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content: new Text("Job offer accepted."),
                                      duration: Duration(milliseconds: 1500)));
                            }),
                      ],
                    ),
                  ),
                )
        ]),
      ),
    );
  }
}
