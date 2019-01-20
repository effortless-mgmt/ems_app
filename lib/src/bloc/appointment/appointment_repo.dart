import 'package:ems_app/src/models/appointment.dart';

class AppointmentRepository {
  static final AppointmentRepository _appointmentRepository =
      AppointmentRepository._internal();
  
  List<Appointment> upcomingAppointments = List<Appointment>();

  // private internal constructor to make it singleton
  AppointmentRepository._internal();

  static AppointmentRepository get() {
    return _appointmentRepository;
  }

  void updateUpcomingAppointments(List<Appointment> appointments) {
    upcomingAppointments = appointments;
    upcomingAppointments.sort((a, b) => a.start.compareTo(b.start));
  }


  Appointment getNextAppointment() {
    return upcomingAppointments.first;
  }
}
