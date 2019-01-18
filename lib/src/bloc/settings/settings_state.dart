import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final String startOfWeek;
  final bool showWeekNumber;
  // final bool startOfWeekRadioButtonState;

  SettingsState({
    @required this.startOfWeek,
    @required this.showWeekNumber,
  }) : super([startOfWeek, showWeekNumber]);

  @override
  String toString() =>
      'Settings changed { startOfWeek: $startOfWeek, weekNumbers: $showWeekNumber }';
}
