import 'dart:async';
import 'package:flutter/material.dart';
import 'transformer.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Transformer {
  final _pageController = BehaviorSubject<int>();
  final _appBarIconsController = BehaviorSubject<int>();

// //Add data to Stream
  Stream<Widget> get page => _pageController.stream.transform(intToPage);
  Stream<Widget> get appBarIcons =>
      _appBarIconsController.stream.transform(stringToAppBar);

//Change data
  Function(int) get changePage => _pageController.sink.add;
  Function(int) get changeAppBar => _appBarIconsController.sink.add;

  int giveInt() {
    int value = _pageController.value;
    if (value == null) {
      return 0;
    } else if (value == 5) {
      return 4;
    }
    return value;
  }

  dispose() {
    _pageController.close();
    _appBarIconsController.close();
  }
}
