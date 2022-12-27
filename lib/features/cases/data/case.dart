import 'package:flutter/foundation.dart';
import 'package:the_helpful_toolbox/features/cases/data/case_state.dart';
import 'package:the_helpful_toolbox/features/cases/data/case_status.dart';
import 'package:the_helpful_toolbox/features/cases/data/job.dart';
import 'package:the_helpful_toolbox/features/cases/data/quote.dart';
import 'package:the_helpful_toolbox/features/cases/data/request.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';

class Case {
  int id;
  String name;
  Client? client;
  Property property;
  Request? request;
  Quote? quote;
  Job? job;
  // Invoice? invoice;
  CaseState state;
  CaseStatus status;

  Case(
      {this.id = 1,
      this.name = "",
      required this.state,
      required this.status,
      required this.property});

  saveClient() {
    debugPrint("save new Case: $name ");
  }

  edit() {
    debugPrint("edit new Case: $name ");
  }

  delete() {
    debugPrint("delete new Case: $name");
  }
}
