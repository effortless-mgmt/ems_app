import 'dart:async';
import 'package:flutter/material.dart';

// import 'package:ems_app/src/widgets/custom_icons/settings_icon.dart';
import 'package:ems_app/src/screens/nav_bar_screens.dart';

class Transformer {
  final intToPage = StreamTransformer<int, Widget>.fromHandlers(
      handleData: (pageNumber, sink) {
    switch (pageNumber) {
      case 0:
        sink.add(HomeScreen());
        break;
      case 1:
        sink.add(CalenderScreen());
        break;
      case 2:
        sink.add(AddScreen());
        break;
      case 3:
        sink.add(AppointmentDetailsScreen(isJobOffer: false));
        break;
      case 4:
        sink.add(ProfileScreen());
        break;
      // case 5:
      //   sink.add(SettingsScreen());
      //   break;
      default:
    }
  });
  
  // final stringToAppBar = StreamTransformer<int, AppBar>.fromHandlers(
  //   handleData: (appBarName, sink) {
  //     if (appBarName == 4) {
  //       sink.add(new AppBar(
  //         title: Text('EMS'),
  //         actions: <Widget>[SettingsIcon()],
  //       ));
  //     } else if (appBarName == 5) {
  //       sink.add(
  //         new AppBar(
  //           title: Text('Settings'),
  //         ),
  //       );
  //     } else {
  //       sink.add(
  //         new AppBar(
  //           title: Text('EMS'),
  //         ),
  //       );
  //     }
  //   },
  // );
}
