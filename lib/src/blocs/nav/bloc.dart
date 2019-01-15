import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'transformer.dart';

class Bloc extends Object with Transformer {
  final _pageController = BehaviorSubject<int>();
  // final _navBarIconsController = BehaviorSubject<int>();

  // Add data to Stream
  Stream<Widget> get page => _pageController.stream.transform(intToPage);
  // Stream<Widget> get navBarIcons =>
  //     _navBarIconsController.stream.transform(stringToAppBar);

  // Change data
  Function(int) get changePage => _pageController.sink.add;
  // Function(int) get changeNavBarIcons => _navBarIconsController.sink.add;

  int currentPageIndex() {
    int value = _pageController.value;
    debugPrint('Page index: $value');
    if (value == null) {
      return 0;
    }
    return value;
  }

  dispose() {
    _pageController.close();
    // _navBarIconsController.close();
  }
}
