import 'package:ems_app/src/screens/settings/calendar_setting_screen.dart';
import 'package:ems_app/src/screens/settings/change_password_setting_screen.dart';
import 'package:ems_app/src/screens/settings/theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Settings screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Account',
                style: TextStyle(color: Colors.blue, fontSize: 15.0),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordSettingScreen(),
                  ),
                );
              },
              title: Text('Change password'),
            ),
            ListTile(
              onTap: _showDialog,
              title: Text('Log out'),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'App settings',
                style: TextStyle(color: Colors.blue, fontSize: 15.0),
              ),
            ),
            ListTile(
              title: Text('Theme'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemeSettingScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Calendar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalendarSettingScreen()),
                );
              },
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Need Help?',
                style: TextStyle(color: Colors.blue, fontSize: 15.0),
              ),
            ),
            ListTile(
              title: Text('FAQ'),
              onTap: () {
                print("YOLO");
              },
            ),
            ListTile(
              title: Text('Troubleshooting'),
              onTap: () {
                print("Cool stuff bro");
              },
            ),
            ListTile(
              title: Text('Contact support'),
              onTap: () {
                _launchURL(
                    "mailto:smith@example.org?subject=News&body=New%20plugin");
              },
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'About',
                style: TextStyle(color: Colors.blue, fontSize: 15.0),
              ),
            ),
            ListTile(
              title: Text('What\'s new'),
              onTap: () {
                _launchURL(
                    "https://www.cbronline.com/news/flutter-1-0-released");
              },
            ),
            ListTile(
              title: Text('Rate app'),
              onTap: () {
                _launchURL(
                    "https://support.google.com/googleplay/answer/6209544?hl=en");
              },
            ),
            ListTile(
              title: Text('Terms of use'),
              onTap: () {
                _launchURL("https://en.wikipedia.org/wiki/Terms_of_service");
              },
            ),
            ListTile(
              title: Text('Imprint'),
              onTap: () {
                _launchURL(
                    "https://en.wikipedia.org/wiki/Imprint_(trade_name)");
              },
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Are you sure?"),
          content: new Text(
              "This will erase all data from this device and take you back to the login screen"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "LOG OUT",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                print("You pressed log out");
              },
            ),
            new RaisedButton(
              child: new Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
                print("You pressed cancel");
              },
            ),
          ],
        );
      },
    );
  }
}
