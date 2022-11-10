class Job {
  int id;
  bool oneTimeJob;
  DateTime? start_date;
  DateTime? end_date;
  double subtotal;
  double total;
  DateTime? created_at;

  Job({
    this.id = 1,
    this.oneTimeJob = false,
    this.subtotal = 0.00,
    this.total = 0.00,
  });
}
