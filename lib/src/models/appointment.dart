class Appointment {
  Appointment([this.date, this.appointment]);

  DateTime date;
  String appointment;
  static List<Appointment> appointments = <Appointment>[
    new Appointment(new DateTime(2018, 10, 26), "Netto Spot"),
    new Appointment(new DateTime(2018, 10, 27), "L'oréal CPD"),
    new Appointment(new DateTime(2018, 10, 28), "H&M Incoming"),
    new Appointment(new DateTime(2018, 10, 29), "Netto Kolonial"),
  ];

  static List<Appointment> get demodata => appointments;
}
