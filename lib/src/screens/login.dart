import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  VoidCallback _onLogin;

  LoginPage(this._onLogin);

  @override
  Widget build(BuildContext context) {
    var asset = new AssetImage("assets/logo-bw.png");
    return new Scaffold(
        appBar: new AppBar(title: new Text("Log In")),
        body: new Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(24.0)), // Hacky as fuck, I know
            new Image(
              image: asset,
            ),
            new Card(
                margin: EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
                child: _buildLoginForm(context))
          ],
        ));
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
        new ButtonTheme.bar(
            child: new ButtonBar(
          children: <Widget>[
            new RaisedButton(
              child: new Text("LOGIN"),
              onPressed: _onLogin,
            )
          ],
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
