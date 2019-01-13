import 'package:flutter/material.dart';
import 'bloc.dart';

// Provides scoped instances of BlocCommon
class BlocProvider extends InheritedWidget {
  final bloc = Bloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static Bloc of( context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloc;
  }
}
