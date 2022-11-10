import 'package:flutter/foundation.dart';
import 'package:the_helpful_toolbox/features/cases/data/case_state.dart';
import 'package:the_helpful_toolbox/features/cases/data/case_status.dart';
import 'package:the_helpful_toolbox/features/cases/data/invoice.dart';
import 'package:the_helpful_toolbox/features/cases/data/job.dart';
import 'package:the_helpful_toolbox/features/cases/data/quote.dart';
import 'package:the_helpful_toolbox/features/cases/data/request.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';

class Case {
  int id;
  String name;
  Client? client;
  Property property;
  Request? request;
  Quote? quote;
  Job? job;
  Invoice? invoice;
  CaseState state;
  CaseStatus status;

  Case(
      {this.id = 1,
      this.name = "",
      required this.state,
      required this.status,
      required this.property});

  saveClient() {
    debugPrint("save new Case: ${this.name} ");
  }

  edit() {
    debugPrint("edit new Case: ${this.name} ");
  }

  delete() {
    debugPrint("delete new Case: ${this.name}");
  }
}

getSingleCase(int caseId) {
  debugPrint("ToDo: create connection to database");
  return Case(
      name: "Our first Case",
      state: CaseState(name: "Request"),
      status: CaseStatus(name: "New"),
      property: getSingleProperty(1));
}

getAllCases() {
  return [
    Case(
        name: "Our first Case",
        state: CaseState(name: "Request"),
        status: CaseStatus(name: "New"),
        property: getSingleProperty(1)),
    Case(
        name: "Wuhuu second Case",
        state: CaseState(name: "Request"),
        status: CaseStatus(name: "Decline"),
        property: getSingleProperty(1)),
    Case(
        name: "i need more cases",
        state: CaseState(name: "Request"),
        status: CaseStatus(name: "Converted to Quote"),
        property: getSingleProperty(1)),
  ];
}

getCasesOfClient(Client client) {
  return [
    Case(
        name: "Our first Case",
        state: CaseState(name: "Request"),
        status: CaseStatus(name: "New"),
        property: getSingleProperty(1)),
    Case(
        name: "Wuhuu second Case",
        state: CaseState(name: "Request"),
        status: CaseStatus(name: "Decline"),
        property: getSingleProperty(1)),
    Case(
        name: "i need more cases",
        state: CaseState(name: "Request"),
        status: CaseStatus(name: "Converted to Quote"),
        property: getSingleProperty(1)),
  ];
}
