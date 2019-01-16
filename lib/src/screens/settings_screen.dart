import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ems_app/src/screens/settings/calendar_setting_screen.dart';
import 'package:ems_app/src/screens/settings/change_password_setting_screen.dart';
import 'package:ems_app/src/screens/settings/theme_screen.dart';
import 'package:ems_app/src/bloc/auth/auth.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Account',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15.0),
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
              onTap: () => _showDialog(context),
              title: Text('Log out'),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'App settings',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15.0),
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
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15.0),
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
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15.0),
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

  void _showDialog(BuildContext context) {
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
                BlocProvider.of<AuthenticationBloc>(context).dispatch(Logout());
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                print("You pressed log out");
              },
            ),
            new RaisedButton(
              child: new Text(
                "CANCEL",
                style: Theme.of(context).textTheme.button,
              ),
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
