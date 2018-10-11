import 'package:flutter/material.dart';
import 'package:ems_app/shared/chatpage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final defaultTargetPlatform = TargetPlatform.android;
  final _iosTheme = new ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Colors.grey[400],
      primaryColorBrightness: Brightness.dark);

  final _androidTheme = new ThemeData(
      primaryColor: Colors.blue[600], accentColor: Colors.blueAccent);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Chat app',
      theme: defaultTargetPlatform == TargetPlatform.android
          ? _androidTheme
          : _iosTheme,
      home: new ChatPage(),
    );
  }
}
