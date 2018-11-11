import 'package:flutter/material.dart';
import '../../blocs/provider.dart';

class SettingsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
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
