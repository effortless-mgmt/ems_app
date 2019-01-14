import 'package:flutter/material.dart';
// import 'package:ems_app/src/blocs/nav/bloc_provider.dart';
import 'package:ems_app/src/screens/settings_screen.dart';

class SettingsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of(context);
    // TODO: implement build

    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
      },
    );
  }
}
