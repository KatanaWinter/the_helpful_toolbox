class requestAppointmentDays {
  int id;
  bool Monday;
  bool Tuesday;
  bool Wednesday;
  bool Thurstday;
  bool Friday;
  bool Saturday;
  bool Sunday;

  requestAppointmentDays({
    this.id = 1,
    this.Monday = true,
    this.Tuesday = true,
    this.Wednesday = true,
    this.Thurstday = true,
    this.Friday = true,
    this.Saturday = true,
    this.Sunday = true,
  });
}
