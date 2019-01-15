import 'package:flutter/material.dart';

class ChangePasswordSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
          margin: EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(labelText: "Current password"),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "New password"),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(labelText: "Re-type new password"),
                ),
              ),
              Row(
                children: <Widget>[
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Text("Fuck off");
                    },
                  ),
                  SizedBox(width: 115.0),
                  FlatButton(
                    child: Text("Save changes"),
                    onPressed: () {
                      print("Fuck off");
                    },
                  )
                ],
              )
            ],
          )),
      appBar: AppBar(
        title: Text("Change password"),
      ),
    );
  }
}
