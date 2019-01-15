import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      leading: _buildDateIcon(context, item._shiftStart),
      title: Text(DateFormat.Hm().format(item._shiftStart) +
          " - " +
          DateFormat.Hm().format(item._shiftEnd)),
      subtitle: Text(item._location),
      trailing: Text(item._status),
    );
  }

  _buildAvailableShifts(BuildContext context, AvailableShift item) {
    return ListTile(
      leading: _buildDateIcon(context, item._shiftStart),
      title: Text(DateFormat.Hm().format(item._shiftStart) +
          " - " +
          DateFormat.Hm().format(item._shiftEnd)),
      subtitle: Text(item._location),
      trailing: Checkbox(
        value: item._checked,
        onChanged: null, // TODO: add method for accepting available shift,
      ),
    );
  }

  _buildDateIcon(BuildContext context, DateTime dateTime) {
    var day = DateFormat.d().format(dateTime);
    var month = DateFormat.MMM().format(dateTime);
    return Container(
      child: Stack(
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: Colors.red.shade500,
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
                    height: 0.75,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  month,
                  textScaleFactor: 0.75,
                  style: TextStyle(
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

class ListItem {}

class HeadingItem extends ListItem {
  final String _heading;

  HeadingItem(this._heading);
}

class ShiftItem extends ListItem {
  final DateTime _shiftStart;
  final DateTime _shiftEnd;
  final String _location;

  ShiftItem.protected(this._shiftStart, this._shiftEnd, this._location);

  factory ShiftItem.fromJson(Map<dynamic, dynamic> json) {
    if (json["type"] == "available") {
      return AvailableShift(
        shiftStart: DateTime.parse(json["shiftStart"]),
        shiftEnd: DateTime.parse(json["shiftEnd"]),
        location: json["location"],
      );
    } else if (json["type"] == "upcoming") {
      return UpcomingShift(
        status: json["status"],
        shiftStart: DateTime.parse(json["shiftStart"]),
        shiftEnd: DateTime.parse(json["shiftEnd"]),
        location: json["location"],
      );
    } else {
      return null;
    }
  }
}

class AvailableShift extends ShiftItem {
  bool _checked = false;
  AvailableShift({@required shiftStart, @required shiftEnd, @required location})
      : super.protected(shiftStart, shiftEnd, location);
}

class UpcomingShift extends ShiftItem {
  String _status = "new";
  UpcomingShift(
      {@required shiftStart,
      @required shiftEnd,
      @required location,
      @required status})
      : this._status = status,
        super.protected(shiftStart, shiftEnd, location);
}

final shiftItem1 = ShiftItem.fromJson({
  "type": "upcoming",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "location": "Netto koel",
  "status": "Today",
});

final shiftItem2 = ShiftItem.fromJson({
  "type": "upcoming",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "location": "Rema1000 koel",
  "status": "New",
});

final shiftItem3 = ShiftItem.fromJson({
  "type": "upcoming",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "location": "Fakta koel",
  "status": "New",
});

final shiftItem4 = ShiftItem.fromJson({
  "type": "available",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "location": "Fakta koel",
});

final shiftItem5 = ShiftItem.fromJson({
  "type": "available",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "location": "Fakta koel",
});

final shiftItem6 = ShiftItem.fromJson({
  "type": "available",
  "shiftStart": "2018-11-15T15:30:00",
  "shiftEnd": "2018-11-15T15:30:00",
  "location": "Fakta koel",
});

final head1 = HeadingItem("Upcoming Shifts");

final head2 = HeadingItem("Available Shifts");

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
