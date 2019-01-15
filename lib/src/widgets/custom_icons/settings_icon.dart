import 'package:flutter/material.dart';

import 'package:ems_app/src/screens/settings_screen.dart';

class SettingsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsScreen()));
      },
    );
  }
}
