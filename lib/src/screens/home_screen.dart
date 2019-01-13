import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ems_app/src/blocs/auth/auth_utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text('Home Screen'),
              onPressed: () {},
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('Logout'),
              onPressed: () {
                authenticationBloc.dispatch(Logout());
              },
            ),
          )
        ],
      ),
    ));
  }
}
