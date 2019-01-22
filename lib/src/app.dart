import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ems_app/src/providers/auth_api_provider.dart';
import 'package:ems_app/src/bloc/auth/auth.dart';
import 'package:ems_app/src/bloc/nav/navbar.dart';
import 'package:ems_app/src/screens/overview_screen.dart';
import 'package:ems_app/src/screens/splash_screen.dart';
import 'package:ems_app/src/screens/login_screen.dart';
import 'package:ems_app/src/widgets/loading_indicator.dart';
import 'package:ems_app/src/widgets/custom_nav_bar.dart';

class App extends StatefulWidget {
  final AuthApiProvider authApiProvider;

  App({Key key, this.authApiProvider}) : super(key: key);

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;
  AuthApiProvider _authApiProvider;

  final defaultTargetPlatform = TargetPlatform.android;
  final _iosTheme = ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Colors.grey[400],
      primaryColorBrightness: Brightness.dark);
  // final _androidTheme = ThemeData(
  //   brightness: Brightness.light,
  //   primarySwatch: Colors.blue, // Background of buttons
  //   primaryColorLight:
  //       Colors.blue[200], //A lighter version of the primaryColor.
  //   primaryColor: Colors.blue[
  //       500], // The background color for major parts of the app (toolbars, tab bars, etc)
  //   primaryColorDark: Colors.blue[700], //
  //   //accentColor: Colors.black,
  //   bottomAppBarColor: Colors.yellow, // Do not work
  //   textTheme: TextTheme(
  //     button: TextStyle(
  //         color:
  //             Colors.white), //Used for text on [RaisedButton] and [FlatButton].
  //   ),
  // );
  // final _androidTheme = ThemeData(
  //     // brightness: Brightness.dark,
  //     // primaryColorLight:
  //     //     Colors.blue[200], //A lighter version of the primaryColor.
  //     // primaryColor: Colors.blue[
  //     //     500], // The background color for major parts of the app (toolbars, tab bars, etc)
  //     // primaryColorDark: Colors.blue[700],
  //     accentColor: Colors.blue[700],
  //     // primaryColor: Colors.orange[300],
  //     // accentColor: Colors.deepOrangeAccent[700],
  //     textTheme: TextTheme(
  //       overline: TextStyle(color: Colors.blue[500]),
  //     ));

  final _androidTheme = ThemeData(
      primaryTextTheme: TextTheme(button: TextStyle(color: Colors.white)),
      primaryColor: Color.fromRGBO(50, 98, 105, 1),
      accentColor: Color.fromRGBO(115, 188, 165, 1),
      iconTheme: IconThemeData(color: Color.fromRGBO(62, 14, 92, 1)),
      accentIconTheme: IconThemeData(color: Color.fromRGBO(197, 210, 219, 1)),
      primaryIconTheme: IconThemeData(color: Color.fromRGBO(105, 57, 150, 1)));

  @override
  void initState() {
    _authApiProvider = widget.authApiProvider ?? AuthApiProvider();
    _authenticationBloc = AuthenticationBloc(authApiProvider: _authApiProvider);
    _authenticationBloc.dispatch(AppStart());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
          builder: (context, child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child),
          theme: defaultTargetPlatform == TargetPlatform.android
              ? _androidTheme
              : _iosTheme,
          home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
            bloc: _authenticationBloc,
            builder: (BuildContext context,
                AuthenticationState authenticationState) {
              if (authenticationState is AuthenticationUninitialized) {
                return SplashScreen();
              }
              if (authenticationState is AuthenticationAuthenticated) {
                return MainApp();
              }
              if (authenticationState is AuthenticationUnauthenticated) {
                return LoginScreen(authApiProvider: _authApiProvider);
              }
              if (authenticationState is AuthenticationLoading) {
                return LoadingIndicator();
              }
            },
          )),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  NavBarBloc _navBarBloc;

  @override
  void initState() {
    _navBarBloc = NavBarBloc();
    super.initState();
  }

  @override
  void dispose() {
    _navBarBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavBarBloc>(
      bloc: _navBarBloc,
      child: Scaffold(
          bottomNavigationBar: CustomNavBar(),
          body: BlocBuilder(
              bloc: _navBarBloc,
              builder: (BuildContext context, NavBarState navBarState) {
                if (navBarState is NavBarJump) {
                  return navBarState.screen;
                } else {
                  // fallback (most likely not needed).
                  return OverviewScreen();
                }
              })),
    );
  }
}
