class JobVisit {
  int? id;
  DateTime? start_date;
  DateTime? end_date;
  String note;
  int hours;

  JobVisit({
    required this.note,
    this.hours = 0,
  });
}
