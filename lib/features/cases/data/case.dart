import 'package:flutter/foundation.dart';
import 'package:the_helpful_toolbox/features/cases/data/quote.dart';
import 'package:the_helpful_toolbox/features/cases/data/request.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';

class Case {
  int id;
  String name;
  Client? client;
  Property? property;
  Request? request;
  Quote? quote;
  var state;
  var status;

  Case({
    this.id = 1,
    this.name = "",
  });

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
  return Case(name: "Our first Case");
}

getAllProperties() {
  return [
    Case(name: "Our first Case"),
    Case(name: "Wuhuu second Case"),
    Case(name: "i need more cases"),
  ];
}
