import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/appointment_details/contact_widget.dart';
import 'package:ems_app/src/screens/appointment_details/maps_widget.dart';
import 'package:ems_app/src/screens/appointment_details/appBarDescriptive.dart';
import 'package:ems_app/util/user_list.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final bool isJobOffer;
  final Appointment appointment;

  AppointmentDetailsScreen(
      {@required this.isJobOffer, @required this.appointment});

  @override
  State<StatefulWidget> createState() => new _AppointmentDetailsState();
}

// SLIVER APP BAR
class _AppointmentDetailsState extends State<AppointmentDetailsScreen> {
  bool notNull(Object o) => o != null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              AppBarDescriptive(
                  title: widget.isJobOffer
                      ? Text("Job Offer")
                      : Text("Next Appointment"),
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
              widget.isJobOffer
                  ? _doNotDisplayContacts()
                  : Flexible(
                      child: ListView.builder(
                          primary: true,
                          itemBuilder: _listBuilder,
                          itemCount: sampleUserList.userList.length),
                    ),
              widget.isJobOffer ? _declineOffer() : null,
            ].where(notNull).toList(),
          )),
    );
  }

  Widget _doNotDisplayContacts() {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Text("No job contacts displayed yet.",
            style: TextStyle(fontSize: 16.0)));
  }

  Widget _listBuilder(BuildContext context, int index) {
    return ContactListTile(user: sampleUserList.userList[index]);
  }

  Widget _declineOffer() {
    return Center(
      child: FlatButton(
          child: Text("Decline job offer",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0)),
          onPressed: () => debugPrint("Pressed")),
    );
  }
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
