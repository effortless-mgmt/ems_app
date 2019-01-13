import 'package:ems_app/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:ems_app/src/blocs/nav/bloc_provider.dart';
import 'package:ems_app/src/widgets/custom_nav_bar.dart';

class GeneralScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = BlocProvider.of(context);
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
                print("no data in snapshot" + snapshot.error);
                return HomeScreen();
              }
            },
          ),
        );
      },
    );
  }
}
