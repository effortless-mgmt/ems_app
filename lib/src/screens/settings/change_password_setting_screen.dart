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
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Cancel"),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        print("Fuck off 1");
                      },
                    ),
                    RaisedButton(
                      child: Text(
                        "Save changes",
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () {
                        print("Fuck off2");
                      },
                    )
                  ],
                ),
              )
            ],
          )),
      appBar: AppBar(
        title: Text("Change password"),
      ),
    );
  }
}
