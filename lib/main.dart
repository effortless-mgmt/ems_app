import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'src/app.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';

void main() async {
  bool isInDebugMode = false;
  BlocSupervisor().delegate = SimpleBlocDelegate();

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await FlutterCrashlytics().initialize();

  runZoned<Future<Null>>(() async {
    runApp(App());
  }, onError: (error, stackTrace) async {
    await FlutterCrashlytics()
        .reportCrash(error, stackTrace, forceCrash: false);
  });
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    // Whenever a transition occurs (state is changed) print a debug message
    // with current state, event and next state
    debugPrint(transition.toString());
  }
}
