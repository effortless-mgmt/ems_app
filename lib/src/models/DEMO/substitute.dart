import 'package:ems_app/src/models/DEMO/appointment.dart';

/// A user with appointments
class Substitute {
  List<AppointmentDEMO> _appointments;
  List<AppointmentDEMO> _unregistered = <AppointmentDEMO>[];

  Substitute([this._appointments]);

  List<AppointmentDEMO> get appointments {
    _appointments.sort((a, b) => a.start.compareTo(b.start));
    return _appointments;
  }

  List<AppointmentDEMO> get unapprovedAppointments {
    _unregistered = <AppointmentDEMO>[];

    for (AppointmentDEMO e in _appointments) {
      if (!e.approvedByOwner && e.stop.isBefore(DateTime.now())) {
        _unregistered.add(e);
      }
    }
    return _unregistered;
  }
}
