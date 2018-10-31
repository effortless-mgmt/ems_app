import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Settings screen'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //
          },
          child: Text('Settings Screen'),
        ),
      ),
    );
  }
}
