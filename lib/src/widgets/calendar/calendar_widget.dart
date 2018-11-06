import 'dart:async';

import 'package:ems_app/src/models/appointment.dart';
import 'package:ems_app/src/widgets/calendar/calendar_tile.dart';
import 'package:ems_app/util/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

typedef DayBuilder(BuildContext context, DateTime day);

class Calendar extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<Tuple2<DateTime, DateTime>> onSelectedRangeChange;
  final bool isExpandable;
  final DayBuilder dayBuilder;
  final bool showChevronsToChangeRange;
  final bool showTodayAction;
  final bool showCalendarPickerIcon;
  final DateTime initialCalendarDateOverride;
  final List<Appointment> appointments;

  Calendar(
      {this.onDateSelected,
      this.onSelectedRangeChange,
      this.isExpandable: true,
      this.dayBuilder,
      this.showTodayAction: true,
      this.showChevronsToChangeRange: true,
      this.showCalendarPickerIcon: true,
      this.initialCalendarDateOverride,
      this.appointments});

  @override
  _CalendarState createState() => new _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarUtils = new DateUtils();
  List<DateTime> selectedMonthsDays;
  Iterable<DateTime> selectedWeeksDays;
  DateTime _selectedDate = new DateTime.now();
  List<Appointment> _appointments;
  String currentMonth;
  bool isExpanded = true;
  String displayMonth;
  Appointment appointment;
  bool selectedHasAppointment = false;
  bool selectedAppointmentIsOld = false;
  int appointmentCount = 0;
  DateTime get selectedDate => _selectedDate;

  void initState() {
    super.initState();
    _appointments = widget.appointments;
    if (widget.initialCalendarDateOverride != null)
      _selectedDate = widget.initialCalendarDateOverride;
    selectedMonthsDays = DateUtils.daysInMonth(_selectedDate);
    var firstDayOfCurrentWeek = DateUtils.firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = DateUtils.lastDayOfWeek(_selectedDate);
    selectedWeeksDays =
        DateUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
            .toList()
            .sublist(0, 7);
    displayMonth = DateUtils.formatMonth(_selectedDate);
  }

  Widget get nameAndIconRow {
    var leftInnerIcon;
    var rightInnerIcon;
    var leftOuterIcon;
    var rightOuterIcon;

    if (widget.showCalendarPickerIcon) {
      rightInnerIcon = new IconButton(
        onPressed: () => selectDateFromPicker(),
        icon: new Icon(Icons.calendar_today),
      );
    } else {
      rightInnerIcon = new Container();
    }

    if (widget.showChevronsToChangeRange) {
      leftOuterIcon = new IconButton(
        onPressed: isExpanded ? previousMonth : previousWeek,
        icon: new Icon(Icons.chevron_left),
      );
      rightOuterIcon = new IconButton(
        onPressed: isExpanded ? nextMonth : nextWeek,
        icon: new Icon(Icons.chevron_right),
      );
    } else {
      leftOuterIcon = new Container();
      rightOuterIcon = new Container();
    }

    if (widget.showTodayAction) {
      leftInnerIcon = new InkWell(
        child: new Text('Today'),
        onTap: resetToToday,
      );
    } else {
      leftInnerIcon = new Container();
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftOuterIcon ?? new Container(),
        leftInnerIcon ?? new Container(),
        new Text(
          displayMonth,
          style: new TextStyle(
            fontSize: 20.0,
          ),
        ),
        rightInnerIcon ?? new Container(),
        rightOuterIcon ?? new Container(),
      ],
    );
  }

  Widget get calendarGridView {
    return new Container(
      child: new GestureDetector(
        onHorizontalDragStart: (gestureDetails) => beginSwipe(gestureDetails),
        onHorizontalDragUpdate: (gestureDetails) =>
            getDirection(gestureDetails),
        onHorizontalDragEnd: (gestureDetails) => endSwipe(gestureDetails),
        child: new GridView.count(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 7,
          padding: new EdgeInsets.only(bottom: 0.0),
          childAspectRatio: 1.4,
          children: calendarBuilder(),
        ),
      ),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
        isExpanded ? selectedMonthsDays : selectedWeeksDays;

    DateUtils.weekdays.forEach(
      (day) {
        dayWidgets.add(
          new CalendarTile(
            isDayOfWeek: true,
            dayOfWeek: day,
          ),
        );
      },
    );

    bool monthStarted = false;
    bool monthEnded = false;

    calendarDays.forEach(
      (day) {
        bool hasAppointment = false;
        bool appointmentIsOld = false;

        for (Appointment a in _appointments) {
          if (DateUtils.isSameDay(a.start, day)) {
            hasAppointment = true;
            if (day.isBefore(DateTime.now())) {
              appointmentIsOld = true;
            }
          }
        }

        if (monthStarted && day.day == 01) {
          monthEnded = true;
        }

        if (DateUtils.isFirstDayOfMonth(day)) {
          monthStarted = true;
        }

        if (this.widget.dayBuilder != null) {
          dayWidgets.add(
            new CalendarTile(
              child: this.widget.dayBuilder(context, day),
              date: day,
              hasAppointment: hasAppointment,
              appointmentIsOld: appointmentIsOld,
              onDateSelected: () => handleSelectedDateAndUserCallback(day),
            ),
          );
        } else {
          dayWidgets.add(
            new CalendarTile(
              onDateSelected: () => handleSelectedDateAndUserCallback(day),
              date: day,
              dateStyles: configureDateStyle(monthStarted, monthEnded, day),
              hasAppointment: hasAppointment,
              appointmentIsOld: appointmentIsOld,
              isSelected: DateUtils.isSameDay(selectedDate, day),
            ),
          );
        }
      },
    );
    return dayWidgets;
  }

  TextStyle configureDateStyle(monthStarted, monthEnded, day) {
    TextStyle dateStyles;
    bool isToday = DateUtils.isSameDay(day, DateTime.now());
    if (isExpanded) {
      dateStyles = monthStarted && !monthEnded
          ? isToday
              ? new TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              : new TextStyle(color: Colors.black)
          : isToday
              ? new TextStyle(
                  color: Colors.black38, fontWeight: FontWeight.bold)
              : new TextStyle(color: Colors.black38);
    } else {
      dateStyles = isToday
          ? new TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
          : new TextStyle(color: Colors.black);
    }
    return dateStyles;
  }

  Widget get expansionButtonRow {
    if (widget.isExpandable) {
      return new Container(
        height: 40.0,
        //WAS A ROW WITH A TEXT, ICONBUTTON AND MAINAXISALIGNMENT.SPACEBETWEEN
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        child: new Center(
          child: selectedHasAppointment
              ? selectedAppointmentIsOld
                  ? new Text(
                      "$appointmentCount old appointment at ${appointment.location}")
                  : DateUtils.isSameDay(selectedDate, DateTime.now())
                      ? Text(
                          "$appointmentCount appointment today at ${appointment.location}")
                      : Text(
                          "$appointmentCount upcoming appointment at ${appointment.location}")
              : DateUtils.isSameDay(selectedDate, DateTime.now())
                  ? new Text("No appointments today")
                  : new Text("No appointments on " +
                      DateUtils.fullDayFormat(selectedDate)),
          // new IconButton(
          //   iconSize: 20.0,
          //   padding: new EdgeInsets.all(0.0),
          //   onPressed: toggleExpanded,
          //   icon: isExpanded
          //       ? new Icon(Icons.arrow_drop_up)
          //       : new Icon(Icons.arrow_drop_down),
          // ),
        ),
      );
    } else {
      return new Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          nameAndIconRow,
          new ExpansionCrossFade(
            collapsed: calendarGridView,
            expanded: calendarGridView,
            isExpanded: isExpanded,
          ),
          expansionButtonRow
        ],
      ),
    );
  }

  void resetToToday() {
    _selectedDate = new DateTime.now();
    var firstDayOfCurrentWeek = DateUtils.firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = DateUtils.lastDayOfWeek(_selectedDate);

    setState(() {
      selectedWeeksDays =
          DateUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = DateUtils.daysInMonth(_selectedDate);
      displayMonth = DateUtils.formatMonth(_selectedDate);
    });

    _launchDateSelectionCallback(_selectedDate);
  }

  void nextMonth() {
    setState(() {
      _selectedDate = DateUtils.nextMonth(_selectedDate);
      var firstDateOfNewMonth = DateUtils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = DateUtils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = DateUtils.daysInMonth(_selectedDate);
      displayMonth = DateUtils.formatMonth(_selectedDate);
    });
  }

  void previousMonth() {
    setState(() {
      _selectedDate = DateUtils.previousMonth(_selectedDate);
      var firstDateOfNewMonth = DateUtils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = DateUtils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = DateUtils.daysInMonth(_selectedDate);
      displayMonth = DateUtils.formatMonth(_selectedDate);
    });
  }

  void nextWeek() {
    setState(() {
      _selectedDate = DateUtils.nextWeek(_selectedDate);
      var firstDayOfCurrentWeek = DateUtils.firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = DateUtils.lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeeksDays =
          DateUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList()
              .sublist(0, 7);
      displayMonth = DateUtils.formatMonth(_selectedDate);
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousWeek() {
    setState(() {
      _selectedDate = DateUtils.previousWeek(_selectedDate);
      var firstDayOfCurrentWeek = DateUtils.firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = DateUtils.lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeeksDays =
          DateUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList()
              .sublist(0, 7);
      displayMonth = DateUtils.formatMonth(_selectedDate);
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void updateSelectedRange(DateTime start, DateTime end) {
    var selectedRange = new Tuple2<DateTime, DateTime>(start, end);
    if (widget.onSelectedRangeChange != null) {
      widget.onSelectedRangeChange(selectedRange);
    }
  }

  Future<Null> selectDateFromPicker() async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );

    if (selected != null) {
      var firstDayOfCurrentWeek = DateUtils.firstDayOfWeek(selected);
      var lastDayOfCurrentWeek = DateUtils.lastDayOfWeek(selected);

      setState(() {
        _selectedDate = selected;
        selectedWeeksDays =
            DateUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
                .toList();
        selectedMonthsDays = DateUtils.daysInMonth(selected);
        displayMonth = DateUtils.formatMonth(selected);
      });
      // updating selected date range based on selected week
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      _launchDateSelectionCallback(selected);
    }
  }

  var gestureStartX;
  var gestureStartY;
  var gestureDirection;

  void beginSwipe(DragStartDetails gestureDetails) {
    gestureStartX = gestureDetails.globalPosition.dx;
    gestureStartY = gestureDetails.globalPosition.dy;
  }

  void getDirection(DragUpdateDetails gestureDetails) {
    var dy = gestureDetails.globalPosition.dy - gestureStartY;
    var dx = gestureDetails.globalPosition.dx - gestureStartX;

    if (dy.abs() > 50 || dx.abs() > 50) {
      if (dy.abs() > dx.abs()) {
        gestureDirection = 'swipeVertical';
        // if (dy > 0) {
        //   gestureDirection = 'upToDown';
        // } else {
        //   gestureDirection = 'downToUp';
        // }
      } else {
        if (dx > 0) {
          gestureDirection = 'leftToRight';
        } else {
          gestureDirection = 'rightToLeft';
        }
      }

      // if (gestureDetails.globalPosition.dx < gestureStartX) {
      //   gestureDirection = 'rightToLeft';
      // } else {
      //   gestureDirection = 'leftToRight';
      // }
    }
  }

  void endSwipe(DragEndDetails gestureDetails) {
    switch (gestureDirection) {
      // case 'downToUp':
      //   if (isExpanded) {
      //     toggleExpanded();
      //   }
      //   break;
      // case 'upToDown':
      //   if (!isExpanded) {
      //     toggleExpanded();
      //   }
      // break;
      case 'swipeVertical':
        print("Swiped vertically");
        toggleExpanded();
        break;
      case 'rightToLeft':
        if (isExpanded) {
          nextMonth();
        } else {
          nextWeek();
        }
        break;
      case 'leftToRight':
        print("Swiped left -> right");
        print("Swiped right -> left");
        if (isExpanded) {
          previousMonth();
        } else {
          previousWeek();
        }
        break;
    }
    // if (gestureDirection == 'upToDown') {
    //   if (!isExpanded) {
    //     toggleExpanded();
    //   }
    // } else if (gestureDirection == 'rightToLeft') {
    //   toggleExpanded();
    //   if (isExpanded) {
    //     // nextMonth();
    //   } else {
    //     nextWeek();
    //   }
    // } else if (gestureDirection == 'leftToRight') {
    //   if (isExpanded) {
    //     previousMonth();
    //   } else {
    //     previousWeek();
    //   }
    // }
  }

  void toggleExpanded() {
    if (widget.isExpandable) {
      setState(() => isExpanded = !isExpanded);
    }
  }

  void handleSelectedDateAndUserCallback(DateTime day) {
    var firstDayOfCurrentWeek = DateUtils.firstDayOfWeek(day);
    var lastDayOfCurrentWeek = DateUtils.lastDayOfWeek(day);
    selectedHasAppointment = false;
    selectedAppointmentIsOld = false;
    appointmentCount = 0;
    for (Appointment a in _appointments) {
      if (DateUtils.isSameDay(a.start, day)) {
        appointment = a;
        selectedHasAppointment = true;
        appointmentCount++;
        if (day.isBefore(DateTime.now())) {
          selectedAppointmentIsOld = true;
        }
      }
    }
    setState(() {
      _selectedDate = day;
      selectedWeeksDays =
          DateUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = DateUtils.daysInMonth(day);
      displayMonth = DateUtils.formatMonth(day);
    });
    _launchDateSelectionCallback(day);
  }

  void _launchDateSelectionCallback(DateTime day) {
    if (widget.onDateSelected != null) {
      widget.onDateSelected(day);
    }
  }
}

class ExpansionCrossFade extends StatelessWidget {
  final Widget collapsed;
  final Widget expanded;
  final bool isExpanded;

  ExpansionCrossFade({this.collapsed, this.expanded, this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      flex: 1,
      child: new AnimatedCrossFade(
        firstChild: collapsed,
        secondChild: expanded,
        firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.decelerate,
        crossFadeState:
            isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
