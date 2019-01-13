import 'package:ems_app/src/screens/messenger_screen.dart';
import 'package:ems_app/util/user.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactListTile extends ListTile {
  ContactListTile({User user})
      : super(
          leading: CircleAvatar(
              backgroundImage: NetworkImage(user.imgURL), radius: 20.0),
          title: Text("${user.firstName} ${user.lastName}"),
          subtitle: Text(user.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MessageIcon(),
              CallIcon(phoneNumber: user.phoneNumber)
            ],
          ),
        );
}

class MessageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.chat),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => MessengerScreen(),
            ),
          );
        });
  }
}

class CallIcon extends StatelessWidget {
  final int phoneNumber;

  CallIcon({this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.call),
        onPressed: () {
          launch("tel://$phoneNumber");
        });
  }
}
