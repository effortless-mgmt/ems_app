import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:ems_app/src/bloc/settings/settings_event.dart';
import 'package:ems_app/src/bloc/settings/settings_state.dart';
import 'package:ems_app/src/screens/settings/preferences.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final Preferences prefProvider;
  final SettingsState settingsState;

  SettingsBloc({
    @required this.prefProvider,
    @required this.settingsState
  }) : assert(prefProvider != null, settingsState != null);
  
  @override
    get initialState => settingsState;

  @override
    Stream<SettingsState> mapEventToState(SettingsState currentState, SettingsEvent event) async* {
      if (event is ChangeStartOfWeek) {
        final bool success = await prefProvider.setStartOfTheWeek(event.startOfWeek);
        if (success) {
          yield SettingsState(startOfWeek: event.startOfWeek, showWeekNumber: currentState.showWeekNumber);
        } else {
          yield currentState;
        }
      }

      if (event is ToggleWeekNumber) {
        final bool success = await prefProvider.setWeekNumber(event.toggleWeeknumber);
        if (success) {
          yield SettingsState(startOfWeek: currentState.startOfWeek, showWeekNumber: event.toggleWeeknumber);
        } else {
          yield currentState;
        }
      }
    }
}
