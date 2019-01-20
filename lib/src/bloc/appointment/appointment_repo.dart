import 'package:ems_app/src/models/appointment.dart';

class AppointmentRepository {
  static final AppointmentRepository _appointmentRepository =
      AppointmentRepository._internal();

  List<Appointment> availableAppointments = List<Appointment>();
  List<Appointment> unapprovedAppointments = List<Appointment>();
  List<Appointment> upcomingAppointments = List<Appointment>();
  List<Appointment> allAppointments = List<Appointment>();

  // private internal constructor to make it singleton
  AppointmentRepository._internal();

  static AppointmentRepository get() {
    return _appointmentRepository;
  }

  void updateAvailableAppointments(List<Appointment> appointments) {
    availableAppointments = appointments;
  }

  void updateUnapprovedAppointments(List<Appointment> appointments) {
    unapprovedAppointments = appointments;
  }

  void updateUpcomingAppointments(List<Appointment> appointments) {
    upcomingAppointments = appointments;
  }

  void updateAllAppointments(List<Appointment> appointments) {
    allAppointments = appointments;
  }
}
