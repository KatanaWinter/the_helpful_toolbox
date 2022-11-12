class JobVisit {
  int? id;
  DateTime? startDate;
  DateTime? endDate;
  String note;
  int hours;

  JobVisit({
    required this.note,
    this.hours = 0,
  });
}
