import 'package:flutter/material.dart';
import 'messenger_screen.dart';

class ContactCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => MessengerScreen(),
              ),
            );
          },
          // Navigator.pushNamed(context, '/Jonas');

          child: Text('Contact Card Screeen'),
        ),
      ),
    );
  }
}
