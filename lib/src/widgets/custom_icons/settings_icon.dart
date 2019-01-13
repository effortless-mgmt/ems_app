import 'package:flutter/material.dart';
import 'package:ems_app/src/blocs/nav/bloc_provider.dart';

class SettingsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    // TODO: implement build

    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        bloc.changePage(5);
        bloc.changeAppBar(5);
      },
    );
  }
}
