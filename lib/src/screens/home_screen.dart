import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/screens/appointment_details/appointment_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(title: Text("Overview")),
        body: ListView.builder(
          itemCount: exampleList.length,
          itemBuilder: _buildListTile,
        ));
  }

  Widget _buildListTile(BuildContext context, int index) {
    final item = exampleList[index];
    if (item is HeadingItem) {
      return Column(children: [
        ListTile(
          title: Text(
            item._heading,
          ),
        ),
        Divider(
          height: 0.0,
        ),
      ]);
    } else if (item is UpcomingShift) {
      return _buildUpcomingShifts(context, item);
    } else if (item is AvailableShift) {
      return _buildAvailableShifts(context, item);
    }
    return null;
  }

  _buildUpcomingShifts(BuildContext context, UpcomingShift item) {
    return ListTile(
        leading: _buildDateIcon(context, item.appointment.start),
        title: Text(DateFormat.Hm().format(item.appointment.start) +
            " - " +
            DateFormat.Hm().format(item.appointment.stop)),
        subtitle: Text(item.appointment.department),
        trailing: Text(item._status),
        onTap: () {
          Navigator.of(context).push(
            new SlidePageRoute<Null>(
              builder: (BuildContext context) => AppointmentDetailsScreen(
                  appointment: item.appointment, isJobOffer: false),
              fullscreenDialog: true,
            ),
          );
        });
  }

  _buildAvailableShifts(BuildContext context, AvailableShift item) {
    return ListTile(
        leading: _buildDateIcon(context, item.appointment.start),
        title: Text(DateFormat.Hm().format(item.appointment.start) +
            " - " +
            DateFormat.Hm().format(item.appointment.stop)),
        subtitle: Text(item.appointment.department),
        onTap: () {
          Navigator.of(context).push(
            new SlidePageRoute<Null>(
              builder: (BuildContext context) => AppointmentDetailsScreen(
                  appointment: item.appointment,
                  scaffoldKey: scaffoldKey,
                  isJobOffer: true),
              fullscreenDialog: true,
            ),
          );
        });
  }

  _buildDateIcon(BuildContext context, DateTime dateTime) {
    var day = DateFormat.d().format(dateTime);
    var month = DateFormat.MMM().format(dateTime);
    return Container(
      child: Stack(
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: Colors.grey,
            size: 40.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 16),
            width: 40.0,
            height: 40.0,
            child: Column(
              children: <Widget>[
                Text(
                  day,
                  textScaleFactor: 0.75,
                  style: TextStyle(
                    color: Colors.grey,
                    height: 0.75,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  month,
                  textScaleFactor: 0.75,
                  style: TextStyle(
                    color: Colors.grey,
                    height: 0.75,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JobOffer {}

class ListItem {}

class HeadingItem extends ListItem {
  final String _heading;

  HeadingItem(this._heading);
}

class ShiftItem extends ListItem {
  final Appointment appointment;

  ShiftItem.protected(this.appointment);

  factory ShiftItem.fromJson(Map<dynamic, dynamic> json) {
    Appointment appointment = Appointment();
    appointment.start = DateTime.parse(json["shiftStart"]);
    appointment.stop = DateTime.parse(json["shiftStart"]);
    appointment.department = json["department"];
    appointment.address = json["address"];
    appointment.description = json["description"];
    appointment.hourlyWage = json["salary"];

    if (json["type"] == "available") {
      return AvailableShift(appointment: appointment);
    } else if (json["type"] == "upcoming") {
      return UpcomingShift(
        status: json["status"],
        appointment: appointment,
      );
    } else {
      return null;
    }
  }
}

class AvailableShift extends ShiftItem {
  AvailableShift({@required appointment}) : super.protected(appointment);
}

class UpcomingShift extends ShiftItem {
  String _status = "new";
  UpcomingShift({@required appointment, @required status})
      : this._status = status,
        super.protected(appointment);
}

final shiftItem1 = ShiftItem.fromJson({
  "type": "upcoming",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "department": "Netto koel",
  "address": "Mimersvej 1, 4600 Køge",
  "description":
      "Hos Netto Køl vil du typisk stå og pakke i Nettos køleboks. Det er derfor vigtigt, at du husker varmt tøj. Husk også madpakke og sikkerhedssko.",
  "salary": 127.36,
  "status": "Today",
});

final shiftItem2 = ShiftItem.fromJson({
  "type": "upcoming",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "department": "Rema1000 koel",
  "address": "Mimersvej 1, 4600 Køge",
  "description":
      "Hos Netto Køl vil du typisk stå og pakke i Nettos køleboks. Det er derfor vigtigt, at du husker varmt tøj. Husk også madpakke og sikkerhedssko.",
  "salary": 127.36,
  "status": "New",
});

final shiftItem3 = ShiftItem.fromJson({
  "type": "upcoming",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "department": "Fakta koel",
  "address": "Mimersvej 1, 4600 Køge",
  "description":
      "Hos Netto Køl vil du typisk stå og pakke i Nettos køleboks. Det er derfor vigtigt, at du husker varmt tøj. Husk også madpakke og sikkerhedssko.",
  "salary": 127.36,
  "status": "New",
});

final shiftItem4 = ShiftItem.fromJson({
  "type": "available",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "department": "Fakta koel",
  "address": "Mimersvej 1, 4600 Køge",
  "description":
      "Hos Netto Køl vil du typisk stå og pakke i Nettos køleboks. Det er derfor vigtigt, at du husker varmt tøj. Husk også madpakke og sikkerhedssko.",
  "salary": 127.36,
});

final shiftItem5 = ShiftItem.fromJson({
  "type": "available",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "department": "Fakta koel",
  "address": "Mimersvej 1, 4600 Køge",
  "description":
      "Hos Netto Køl vil du typisk stå og pakke i Nettos køleboks. Det er derfor vigtigt, at du husker varmt tøj. Husk også madpakke og sikkerhedssko.",
  "salary": 127.36,
});

final shiftItem6 = ShiftItem.fromJson({
  "type": "available",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "department": "Fakta koel",
  "address": "Mimersvej 1, 4600 Køge",
  "description":
      "Hos Netto Køl vil du typisk stå og pakke i Nettos køleboks. Det er derfor vigtigt, at du husker varmt tøj. Husk også madpakke og sikkerhedssko.",
  "salary": 127.36,
});

final head1 = HeadingItem("Upcoming Appointments");

final head2 = HeadingItem("Pending Job Offers");

final exampleList = [
  head1,
  shiftItem1,
  shiftItem2,
  shiftItem3,
  head2,
  shiftItem4,
  shiftItem5,
  shiftItem6
];

class SlidePageRoute<T> extends MaterialPageRoute<T> {
  SlidePageRoute(
      {WidgetBuilder builder, RouteSettings settings, bool fullscreenDialog})
      : super(
            builder: builder,
            settings: settings,
            fullscreenDialog: fullscreenDialog);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).chain(CurveTween(
      curve: Curves.bounceIn,
    ));

    return SlideTransition(
        position: animation.drive(_drawerDetailsTween),
        child: ScaleTransition(
            scale: animation,
            child: FadeTransition(opacity: animation, child: child)));
  }
}
