/* Copyright 2018 AppTree SoftWare

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */

import 'package:ems_app/src/util/date_utils.dart';
import 'package:flutter/material.dart';

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool hasAppointment;
  final bool appointmentIsOld;
  final bool appointmentIsApproved;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;

  CalendarTile(
      {this.onDateSelected,
      this.date,
      this.child,
      this.dateStyles,
      this.dayOfWeek,
      this.dayOfWeekStyles,
      this.isDayOfWeek: false,
      this.isSelected: false,
      this.hasAppointment,
      this.appointmentIsOld,
      this.appointmentIsApproved});

  Widget renderDateOrDayOfWeek(BuildContext context) {
    bool notNull(Object o) => o != null;

    if (isDayOfWeek) {
      return new InkWell(
        child: new Container(
          alignment: Alignment.center,
          child: new Text(
            dayOfWeek,
            style: dayOfWeekStyles,
          ),
        ),
      );
    } else {
      return new InkWell(
        onTap: onDateSelected,
        child: new Container(
          decoration: isSelected
              ? new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                )
              : new BoxDecoration(),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: hasAppointment ? const EdgeInsets.only(top: 5.0) : null,
                child: new Text(
                  DateUtils.formatDay(date).toString(),
                  style: isSelected
                      ? DateUtils.isSameDay(date, DateTime.now())
                          ? new TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)
                          : new TextStyle(color: Colors.white)
                      : dateStyles,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(height: 5.0),
              hasAppointment
                  ? appointmentIsOld
                      ? appointmentIsApproved
                          ? new CircleAvatar(
                              backgroundColor: Colors.grey, radius: 3.0)
                          : new CircleAvatar(
                              backgroundColor: Colors.orange, radius: 3.0)
                      : new CircleAvatar(
                          backgroundColor: Colors.blueAccent, radius: 3.0)
                  : null,
            ].where(notNull).toList(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return new InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: renderDateOrDayOfWeek(context),
    );
  }
}
