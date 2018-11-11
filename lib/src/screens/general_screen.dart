import 'package:ems_app/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../blocs/provider.dart';

import '../widgets/custom_nav_bar.dart';

class GeneralScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = Provider.of(context);
    return StreamBuilder(
      stream: bloc.appBarIcons,
      builder: (context, snapshot) {
        return Scaffold(
          bottomNavigationBar: CustomNavBar(),
          appBar: snapshot.hasData
              ? snapshot.data
              : AppBar(
                  title: Text('EMS'),
                ),
          body: StreamBuilder(
            stream: bloc.page,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data;
              } else {
                return HomeScreen();
              }
            },
          ),
        );
      },
    );
  }
}
