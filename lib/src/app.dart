import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'providers/auth_api_provider.dart';
import 'blocs/auth/auth_utils.dart';
import 'blocs/nav/bloc_provider.dart' as navBlocProvider;

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
            builder: (BuildContext context, AuthenticationState authenticationState) {
              if (authenticationState is AuthenticationUninitialized) {
                return SplashScreen();
              }
              if (authenticationState is AuthenticationAuthenticated) {
                return MainAppWrapper();
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

class MainAppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return navBlocProvider.BlocProvider(
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = navBlocProvider.BlocProvider.of(context);
    // return StreamBuilder(
      // stream: bloc.appBarIcons,
      // builder: (context, snapshot) {
        return Scaffold(
          bottomNavigationBar: CustomNavBar(),
          // appBar: snapshot.hasData
          //     ? snapshot.data
          //     : AppBar(
          //         title: Text('EMS'),
          //       ),
          body: StreamBuilder(
            stream: bloc.page,
            initialData: HomeScreen(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data;
              } else {
                debugPrint("no data in snapshot" + snapshot.toString());
                return HomeScreen();
              }
            },
          ),
        );
      // },
    // );
  }
}
