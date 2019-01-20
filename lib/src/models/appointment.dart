import 'package:duration/duration.dart';
import 'package:intl/intl.dart';
// import 'package:meta/meta.dart';

class Appointment {
  int _appointmentId;
  DateTime _start, _stop;
  Duration _pause;
  // int _workPeriodId;
  String _description;
  // int _departmentId;
  String _departmentName;
  String _departmentAddress;
  bool _approvedByOwner;
  // DateTime _approvedByOwnerDate;
  num _salary;

  /// Returns a string date ISO formatted, i.e. "2019-12-24"
  get id => _appointmentId;
  get startDateIso => DateFormat('yyyy-MM-dd').format(_start);
  get start => _start;
  get startTimeFormatted => DateFormat('HH:mm').format(_start);
  get stop => _stop;
  get stopTimeFormatted => DateFormat('HH:mm').format(_stop);
  get pause => _pause;
  get pauseTimeFormatted => prettyDuration(this.pause, abbreviated: true);
  get duration => _stop.subtract(_pause).difference(_start);
  get department => _departmentName;
  get address => _departmentAddress;
  get description => _description;
  get salary => _salary;
  get durationFormatted => prettyDuration(this.duration, abbreviated: true);
  get totalFormatted =>
      prettyDuration(this.duration + this.pause, abbreviated: true);
  get registeredMessage =>
      "Worked: ${this.durationFormatted} \nBreak: ${this.pauseTimeFormatted} \nTotal: ${this.totalFormatted}";
  get approvedByOwner => _approvedByOwner;

  set start(start) => _start = start;
  set stop(stop) => _stop = stop;
  set pause(pause) => _pause = pause;
  set approvedByOwner(app) => _approvedByOwner = app;
  // set description(dscr) => _description = dscr;
  // set salary(wage) => _salary = wage;
  // set department(dep) => _department = dep;
  // set address(add) => _address = add;

  Appointment.fromJson(Map<String, dynamic> json) {
    _appointmentId = json['id'];
    _start = DateTime.parse(json['start']);
    _stop = DateTime.parse(json['stop']);
    _pause = Duration(minutes: json['break']);
    _description =
        json['workPeriod'] != null && json['workPeriod']['description'] != null ? json['workPeriod']['description'] : '';
    _departmentName = json['workPeriod'] != null
        ? json['workPeriod']['department']['name']
        : '';
    _departmentAddress = json['workPeriod'] != null
        ? json['workPeriod']['department']['address']['readableAddress']
        : '';
    _approvedByOwner = json['approvedByOwner'];
    _salary = json['workPeriod'] != null
        ? json['workPeriod']['agreement']['salary']
        : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this._start.toIso8601String();
    data['stop'] = this._stop.toIso8601String();
    data['break'] = this._pause.inMinutes;
    return data;
  }

  @override
  String toString() =>
      'appointmentId: $_appointmentId, start: $_start, stop: $stop, pause: $_pause, description: $_description, approvedByOwner: $_approvedByOwner, salary$_salary';

  String toStringDetailed() =>
      'appointmentId: $_appointmentId, start: $_start, stop: $stop, pause: $_pause, description: $_description, departmentName: $_departmentName, departmentAddress: $_departmentAddress, approvedByOwner: $_approvedByOwner, salary$_salary';
}
