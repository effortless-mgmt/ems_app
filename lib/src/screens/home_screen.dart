import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            item.heading,
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
      leading: _buildDateIcon(context, item.shiftStart),
      title: Text(DateFormat.Hm().format(item.shiftStart) +
          " - " +
          DateFormat.Hm().format(item.shiftEnd)),
      subtitle: Text(item.location),
      trailing: Text(item.status),
    );
  }

  _buildAvailableShifts(BuildContext context, AvailableShift item) {
    return ListTile(
      leading: _buildDateIcon(context, item.shiftStart),
      title: Text(DateFormat.Hm().format(item.shiftStart) +
          " - " +
          DateFormat.Hm().format(item.shiftEnd)),
      subtitle: Text(item.location),
      trailing: Checkbox(
        value: item.checked,
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
  final String heading;

  HeadingItem(this.heading);
}

class ShiftItem extends ListItem {
  // DateTime shiftStart;
  // DateTime shiftEnd;
  // String location;
}

class AvailableShift implements ShiftItem {
  final DateTime shiftStart;
  final DateTime shiftEnd;
  final String location;
  bool checked = false;

  AvailableShift(this.shiftStart, this.shiftEnd, this.location, this.checked);
}

class UpcomingShift implements ShiftItem {
  final DateTime shiftStart;
  final DateTime shiftEnd;
  final String location;
  final String status;

  UpcomingShift(this.shiftStart, this.shiftEnd, this.location, this.status);
}

final exampleList = new List<ListItem>.generate(
    16,
    (i) => i % 4 == 0 && i < 5
        ? (i < 4
            ? HeadingItem("Upcoming Shifts")
            : HeadingItem("Available Shifts"))
        : ((i >= 4)
            ? AvailableShift(DateTime(2017, 11, i, 12, 30),
                DateTime(2017, 11, i, 18, 30), "Netto koel", false)
            : UpcomingShift(DateTime(2017, 6, i, 12, 30),
                DateTime(2017, 6, i, 18, 30), "Netto koel", "Ny")));
