import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:ems_app/src/models/appointment.dart';

abstract class AppointmentState extends Equatable {
  AppointmentState([List props = const []]) : super(props);
}

class AppointmentInitial extends AppointmentState {
  @override
  String toString() => 'Appointments initial';
}

class AppointmentThing extends AppointmentState {
  final List<Appointment> appointments;

  AppointmentThing({@required this.appointments}) : super([appointments]);

  @override
  String toString() => 'Appointments updated { appointments: $appointments }';
}

class AppointmentStuff extends AppointmentState {
  final Appointment appointment;

  AppointmentStuff({@required this.appointment});

  @override
  String toString() =>
      'Closest upcoming appointment { appointment: $appointment }';
}

class AppointmentsLoaded extends AppointmentState {
  @override
  String toString() =>
      'loaded appointments';
}
