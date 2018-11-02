import 'package:duration/duration.dart';

class WorkPeriod {
  DateTime _start, _stop;
  Duration _pause;
  WorkPeriod(this._start, this._stop, this._pause);

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
}
