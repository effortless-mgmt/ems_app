import 'package:ems_app/src/screens/appointment_details/next_appointment_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'navbar_event.dart';
import 'navbar_state.dart';
import 'package:ems_app/src/screens/nav_bar_screens.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  @override
  NavBarState get initialState => NavBarJump(
      oldIndex: 0,
      currentIndex: 0,
      screen:
          // NextAppointmentDetailsScreen(appointment: AppointmentDEMO.demodata[4])
          NextAppointmentDetailsScreen()
          );

  @override
  Stream<NavBarState> mapEventToState(
      NavBarState currentState, NavBarEvent event) async* {
    if (event is Jump) {
      yield NavBarJump(
          oldIndex: _getOldIndex(currentState),
          currentIndex: event.newIndex,
          screen: _eventToPage(event));
    }
  }

  int _getOldIndex(NavBarState state) {
    if (state is NavBarJump) {
      return state.currentIndex;
    }
    // fallback to HomeScreen.
    return 0;
  }

  Widget _eventToPage(NavBarEvent event) {
    int index;
    if (event is Jump) {
      index = event.newIndex;
    } else {
      index = 0;
    }

    switch (index) {
      case 0:
        // return NextAppointmentDetailsScreen(
        //     appointment: AppointmentDEMO.demodata[4]);
        return NextAppointmentDetailsScreen();
      case 1:
        return OverviewScreen();
      case 2:
        return AddScreen();
      case 3:
        return CalendarScreen();
      case 4:
        return ProfileScreen();
      default:
        return OverviewScreen();
    }
  }
}
