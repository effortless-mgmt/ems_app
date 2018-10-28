import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Messenger")),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //
          },
          child: Text('Messenger Screen'),
        ),
      ),
    );
  }
}
