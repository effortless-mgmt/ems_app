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

class AvailableAppointmentList extends AppointmentState {
  final List<Appointment> appointments;

  AvailableAppointmentList({@required this.appointments})
      : super([appointments]);

  @override
  String toString() =>
      'Available appointments updated { appointments: $appointments }';
}

class UnapprovedAppointmentList extends AppointmentState {
  final List<Appointment> appointments;

  UnapprovedAppointmentList({@required this.appointments})
      : super([appointments]);

  @override
  String toString() =>
      'Unapproved appointments updated { appointments: $appointments }';
}

class UpcomingAppointmentList extends AppointmentState {
  final List<Appointment> appointments;

  UpcomingAppointmentList({@required this.appointments})
      : super([appointments]);

  @override
  String toString() =>
      'Upcoming appointments updated { appointments: $appointments }';
}

class AllAppointmentList extends AppointmentState {
  final List<Appointment> appointments;

  AllAppointmentList({@required this.appointments}) : super([appointments]);

  @override
  String toString() =>
      'All appointments updated { appointments: $appointments }';
}

class UpcomingAppointmentItem extends AppointmentState {
  final Appointment appointment;

  UpcomingAppointmentItem({@required this.appointment});

  @override
  String toString() =>
      'Closest upcoming appointment { appointment: $appointment }';
}

class UpcomingAndAvailableAppointmentList extends AppointmentState {
  final List<Appointment> availableAppointments;
  final List<Appointment> upcomingAppointments;

  UpcomingAndAvailableAppointmentList(
      {@required this.availableAppointments,
      @required this.upcomingAppointments});

  @override
  String toString() =>
      'Upcoming and available appointments { upcomingAppointments: $upcomingAppointments, availableAppointments: $availableAppointments }';
}

class AppointmentsLoaded extends AppointmentState {
  @override
  String toString() => 'loaded appointments';
}
