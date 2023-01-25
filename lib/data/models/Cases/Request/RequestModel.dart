import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/Cases/Request/AppointmentDaysModel.dart';
import 'package:the_helpful_toolbox/data/models/Cases/Request/AppointmentTimesModel.dart';
import 'package:the_helpful_toolbox/data/models/Cases/Request/OnSiteAssessmentModel.dart';
import 'package:the_helpful_toolbox/features/cases/data/case.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<Request> requestsFromJson(String str) =>
    List<Request>.from(json.decode(str).map((x) => Request.fromJson(x)));

String requestsToJson(List<Request> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Request {
  Request({
    this.id,
    this.details,
    this.appointment_times_id,
    this.appointment_days_id,
    this.on_site_assessment_id,
    this.createdAt,
    this.updatedAt,
    this.sCase,
    this.appointmentTime,
    this.appointmentDays,
    this.onSiteAssessment,
  });

  int? id;
  String? details;
  int? appointment_times_id;
  int? appointment_days_id;
  int? on_site_assessment_id;
  DateTime? createdAt;
  DateTime? updatedAt;
  Case? sCase;
  AppointmentTimes? appointmentTime;
  AppointmentDays? appointmentDays;
  OnSiteAssessment? onSiteAssessment;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        details: json["details"] ?? "",
        appointment_times_id: json["appointment_times_id"] ?? "",
        appointment_days_id: json["appointment_days_id"] ?? "",
        on_site_assessment_id: json["on_site_assessment_id"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sCase: json["case"] == null ? null : json["case"],
        appointmentTime: json["appointment_times"] == null
            ? null
            : json["appointment_times"],
        appointmentDays:
            json["appointment_days"] == null ? null : json["appointment_days"],
        onSiteAssessment: json["on_site_assessment"] == null
            ? null
            : json["on_site_assessment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "details": details,
        "appointment_times_id": appointment_times_id.toString(),
        "appointment_days_id": appointment_days_id.toString(),
        "on_site_assessment_id": on_site_assessment_id.toString()
      };

  Future<Request> requestStore(context) async {
    Request _model = Request();
    try {
      debugPrint("save new Request: $details");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response =
          await apiService.post(url: '/requests', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _model = Request.fromJson(tmp["data"]);
        return _model;
      } else {
        debugPrint(response.body);
        return _model;
      }
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return _model;
  }

  Future<bool> requestUpdate(context) async {
    try {
      debugPrint("update new request: $details");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = new ApiService();
      http.Response response = await apiService.put(
          url: '/requests/$sId', body: body, context: context);

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

  Future<Request> requestsShow(context) async {
    Request _model = Request();
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/requests/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _model = Request.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return _model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return _model;
  }

  Future<bool> requestsDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/requests/$sId", context: context);

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

Future<List<Request>> requestIndex(context) async {
  List<Request> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/requests", context: context);
    if (response.statusCode == 200) {
      model = requestsFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
