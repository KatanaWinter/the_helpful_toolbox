class requestAppointmentTimes {
  int id;
  bool AnyTime;
  bool Morning;
  bool Afternoon;
  bool Evening;

  requestAppointmentTimes({
    this.id = 1,
    this.AnyTime = true,
    this.Morning = true,
    this.Afternoon = true,
    this.Evening = true,
  });
}
