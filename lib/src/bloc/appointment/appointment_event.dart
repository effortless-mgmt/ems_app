import 'package:ems_app/src/models/appointment.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  AppointmentEvent([List props = const []]) : super(props);
}

class LoadAppointments extends AppointmentEvent {
  @override
  String toString() => 'Load appointments';
}

class LoadAvailableAppointments extends AppointmentEvent {
  @override
  String toString() => 'Load available appointments';
}

class LoadUpcomingAppointments extends AppointmentEvent {
  @override
  String toString() => 'Load upcoming appointments';
}

class LoadUnapprovedAppointments extends AppointmentEvent {
  @override
  String toString() => 'Load unapproved appointments';
}

class LoadUpcomingAndAvailableAppointments extends AppointmentEvent {
  @override
  String toString() => 'Load upcoming and available appointments';
}

class LoadNextAppointment extends AppointmentEvent {
  @override
  String toString() => 'Load next appointment';
}

class ApproveAppointment extends AppointmentEvent {
  final int id;
  ApproveAppointment({@required this.id}) : super([id]);

  @override
  String toString() => 'Approve appointment with id: $id';
}

class ModifyAppointment extends AppointmentEvent {
  final Appointment appointment;
 
  ModifyAppointment({
    @required this.appointment,
  });

  @override
  String toString() =>
      'Modify appointment { id: ${appointment.id}, start: ${appointment.start}, stop: ${appointment.stop}, pause: ${appointment.pause} }';
}

class ClaimAppointment extends AppointmentEvent {
  final int id;
  ClaimAppointment({@required this.id}) : super([id]);

  @override
  String toString() => 'Claimed appointment { id: $id }';
}
