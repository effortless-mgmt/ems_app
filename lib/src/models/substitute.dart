import 'package:ems_app/src/models/appointment.dart';

/// A user with appointments
class Substitute {
  List<Appointment> _appointments;
  List<Appointment> _unregistered = <Appointment>[];

  Substitute([this._appointments]);

  List<Appointment> get appointments {
    _appointments.sort((a, b) => a.start.compareTo(b.start));
    return _appointments;
  }

  List<Appointment> get unapprovedAppointments {
    _unregistered = <Appointment>[];

    for (Appointment e in _appointments) {
      if (!e.approved && e.stop.isBefore(DateTime.now())) {
        _unregistered.add(e);
      }
    }
    return _unregistered;
  }
}
