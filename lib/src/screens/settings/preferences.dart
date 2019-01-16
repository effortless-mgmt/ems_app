import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // Instantiation of the SharedPreferences library

  final String _kCalendarStartOfTheWeekPrefs = "startOfTheWeek";
  final String _kCalendarWeekNumberPrefs = "weekNumber";

  /// ------------------------------------------------------------
  /// Calendar settings
  /// ------------------------------------------------------------

  //Method that returns the start of the week.

  Future<String> getStartOfTheWeek() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print(prefs.getString(_kCalendarStartOfTheWeekPrefs) ?? "Sunday");
    return prefs.getString(_kCalendarStartOfTheWeekPrefs) ?? "Sunday";
  }

  // Method that saves the start of the week.

  Future<bool> setStartOfTheWeek(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kCalendarStartOfTheWeekPrefs, value);
  }

  //Method that returns weeknumbers.

  Future<bool> getWeekNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kCalendarWeekNumberPrefs) ?? true;
  }

  // Method that saves weeknumbers.

  Future<bool> setWeekNumber(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kCalendarWeekNumberPrefs, value);
  }
}
