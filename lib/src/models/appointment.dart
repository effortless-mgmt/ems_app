import 'package:duration/duration.dart';

class Appointment {
  Appointment([this.location, this._start, this._stop, this._pause]);

  DateTime _start, _stop;
  Duration _pause;
  String location;
  bool _approved = false;

  void record(DateTime start, DateTime stop, Duration pause, bool app) {
    _start = start;
    _stop = stop;
    _pause = pause;
    _approved = app;
  }

  DateTime get start => _start;
  DateTime get stop => _stop;
  Duration get pause => _pause;
  Duration get duration => _stop.subtract(_pause).difference(_start);
  String get durationFormatted =>
      printDuration(this.duration, abbreviated: true);
  String get pauseFormatted => printDuration(this.pause, abbreviated: true);
  String get totalFormatted =>
      printDuration(this.duration + this.pause, abbreviated: true);
  String get registeredMessage =>
      "Worked: ${this.durationFormatted} \nBreak: ${this.pauseFormatted} \nTotal: ${this.totalFormatted}";
  bool get approved => _approved;
  set start(start) => _start = start;
  set stop(stop) => _stop = stop;
  set pause(pause) => _pause = pause;
  set approved(app) => _approved = app;

  static List<Appointment> appointments = <Appointment>[
    new Appointment("Netto Spot", new DateTime(2018, 10, 29, 07, 30),
        new DateTime(2018, 10, 29, 15, 30), new Duration(minutes: 30)),
    new Appointment("L'oréal CPD", new DateTime(2018, 10, 30, 09, 00),
        new DateTime(2018, 10, 30, 19, 00), new Duration(minutes: 30)),
    new Appointment("H&M Incoming", new DateTime(2018, 11, 03, 04, 30),
        new DateTime(2018, 11, 03, 13, 00), new Duration(minutes: 30)),
    new Appointment("Netto Kolonial", new DateTime(2018, 11, 04, 07, 00),
        new DateTime(2018, 11, 04, 15, 00), new Duration(minutes: 30)),
    new Appointment("Nilfisk Truck", new DateTime(2018, 11, 06, 06, 00),
        new DateTime(2018, 11, 06, 22, 00), new Duration(minutes: 30)),
    new Appointment("Nilfisk Truck", new DateTime(2018, 11, 07, 06, 00),
        new DateTime(2018, 11, 07, 14, 00), new Duration(minutes: 30)),
    new Appointment("Fiskars Gaveudpakning", new DateTime(2018, 11, 10, 08, 00),
        new DateTime(2018, 11, 10, 16, 00), new Duration(minutes: 30)),
    new Appointment("Fiskars Gaveudpakning", new DateTime(2018, 11, 11, 08, 00),
        new DateTime(2018, 11, 11, 16, 00), new Duration(minutes: 30)),
    new Appointment("Netto Kolonial Nat", new DateTime(2018, 11, 11, 23, 00),
        new DateTime(2018, 11, 11, 07, 00), new Duration(minutes: 30)),
  ];

  static List<Appointment> get demodata => appointments;
}
