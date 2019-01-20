import 'package:ems_app/src/bloc/appointment/appointment_repo.dart';
import 'package:ems_app/src/providers/auth_api_provider.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/providers/appointment_api_provider.dart';
import 'package:ems_app/src/bloc/appointment/appointment_event.dart';
import 'package:ems_app/src/bloc/appointment/appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentApiProvider appointmentApiProvider;
  final AuthApiProvider authApiProvider = AuthApiProvider();

  AppointmentBloc({@required this.appointmentApiProvider})
      : assert(appointmentApiProvider != null);

  @override
  // TODO: implement initialState
  AppointmentState get initialState => AppointmentInitial();

  @override
    Stream<AppointmentEvent> transform(Stream<AppointmentEvent> events) {
      // TODO: implement transform
      return super.transform(events);
    }

  @override
  Stream<AppointmentState> mapEventToState(
      AppointmentState currentState, AppointmentEvent event) async* {
    if (event is LoadUpcomingAppointments) {
      String token = await authApiProvider.readToken();
      List<Appointment> appointments = await appointmentApiProvider.getAppointmentsUpcoming(token: token);
      AppointmentRepository.get().updateUpcomingAppointments(appointments);
      yield AppointmentsLoaded();
    }

    if (event is LoadNextAppointment) {
      Appointment appointment = AppointmentRepository.get().getNextAppointment();
      yield AppointmentStuff(appointment: appointment);
    }
  }
}
