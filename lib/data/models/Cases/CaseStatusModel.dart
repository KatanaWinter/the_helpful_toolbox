import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<CaseStatus> caseStatusesFromJson(String str) =>
    List<CaseStatus>.from(json.decode(str).map((x) => CaseStatus.fromJson(x)));

String caseStatusesToJson(List<CaseStatus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CaseStatus {
  CaseStatus(
      {this.id,
      this.name,
      this.case_state_id,
      this.color,
      this.createdAt,
      this.updatedAt});

  int? id;
  String? name;
  int? case_state_id;
  String? color;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<CaseStatus>? statuses;

  factory CaseStatus.fromJson(Map<String, dynamic> json) => CaseStatus(
        id: json["id"],
        name: json["name"],
        case_state_id: json["case_state_id"] ?? "",
        color: json["color"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "case_state_id": case_state_id, "color": color};

  Future<CaseStatus> caseStatusStore(context) async {
    CaseStatus model = CaseStatus();
    try {
      debugPrint("save new Case: $name");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/caseStatuses', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = CaseStatus.fromJson(tmp["data"]);
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

  Future<bool> caseStatusUpdate(context) async {
    try {
      debugPrint("update new case: $name");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = ApiService();
      http.Response response = await apiService.put(
          url: '/caseStatuses/$sId', body: body, context: context);

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

  Future<CaseStatus> caseStatusShow(context) async {
    CaseStatus model = CaseStatus();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/caseStatuses/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = CaseStatus.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> caseStatusDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/caseStatuses/$sId", context: context);

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

Future<List<CaseStatus>> caseStatusIndex(context) async {
  List<CaseStatus> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/caseStatuses", context: context);
    if (response.statusCode == 200) {
      model = caseStatusesFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
