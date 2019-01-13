import 'dart:async';
import 'package:flutter/material.dart';

import 'package:ems_app/src/widgets/custom_icons/settings_icon.dart';
import 'package:ems_app/src/screens/nav_bar_screens.dart';

class Transformer {
  final intToPage = StreamTransformer<int, Widget>.fromHandlers(
      handleData: (pageNumber, sink) {
    // if (pageNumber == 0) {
    //   sink.add(new FirstScreen());
    // } else if (pageNumber == 1) {
    //   sink.add(new SecondScreen());
    // } else if (pageNumber == 2) {
    //   sink.add(new ThirdScreen());
    // } else if (pageNumber == 5) {
    //   sink.add(new SettingsScreen());
    // } else {
    //   sink.addError('Transformer intToPage error');
    // }

    switch (pageNumber) {
      case 0:
        sink.add(new HomeScreen());
        break;
      case 1:
        sink.add(new CalenderScreen());
        break;
      case 2:
        sink.add(new AddScreen());
        break;
      case 3:
        sink.add(new ContactsCardScreen());
        break;
      case 4:
        sink.add(new ProfileScreen());
        break;
      case 5:
        sink.add(new SettingsScreen());
        break;
      default:
    }
  });
  final stringToAppBar = StreamTransformer<int, AppBar>.fromHandlers(
    handleData: (appBarName, sink) {
      if (appBarName == 4) {
        sink.add(new AppBar(
          title: Text('EMS'),
          actions: <Widget>[SettingsIcon()],
        ));
      } else if (appBarName == 5) {
        sink.add(
          new AppBar(
            title: Text('Settings'),
          ),
        );
      } else {
        sink.add(
          new AppBar(
            title: Text('EMS'),
          ),
        );
      }
    },
  );
}
