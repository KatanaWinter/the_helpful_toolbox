class Job {
  int id;
  bool oneTimeJob;
  DateTime? startDte;
  DateTime? endDate;
  double subtotal;
  double total;
  DateTime? createdAt;

  Job({
    this.id = 1,
    this.oneTimeJob = false,
    this.subtotal = 0.00,
    this.total = 0.00,
  });
}
