import 'package:flutter/material.dart';

import 'package:ems_app/src/widgets/custom_icons/settings_icon.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ImageProvider<dynamic> avatarPic = NetworkImage(
        'https://thediplomat.com/wp-content/uploads/2017/10/thediplomat-ap_923638204453-386x261.jpg');

    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: <Widget>[SettingsIcon()],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
              ),
              CircleAvatar(
                backgroundImage: avatarPic,
                radius: 80.0,
              ),
              Container(
                height: 20.0,
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      //trailing: Text('data'),
                      leading: Icon(Icons.portrait,
                          color: Theme.of(context).primaryIconTheme.color),
                      title: Text('Kim Jong Un'),
                      subtitle: Text('Name'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.map,
                          color: Theme.of(context).primaryIconTheme.color),
                      title: Text('조선민주주의인민공화국'),
                      subtitle: Text('Address'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone,
                          color: Theme.of(context).primaryIconTheme.color),
                      title: Text('+850 2 18111'),
                      subtitle: Text('Phone'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email,
                          color: Theme.of(context).primaryIconTheme.color),
                      title: Text('김정은@김.은'),
                      subtitle: Text('Email'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.local_atm,
                          color: Theme.of(context).primaryIconTheme.color),
                      title: Text('None'),
                      subtitle: Text('Tax Card'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
