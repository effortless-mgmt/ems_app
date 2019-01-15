import 'package:flutter/material.dart';

class CalendarSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool notificationOn = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar settings"),
      ),
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
            title: Text('Start of the week'),
            subtitle: Text("Monday"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text("Start of the week"),
                    children: <Widget>[
                      RadioListTile(
                        title: Text("Saturday"),
                        value: true,
                        activeColor: Colors.black,
                        groupValue: true,
                        onChanged: (value) {
                          print(value);
                        },
                      ),
                      RadioListTile(
                        title: Text("Sunday"),
                        value: true,
                        activeColor: Colors.black,
                        groupValue: false,
                        onChanged: (value) {
                          print(value);
                        },
                      ),
                      RadioListTile(
                        title: Text("Monday"),
                        value: true,
                        activeColor: Colors.black,
                        groupValue: false,
                        onChanged: (value) {
                          print(value);
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
          // Divider(),
          // ListTile(
          //   title: Text('Use device\'s time zone'),
          //   trailing: Switch(
          //     value: notificationOn,
          //     onChanged: (value) {
          //       print("Fuck out");
          //     },
          //   ),
          // ),
          // ListTile(
          //   title: Text("Time zone"),
          //   subtitle: Text("Central European Standard Time GMT+1"),
          // ),
          Divider(),
          ListTile(
            title: Text('Show week number'),
            trailing: Switch(
              value: notificationOn,
              onChanged: (value) {
                print("Fuck off");
              },
            ),
          )
        ],
      ),
    );
  }
}
