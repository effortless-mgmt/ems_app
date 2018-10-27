import 'package:ems_app/shared/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'EMS',
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Scaffold(
            appBar: new AppBar(title: new Text("Test")),
            body: new LoginPage()));
  }
}
