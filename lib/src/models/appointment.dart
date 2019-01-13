import 'package:duration/duration.dart';

class Appointment {
  Appointment(
      [this._address,
      this._department,
      this._description,
      this._start,
      this._stop,
      this._pause,
      this._hourlyWage]);

  /* Maybe ID could come in handy? */

  DateTime _start, _stop;
  Duration _pause;
  String _department;
  String _address;
  String _description;
  num _hourlyWage;

  //Should only be used until we can access API. Will only fetch unapproved appointmens for registration anyway.
  bool _approvedByOwner = false;

  DateTime get start => _start;
  DateTime get stop => _stop;
  Duration get pause => _pause;
  Duration get duration => _stop.subtract(_pause).difference(_start);
  String get department => _department;
  String get address => _address;
  String get description => _description;
  num get hourlyWage => _hourlyWage;

  String get durationFormatted =>
      printDuration(this.duration, abbreviated: true);
  String get pauseFormatted => printDuration(this.pause, abbreviated: true);
  String get totalFormatted =>
      printDuration(this.duration + this.pause, abbreviated: true);
  String get registeredMessage =>
      "Worked: ${this.durationFormatted} \nBreak: ${this.pauseFormatted} \nTotal: ${this.totalFormatted}";
  bool get approvedByOwner => _approvedByOwner;
  set start(start) => _start = start;
  set stop(stop) => _stop = stop;
  set pause(pause) => _pause = pause;
  set approvedByOwner(app) => _approvedByOwner = app;
  set description(dscr) => _description = dscr;
  set hourlyWage(wage) => _hourlyWage = wage;

  void record(DateTime start, DateTime stop, Duration pause, bool isApproved) {
    _start = start;
    _stop = stop;
    _pause = pause;
    _approvedByOwner = isApproved;
  }

  static String mockDescription =
      "Hos Netto Køl vil du typisk stå og pakke i Nettos køleboks. Det er derfor vigtigt, at du husker varmt tøj. Husk også madpakke og sikkerhedssko.";

  static List<Appointment> appointments = <Appointment>[
    new Appointment(
        "Mimersvej 1, 4600 Køge",
        "Netto Køl",
        mockDescription,
        new DateTime(2018, 10, 29, 07, 30),
        new DateTime(2018, 10, 29, 15, 30),
        new Duration(minutes: 30),
        124.38),
    new Appointment(
        "Lærkevej 37, 2670 Greve",
        "L'oréal CPD",
        mockDescription,
        new DateTime(2018, 10, 30, 09, 00),
        new DateTime(2018, 10, 30, 19, 00),
        new Duration(minutes: 30)),
    new Appointment(
        "Lergravsvej 21, 2670 Greve",
        "H&M Incoming",
        mockDescription,
        new DateTime(2018, 11, 03, 04, 30),
        new DateTime(2018, 11, 03, 13, 00),
        new Duration(minutes: 30)),
    new Appointment(
        "Mimersvej 1, 4600 Køge",
        "Netto Kolonial",
        mockDescription,
        new DateTime(2018, 11, 04, 07, 00),
        new DateTime(2018, 11, 04, 15, 00),
        new Duration(minutes: 30)),
    new Appointment(
        "Sommervej 10, 4100 Sorø",
        "Nilfisk Truck",
        mockDescription,
        new DateTime(2018, 11, 06, 06, 00),
        new DateTime(2018, 11, 06, 22, 00),
        new Duration(minutes: 30)),
    new Appointment(
        "Sommervej 10, 4100 Sorø",
        "Nilfisk Truck",
        mockDescription,
        new DateTime(2018, 11, 07, 06, 00),
        new DateTime(2018, 11, 07, 14, 00),
        new Duration(minutes: 30)),
    new Appointment(
        "Venstrupvej 109B, 7100 Fredericia",
        "Fiskars Gaveudpakning",
        mockDescription,
        new DateTime(2018, 11, 10, 08, 00),
        new DateTime(2018, 11, 10, 16, 00),
        new Duration(minutes: 30)),
    new Appointment(
        "Venstrupvej 109B, 7100 Fredericia",
        "Fiskars Gaveudpakning",
        mockDescription,
        new DateTime(2018, 11, 11, 08, 00),
        new DateTime(2018, 11, 11, 16, 00),
        new Duration(minutes: 30)),
    new Appointment(
        "Mimersvej 1, 4600 Køge",
        "Netto Kolonial Nat",
        mockDescription,
        new DateTime(2018, 11, 11, 23, 00),
        new DateTime(2018, 11, 11, 07, 00),
        new Duration(minutes: 30)),
  ];

  static List<Appointment> get demodata => appointments;
}
