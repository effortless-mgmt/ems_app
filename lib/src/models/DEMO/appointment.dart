import 'package:duration/duration.dart';
import 'package:ems_app/src/models/DEMO/user.dart';
import 'package:intl/intl.dart';

class AppointmentDEMO {
  AppointmentDEMO(
      [this._address,
      this._department,
      this._description,
      this._start,
      this._stop,
      this._pause,
      this._hourlyWage,
      this._owner]);

  /* Maybe ID could come in handy? */

  DateTime _start, _stop;
  Duration _pause;
  String _department;
  String _address;
  String _description;
  UserDEMO _owner;
  num _hourlyWage;

  //Should only be used until we can access API. Will only fetch unapproved appointmens for registration anyway.
  bool _approvedByOwner = false;

  /// Returns a string date ISO formatted, i.e. "2019-12-24"
  String get startDateIso => new DateFormat('yyyy-MM-dd').format(_start);
  DateTime get start => _start;
  String get startTimeFormatted => new DateFormat('HH:mm').format(_start);
  DateTime get stop => _stop;
  String get stopTimeFormatted => new DateFormat('HH:mm').format(_stop);
  Duration get pause => _pause;
  String get pauseTimeFormatted => printDuration(this.pause, abbreviated: true);
  Duration get duration => _stop.subtract(_pause).difference(_start);
  String get department => _department;
  String get address => _address;
  String get description => _description;
  UserDEMO get owner => _owner;
  num get hourlyWage => _hourlyWage;

  String get durationFormatted =>
      printDuration(this.duration, abbreviated: true);
  String get totalFormatted =>
      printDuration(this.duration + this.pause, abbreviated: true);
  String get registeredMessage =>
      "Worked: ${this.durationFormatted} \nBreak: ${this.pauseTimeFormatted} \nTotal: ${this.totalFormatted}";
  bool get approvedByOwner => _approvedByOwner;
  set start(start) => _start = start;
  set stop(stop) => _stop = stop;
  set pause(pause) => _pause = pause;
  set approvedByOwner(app) => _approvedByOwner = app;
  set description(dscr) => _description = dscr;
  set hourlyWage(wage) => _hourlyWage = wage;
  set department(dep) => _department = dep;
  set address(add) => _address = add;
  set owner(user) => _owner = user;

  void record(DateTime start, DateTime stop, Duration pause, bool isApproved) {
    _start = start;
    _stop = stop;
    _pause = pause;
    _approvedByOwner = isApproved;
  }

  static String mockDescription =
      "Hos Netto Køl vil du typisk stå og pakke i Nettos køleboks. Det er derfor vigtigt, at du husker varmt tøj. Husk også madpakke og sikkerhedssko.";

  static List<AppointmentDEMO> appointments = <AppointmentDEMO>[
    new AppointmentDEMO(
        "Mimersvej 1, 4600 Køge",
        "Netto Køl",
        mockDescription,
        new DateTime(2018, 12, 29, 07, 30),
        new DateTime(2018, 12, 29, 15, 30),
        new Duration(minutes: 30),
        124.38),
    new AppointmentDEMO(
        "Lærkevej 37, 2670 Greve",
        "L'oréal CPD",
        mockDescription,
        new DateTime(2018, 12, 30, 09, 00),
        new DateTime(2018, 12, 30, 19, 00),
        new Duration(minutes: 30),
        144.17),
    new AppointmentDEMO(
        "Lergravsvej 21, 2670 Greve",
        "H&M Incoming",
        mockDescription,
        new DateTime(2019, 01, 03, 04, 30),
        new DateTime(2019, 01, 03, 13, 00),
        new Duration(minutes: 30),
        138.38),
    new AppointmentDEMO(
        "Mimersvej 1, 4600 Køge",
        "Netto Kolonial",
        mockDescription,
        new DateTime(2019, 01, 18, 07, 00),
        new DateTime(2019, 01, 18, 15, 00),
        new Duration(minutes: 30),
        124.38),
    new AppointmentDEMO(
        "Sommervej 10, 4100 Sorø",
        "Nilfisk Truck",
        mockDescription,
        new DateTime(2019, 01, 20, 06, 00),
        new DateTime(2019, 01, 20, 22, 00),
        new Duration(minutes: 30),
        141.38),
    new AppointmentDEMO(
        "Sommervej 10, 4100 Sorø",
        "Nilfisk Truck",
        mockDescription,
        new DateTime(2019, 01, 21, 06, 00),
        new DateTime(2019, 01, 21, 14, 00),
        new Duration(minutes: 30),
        141.38),
    new AppointmentDEMO(
        "Venstrupvej 109B, 7100 Fredericia",
        "Fiskars Gaveudpakning",
        mockDescription,
        new DateTime(2019, 01, 24, 08, 00),
        new DateTime(2019, 11, 24, 16, 00),
        new Duration(minutes: 30),
        178.66),
    new AppointmentDEMO(
        "Venstrupvej 109B, 7100 Fredericia",
        "Fiskars Gaveudpakning",
        mockDescription,
        new DateTime(2019, 01, 25, 08, 00),
        new DateTime(2019, 01, 25, 16, 00),
        new Duration(minutes: 30),
        178.66),
    new AppointmentDEMO(
        "Mimersvej 1, 4600 Køge",
        "Netto Kolonial Nat",
        mockDescription,
        new DateTime(2019, 01, 28, 23, 00),
        new DateTime(2019, 01, 28, 07, 00),
        new Duration(minutes: 30),
        124.38),
  ];

  static List<AppointmentDEMO> get demodata => appointments;
}