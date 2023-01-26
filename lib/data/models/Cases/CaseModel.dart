import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/Cases/CaseNotesModel.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

import 'CaseStateModel.dart';
import 'CaseStatusModel.dart';
import 'Invoice/InvoiceModel.dart';
import 'Jobs/JobModel.dart';
import 'Quote/QuoteModel.dart';
import 'Request/RequestModel.dart';

List<Case> casesFromJson(String str) =>
    List<Case>.from(json.decode(str).map((x) => Case.fromJson(x)));

String casesToJson(List<Case> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Case {
  Case({
    this.id,
    this.name,
    this.clientId,
    this.propertyId,
    this.requestsId,
    this.quoteId,
    this.jobId,
    this.invoiceId,
    this.caseStateId,
    this.caseStatusId,
    this.createdAt,
    this.updatedAt,
    this.client,
    this.propertie,
    this.notes,
    this.request,
    this.quote,
    this.job,
    this.invoice,
    this.state,
    this.status,
  });

  int? id;
  String? name;
  int? clientId;
  int? propertyId;
  int? requestsId;
  int? quoteId;
  int? jobId;
  int? invoiceId;
  int? caseStateId;
  int? caseStatusId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Property? propertie;
  Client? client;
  List<CaseNotes>? notes;
  Request? request;
  Quote? quote;
  Job? job;
  Invoice? invoice;
  CaseState? state;
  CaseStatus? status;

  factory Case.fromJson(Map<String, dynamic> json) => Case(
        id: json["id"] ?? "",
        name: json["name"],
        clientId: json["client_id"] ?? "",
        propertyId: json["property_id"] ?? "",
        requestsId: json["requests_id"] ?? "",
        quoteId: json["quote_id"] ?? "",
        jobId: json["job_id"] ?? "",
        invoiceId: json["invoice_id"] ?? "",
        caseStateId: json["case_state_id"] ?? "",
        caseStatusId: json["case_status_id"] ?? "",
        client: json["client"] ? null : Client.fromJson(json["client"]),
        propertie:
            json["propertie"] ? null : Property.fromJson(json["propertie"]),
        notes: List<CaseNotes>.from(
            json["notes"].map((x) => CaseNotes.fromJson(x))),
        request: json["request"] ? null : Request.fromJson(json["request"]),
        quote: json["quote"] ? null : Quote.fromJson(json["quote"]),
        job: json["job"] ? null : Job.fromJson(json["job"]),
        invoice: json["invoice"] ? null : Invoice.fromJson(json["invoice"]),
        state: json["state"] ? null : CaseState.fromJson(json["state"]),
        status: json["status"] ? null : CaseStatus.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        "client_id": clientId.toString(),
        "property_id": propertyId.toString(),
        "requests_id": requestsId.toString(),
        "quote_id": quoteId.toString(),
        "job_id": jobId.toString(),
        "invoice_id": invoiceId.toString(),
        "case_state_id": caseStateId.toString(),
        "case_status_id": caseStatusId.toString()
      };

  Future<Case> caseStore(context) async {
    Case _case = Case();
    try {
      debugPrint("save new Case: $name");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response =
          await apiService.post(url: '/cases', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _case = Case.fromJson(tmp["data"]);
        return _case;
      } else {
        debugPrint(response.body);
        return _case;
      }
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return _case;
  }

  Future<bool> caseUpdate(context) async {
    try {
      debugPrint("update new case: $name");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = ApiService();
      http.Response response = await apiService.put(
          url: '/cases/$sId', body: body, context: context);

      if (response.statusCode == 200) {
        debugPrint("Update success");
        return true;
      } else {
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return false;
  }

  Future<Case> caseShow(context) async {
    Case _case = Case();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.get(url: "/cases/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _case = Case.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return _case;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return _case;
  }

  Future<bool> caseDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/cases/$sId", context: context);

      if (response.statusCode == 200) {
        debugPrint("Delete success");
        return true;
      } else {
        debugPrint(response.body);
      }

      return false;
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return false;
  }
}

Future<List<Case>> caseIndex(context) async {
  List<Case> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/cases", context: context);
    if (response.statusCode == 200) {
      model = casesFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
