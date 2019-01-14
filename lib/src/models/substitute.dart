import 'package:ems_app/src/models/appointment.dart';

/// A user with appointments
class Substitute {
  List<Appointment> _appointments = Appointment.demodata;

  Substitute([this._appointments]);

  List<Appointment> get appointments {
    _appointments.sort((a, b) => a.start.compareTo(b.start));
    return _appointments;
  }

  List<Appointment> get unapprovedAppointments {
    List<Appointment> unregistered = <Appointment>[];
    for (Appointment e in _appointments) {
      if (!e.approved && e.stop.isBefore(DateTime.now())) {
        unregistered.add(e);
      }
    }
    return unregistered;
  }
}
