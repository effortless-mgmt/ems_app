import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  bool clockConvention = false;
  bool notificationSound = false;
  bool notificationOn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'General',
              style: TextStyle(color: Colors.blue, fontSize: 15.0),
            ),
          ),
          ListTile(
            title: Text('24-hour clock'),
            trailing: Switch(
              value: clockConvention,
              onChanged: (value) {
                print('$value');
                setState(() {
                  if (clockConvention == true) {
                    clockConvention = false;
                  } else {
                    clockConvention = true;
                  }
                });
              },
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Notifications',
              style: TextStyle(color: Colors.blue, fontSize: 15.0),
            ),
          ),
          ListTile(
            title: Text('Notify on this device'),
            trailing: Switch(
              value: notificationOn,
              onChanged: (value) {
                print('$value');
                setState(() {
                  if (notificationOn == true) {
                    notificationOn = false;
                  } else {
                    notificationOn = true;
                  }
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Sound'),
            trailing: Switch(
              value: notificationSound,
              onChanged: (value) {
                print('$value');
                setState(() {
                  if (notificationSound == true) {
                    notificationSound = false;
                  } else {
                    notificationSound = true;
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
