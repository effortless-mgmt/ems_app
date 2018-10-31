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
                margin: EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
                child: _buildLoginForm(context))
          ],
        )
        // body: new Center(
        );
  }

  Widget _buildLoginForm(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new ListTile(
            title: new Text("Sign In"), trailing: Icon(Icons.verified_user)),
        new FormElement(
          child: new TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: "Email"),
          ),
        ),
        new FormElement(
            child: new TextField(
          obscureText: true,
          decoration: const InputDecoration(
              labelText: "Password", hintText: "yourS3cur3P4ssw0!d"),
        )),
        const Text(
          "Forgot your password?",
        ),
        new ButtonTheme.bar(
            child: const ButtonBar(
          children: <Widget>[const RaisedButton(child: const Text("SIGN IN"))],
        ))
      ],
    );
  }
}

class FormElement extends StatelessWidget {
  final Widget child;
  FormElement({this.child});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      child: this.child,
    );
  }
}
