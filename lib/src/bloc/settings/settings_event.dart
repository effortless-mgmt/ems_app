import 'package:meta/meta.dart';

abstract class SettingsEvent {}

class ChangeStartOfWeek extends SettingsEvent {
  final String startOfWeek;

  ChangeStartOfWeek({
    @required this.startOfWeek,
  });

  @override
  String toString() => 'changing start of week to: $startOfWeek';
}

class ToggleWeekNumber extends SettingsEvent {
  final bool toggleWeeknumber;

  ToggleWeekNumber({
    @required this.toggleWeeknumber,
  });

  @override
  String toString() => 'toggled week numbers: $toggleWeeknumber';
}
