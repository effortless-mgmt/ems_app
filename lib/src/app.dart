import 'package:flutter/material.dart';
import 'widgets/navbar_widget.dart';

class App extends StatelessWidget {
  final defaultTargetPlatform = TargetPlatform.android;
  final _iosTheme = new ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Colors.grey[400],
      primaryColorBrightness: Brightness.dark);

  final _androidTheme = new ThemeData(
      primaryColor: Colors.blue[600], accentColor: Colors.blueAccent);

  build(context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child),
      title: 'Log Me In',
      theme: defaultTargetPlatform == TargetPlatform.android
          ? _androidTheme
          : _iosTheme,
      home: Navbar(),
    );
  }
}
