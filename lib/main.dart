import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'src/app.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    // Whenever a transition occurs (state is changed) print a debug message
    // with current state, event and next state
    debugPrint(transition.toString());
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}
