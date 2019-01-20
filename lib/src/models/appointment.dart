import 'package:duration/duration.dart';
import 'package:intl/intl.dart';
// import 'package:meta/meta.dart';

class Appointment {
  int _appointmentId;
  DateTime _start, _stop;
  Duration _pause;
  // int _workPeriodId;
  String _workPeriodName;
  // int _departmentId;
  String _departmentName;
  String _departmentAddress;
  bool _approvedByOwner;
  // DateTime _approvedByOwnerDate;
  num _salary;
  // String _description;

  /// Returns a string date ISO formatted, i.e. "2019-12-24"
  get id => _appointmentId;
  get startDateIso => DateFormat('yyyy-MM-dd').format(_start);
  get start => _start;
  get startTimeFormatted => DateFormat('HH:mm').format(_start);
  get stop => _stop;
  get stopTimeFormatted => DateFormat('HH:mm').format(_stop);
  get pause => _pause;
  get pauseTimeFormatted => printDuration(this.pause, abbreviated: true);
  get duration => _stop.subtract(_pause).difference(_start);
  get department => _departmentName;
  get address => _departmentAddress;
  get description => _workPeriodName;
  get salary => _salary;
  get durationFormatted => printDuration(this.duration, abbreviated: true);
  get totalFormatted =>
      printDuration(this.duration + this.pause, abbreviated: true);
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
    _workPeriodName =
        json['workPeriod'] != null ? json['workPeriod']['name'] : null;
    _departmentName = json['workPeriod'] != null
        ? json['workPeriod']['department']['name']
        : null;
    _departmentAddress = json['workPeriod'] != null
        ? "${json['workPeriod']['department']['address']['street']}, ${json['workPeriod']['department']['address']['city']}, ${json['workPeriod']['department']['address']['zipCOde']}, ${json['workPeriod']['department']['address']['country']}"
        : null;
    _approvedByOwner = json['approvedByOwner'];
    _salary = json['workPeriod'] != null
        ? json['workPeriod']['agreement']['salary']
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this._start;
    data['stop'] = this._stop;
    data['break'] = this._pause;
    return data;
  }

  @override
  String toString() =>
      'appointmentId: $_appointmentId, start: $_start, stop: $stop, pause: $_pause, workPeriodName: $_workPeriodName, approvedByOwner: $_approvedByOwner, salary$_salary';
  
  String toStringDetailed() =>
      'appointmentId: $_appointmentId, start: $_start, stop: $stop, pause: $_pause, workPeriodName: $_workPeriodName, departmentName: $_departmentName, departmentAddress: $_departmentAddress, approvedByOwner: $_approvedByOwner, salary$_salary';
}
