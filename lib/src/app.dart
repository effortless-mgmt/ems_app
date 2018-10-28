import 'package:flutter/material.dart';
import 'widgets/navbar_widget.dart';

class App extends StatelessWidget {
  build(context) {
    return MaterialApp(
      title: 'Log Me In',
      home: Navbar(),
    );
  }
}
