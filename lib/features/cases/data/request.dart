class Request {
  int id;
  String details;
  // requestAppointmentDays? appointmentDays;
  // requestAppointmentTimes? appointmentTimes;
  bool onSiteAssessment;
  String onSiteAssessmentText;
  DateTime? onSiteAssessmentDate;
  DateTime? createdOn;
  DateTime? updatedOn;

  Request({
    this.id = 1,
    this.details = "",
    this.onSiteAssessment = true,
    this.onSiteAssessmentText = "",
  });
}
