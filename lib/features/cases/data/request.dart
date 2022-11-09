import 'package:the_helpful_toolbox/features/cases/data/request_appointment_days.dart';
import 'package:the_helpful_toolbox/features/cases/data/request_appointment_times.dart';

class Request {
  int id;
  String details;
  requestAppointmentDays? appointmentDays;
  requestAppointmentTimes? appointmentTimes;
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
