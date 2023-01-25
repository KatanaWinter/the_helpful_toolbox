import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/Cases/Jobs/JobItemModel.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

import '../CaseModel.dart';
import 'JobVisitModel.dart';

List<Job> jobsFromJson(String str) =>
    List<Job>.from(json.decode(str).map((x) => Job.fromJson(x)));

String jobsToJson(List<Job> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Job {
  Job(
      {this.id,
      this.OneTimeJob,
      this.start_date,
      this.end_date,
      this.subtotal,
      this.total,
      this.tax,
      this.createdAt,
      this.updatedAt,
      this.sCase,
      this.items,
      this.visits});

  int? id;
  int? OneTimeJob;
  DateTime? start_date;
  DateTime? end_date;
  double? subtotal;
  double? total;
  double? tax;
  DateTime? createdAt;
  DateTime? updatedAt;
  Case? sCase;
  List<JobItem>? items;
  List<JobVisit>? visits;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        OneTimeJob: json["OneTimeJob"] ?? 0,
        start_date: DateTime.parse(json["start_date"]),
        end_date: DateTime.parse(json["end_date"]),
        subtotal: json["subtotal"] ?? 0.00,
        total: json["total"] ?? 0.00,
        tax: json["tax"] ?? 0.00,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sCase: json["case"],
        items:
            List<JobItem>.from(json["items"].map((x) => JobItem.fromJson(x))),
        visits: List<JobVisit>.from(
            json["visits"].map((x) => JobVisit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "OneTimeJob": OneTimeJob,
        "start_date": start_date.toString(),
        "end_date": end_date.toString(),
        "subtotal": subtotal.toString(),
        "tax": tax.toString(),
        "total": total.toString()
      };

  Future<Job> jobsStore(context) async {
    Job model = Job();
    try {
      debugPrint("save new jobs");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response =
          await apiService.post(url: '/jobs', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = Job.fromJson(tmp["data"]);
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

  Future<bool> jobsUpdate(context) async {
    try {
      debugPrint("update new jobs");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = ApiService();
      http.Response response =
          await apiService.put(url: '/jobs/$sId', body: body, context: context);

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

  Future<Job> jobsShow(context) async {
    Job model = Job();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.get(url: "/jobs/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = Job.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> jobsDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/jobs/$sId", context: context);

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

Future<List<Job>> jobsIndex(context) async {
  List<Job> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/jobs", context: context);
    if (response.statusCode == 200) {
      model = jobsFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
