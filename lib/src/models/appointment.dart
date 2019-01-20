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
    // pause may break if minutes go above 59.
    _pause = Duration(minutes: json['break']);
    _workPeriodName = json['workPeriod']['name'];
    _departmentName = json['workPeriod']['department']['name'];
    _departmentAddress = json['workPeriod']['department']['address'].toString();
    _approvedByOwner = json['approvedByOwner'];
    _salary = json['earnings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this._start;
    data['stop'] = this._stop;
    data['break'] = this._pause;
    return data;
  }
}
