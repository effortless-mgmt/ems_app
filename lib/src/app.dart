import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'providers/auth_api_provider.dart';
import 'bloc/auth/auth.dart';
import 'bloc/nav/navbar.dart';

import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/custom_nav_bar.dart';

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
  final _androidTheme =
      ThemeData(primaryColor: Colors.blue[600], accentColor: Colors.blueAccent);

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
                debugPrint('app context: $context');
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
  final NavBarBloc navBarBloc;
  final StreamSubscription streamSubscription;
  final Widget body;

  MainApp({this.navBarBloc, this.streamSubscription, this.body});

  @override
  State<StatefulWidget> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  NavBarBloc _navBarBloc;
  StreamSubscription _streamSubscription;
  Widget _body;

  @override
  void initState() {
    _navBarBloc = widget.navBarBloc ?? NavBarBloc();
    _streamSubscription =
        widget.streamSubscription ?? _navBarBloc.state.listen(onData);
    _body = widget.body ?? LoadingIndicator();
    super.initState();
  }

  void onData(NavBarState state) {
    if (state is NavBarJump) {
      debugPrint('I ran!: $state');
      debugPrint('mainapp context: $context');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainApp(
                // TODO: this context becomes null. pls fix.
                navBarBloc: _navBarBloc,
                streamSubscription: _streamSubscription,
                body: state.screen,
              )));
    }
  }

  @override
  void dispose() {
    // _navBarBloc.dispose();
    debugPrint('I was disposed :(');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavBarBloc>(
      bloc: _navBarBloc,
      child: Scaffold(
        bottomNavigationBar: CustomNavBar(),
        body: _body,
      ),
    );
    // return Container(
    //   child: LoadingIndicator(),
    // );
    // return BlocProvider<NavBarBloc>(
    //   bloc: _navBarBloc,
    //   child: Scaffold(
    //       bottomNavigationBar: CustomNavBar(),
    //       body: BlocBuilder(
    //           bloc: _navBarBloc,
    //           builder: (BuildContext context, NavBarState navBarState) {
    //             if (navBarState is NavBarJump) {
    //               return navBarState.screen;
    //             } else {
    //               // fallback (most likely not needed).
    //               return HomeScreen();
    //             }
    //           })),
    // );
  }
}
