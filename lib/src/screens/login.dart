import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var asset = new AssetImage("assets/logo.png");
    return new Scaffold(
        appBar: new AppBar(title: new Text("Log In")),
        body: new Column(
          children: <Widget>[
            new Image(
              image: asset,
            ),
            new Card(
                child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                    title: new Text("Sign In"),
                    trailing: Icon(Icons.verified_user)),
                new Container(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: new TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                ),
                const Text(
                  "Forgot your password?",
                ),
                new ButtonTheme.bar(
                    child: const ButtonBar(
                  children: <Widget>[
                    const RaisedButton(child: const Text("NEXT"))
                  ],
                ))
              ],
            )),
          ],
        )
        // body: new Center(
        );
  }
}
