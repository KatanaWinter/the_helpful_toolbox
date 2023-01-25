import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<JobVisit> jobsVisitsFromJson(String str) =>
    List<JobVisit>.from(json.decode(str).map((x) => JobVisit.fromJson(x)));

String jobsVisitsToJson(List<JobVisit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobVisit {
  JobVisit(
      {this.id,
      this.start_time,
      this.end_time,
      this.note,
      this.job_id,
      this.employee_id,
      this.createdAt,
      this.updatedAt});

  int? id;
  DateTime? start_time;
  DateTime? end_time;
  String? note;
  int? job_id;
  int? employee_id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory JobVisit.fromJson(Map<String, dynamic> json) => JobVisit(
        id: json["id"],
        start_time: DateTime.parse(json["start_time"]),
        end_time: DateTime.parse(json["end_time"]),
        note: json["note"] ?? "",
        job_id: json["job_id"] ?? "",
        employee_id: json["employee_id"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": start_time.toString(),
        "end_time": end_time.toString(),
        "note": note,
        "job_id": job_id.toString(),
        "employee_id": employee_id.toString()
      };

  Future<JobVisit> jobsVisitsStore(context) async {
    JobVisit model = JobVisit();
    try {
      debugPrint("save new jobsVisits");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/jobsVisits', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = JobVisit.fromJson(tmp["data"]);
        return model;
      } else {
        debugPrint(response.body);
        return model;
      }
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return model;
  }

  Future<bool> jobsVisitsUpdate(context) async {
    try {
      debugPrint("update new jobsVisits");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = ApiService();
      http.Response response = await apiService.put(
          url: '/jobsVisits/$sId', body: body, context: context);

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

  Future<JobVisit> jobsVisitsShow(context) async {
    JobVisit model = JobVisit();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/jobsVisits/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = JobVisit.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> jobsVisitsDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/jobsVisits/$sId", context: context);

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

Future<List<JobVisit>> jobsItemsIndex(context) async {
  List<JobVisit> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/jobsVisits", context: context);
    if (response.statusCode == 200) {
      model = jobsVisitsFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
