import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ems_app/src/bloc/auth/auth.dart';
import 'package:ems_app/src/widgets/loading_indicator.dart';
import 'package:ems_app/src/widgets/custom_icons/settings_icon.dart';

class ProfileScreen extends StatelessWidget {
  // final ImageProvider<dynamic> avatarPic = NetworkImage(
  //     'https://thediplomat.com/wp-content/uploads/2017/10/thediplomat-ap_923638204453-386x261.jpg');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      builder: (BuildContext context, AuthenticationState authState) {
        if (authState is AuthenticationLoading) {
          return LoadingIndicator();
        }
        if (authState is AuthenticationAuthenticated) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Profile"),
                actions: <Widget>[SettingsIcon()],
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20.0),
                    ),
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage('${authState.user.profilePictureUrl}'),
                      radius: 80.0,
                    ),
                    Container(
                      height: 20.0,
                    ),
                    Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.portrait,
                                color:
                                    Theme.of(context).primaryIconTheme.color),
                            title: Text(
                                '${authState.user.firstName} ${authState.user.lastName}'),
                            subtitle: Text('Name'),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.map,
                                color:
                                    Theme.of(context).primaryIconTheme.color),
                            title: Text('${authState.user.address}'),
                            subtitle: Text('Address'),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.phone,
                                color:
                                    Theme.of(context).primaryIconTheme.color),
                            title: Text('${authState.user.phone}'),
                            subtitle: Text('Phone'),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.email,
                                color:
                                    Theme.of(context).primaryIconTheme.color),
                            title: Text('${authState.user.email}'),
                            subtitle: Text('Email'),
                          ),
                          // Divider(),
                          // ListTile(
                          //   leading: Icon(Icons.local_atm,
                          //       color:
                          //           Theme.of(context).primaryIconTheme.color),
                          //   title: Text('None'),
                          //   subtitle: Text('Tax Card'),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        }
      },
    );
  }
}
