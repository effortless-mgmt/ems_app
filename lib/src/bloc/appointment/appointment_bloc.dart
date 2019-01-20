import 'package:ems_app/src/bloc/appointment/appointment_repo.dart';
import 'package:ems_app/src/bloc/auth/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/providers/appointment_api_provider.dart';
import 'package:ems_app/src/bloc/appointment/appointment_event.dart';
import 'package:ems_app/src/bloc/appointment/appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentApiProvider appointmentApiProvider;

  AppointmentBloc({@required this.appointmentApiProvider})
      : assert(appointmentApiProvider != null);

  @override
  AppointmentState get initialState => AppointmentInitial();

  @override
  Stream<AppointmentState> mapEventToState(
      AppointmentState currentState, AppointmentEvent event) async* {
    if (event is LoadAppointments) {
      String token = await AuthenticationRepository.get().readToken();
      List<Appointment> appointments =
          await appointmentApiProvider.getAllAppointments(token: token);
      AppointmentRepository.get().updateAllAppointments(appointments);
      yield AllAppointmentList(appointments: appointments);
    }

    if (event is LoadAvailableAppointments) {
      String token = await AuthenticationRepository.get().readToken();
      List<Appointment> appointments =
          await appointmentApiProvider.getAppointmentsAvailable(token: token);
      AppointmentRepository.get().updateAvailableAppointments(appointments);
      yield AvailableAppointmentList(appointments: appointments);
    }

    if (event is LoadUnapprovedAppointments) {
      String token = await AuthenticationRepository.get().readToken();
      List<Appointment> appointments =
          await appointmentApiProvider.getAppointmentsUnapproved(token: token);
      AppointmentRepository.get().updateUnapprovedAppointments(appointments);
      yield UnapprovedAppointmentList(appointments: appointments);
    }

    if (event is LoadUpcomingAppointments) {
      String token = await AuthenticationRepository.get().readToken();
      List<Appointment> appointments =
          await appointmentApiProvider.getAppointmentsUpcoming(token: token);
      AppointmentRepository.get().updateUpcomingAppointments(appointments);
      yield UpcomingAppointmentList(appointments: appointments);
    }

    if (event is LoadUpcomingAndAvailableAppointments) {
      String token = await AuthenticationRepository.get().readToken();
      List<Appointment> availableAppointments =
          await appointmentApiProvider.getAppointmentsAvailable(token: token);
      AppointmentRepository.get()
          .updateAvailableAppointments(availableAppointments);
      List<Appointment> upcomingAppointments =
          await appointmentApiProvider.getAppointmentsUpcoming(token: token);
      AppointmentRepository.get()
          .updateUpcomingAppointments(upcomingAppointments);
      yield UpcomingAndAvailableAppointmentList(
          availableAppointments: availableAppointments,
          upcomingAppointments: upcomingAppointments);
    }

    if (event is LoadNextAppointment) {
      String token = await AuthenticationRepository.get().readToken();
      Appointment appointment =
          await appointmentApiProvider.getAppointmentUpcomingNext(token: token);
      // yield AppointmentsLoaded();
      yield UpcomingAppointmentItem(appointment: appointment);
    }

    if (event is ClaimAppointment) {
      String token = await AuthenticationRepository.get().readToken();
      await appointmentApiProvider.claimAppointmentAvailable(
          token: token, id: event.id);
      yield AppointmentClaimed();
      this.dispatch(LoadUpcomingAndAvailableAppointments());
    }
  }
}
