import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ems_app/src/bloc/settings/settings.dart';

class CalendarSettingScreen extends StatelessWidget {
  final SettingsBloc settingsBloc;

  CalendarSettingScreen({
    @required this.settingsBloc,
  }) : assert(settingsBloc != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar settings"),
        iconTheme: Theme.of(context).accentIconTheme,
      ),
      body: BlocBuilder<SettingsEvent, SettingsState>(
        bloc: settingsBloc,
        builder: (BuildContext context, SettingsState state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'General',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 15.0),
                  ),
                ),
                ListTile(
                  title: Text('Start of the week'),
                  subtitle: Text(state.startOfWeek),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return BlocBuilder<SettingsEvent, SettingsState>(
                          bloc: settingsBloc,
                          builder: (BuildContext context, SettingsState state) {
                            return SimpleDialog(
                              title: Text("Start of the week"),
                              children: <Widget>[
                                RadioListTile(
                                    title: Text("Saturday"),
                                    value: 'Saturday',
                                    activeColor: Theme.of(context).primaryColor,
                                    groupValue: state.startOfWeek,
                                    onChanged: (value) => settingsBloc.dispatch(
                                        ChangeStartOfWeek(startOfWeek: value))),
                                RadioListTile(
                                    title: Text("Sunday"),
                                    value: 'Sunday',
                                    activeColor: Theme.of(context).primaryColor,
                                    groupValue: state.startOfWeek,
                                    onChanged: (value) => settingsBloc.dispatch(
                                        ChangeStartOfWeek(startOfWeek: value))),
                                RadioListTile(
                                    title: Text("Monday"),
                                    value: 'Monday',
                                    activeColor: Theme.of(context).primaryColor,
                                    groupValue: state.startOfWeek,
                                    onChanged: (value) => settingsBloc.dispatch(
                                        ChangeStartOfWeek(startOfWeek: value)))
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                // Divider(),
                // ListTile(
                //   title: Text('Use device\'s time zone'),
                //   trailing: Switch(
                //     value: notificationOn,
                //     onChanged: (value) {
                //       print("Fuck out");
                //     },
                //   ),
                // ),
                // ListTile(
                //   title: Text("Time zone"),
                //   subtitle: Text("Central European Standard Time GMT+1"),
                // ),
                Divider(),
                ListTile(
                  title: Text('Show week number'),
                  trailing: Switch(
                    value: state.showWeekNumber,
                    onChanged: (value) => settingsBloc
                        .dispatch(ToggleWeekNumber(toggleWeeknumber: value)),
                  ),
                ),

                // Switch(
                //   value: true,
                //   onChanged: (value) {
                //     print("Fuck off");
                //   },
                // ),
              ]);
        },
      ),
    );
  }
}
