import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<OnSiteAssessment> requestsFromJson(String str) =>
    List<OnSiteAssessment>.from(
        json.decode(str).map((x) => OnSiteAssessment.fromJson(x)));

String requestsToJson(List<OnSiteAssessment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnSiteAssessment {
  OnSiteAssessment(
      {this.id,
      this.needed,
      this.text,
      this.date,
      this.createdAt,
      this.updatedAt});

  int? id;
  int? needed;
  String? text;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory OnSiteAssessment.fromJson(Map<String, dynamic> json) =>
      OnSiteAssessment(
          id: json["id"],
          needed: json["needed"] ?? "",
          text: json["text"] ?? "",
          date: json["date"] == null ? null : DateTime.parse(json["date"]),
          createdAt: DateTime.parse(json["created_at"]),
          updatedAt: DateTime.parse(json["updated_at"]));

  Map<String, dynamic> toJson() => {
        // "id": id,
        "needed": needed.toString(),
        "text": text.toString(),
        "date": date.toString(),
      };

  Future<OnSiteAssessment> onSiteAssessmentStore(context) async {
    OnSiteAssessment model = OnSiteAssessment();
    try {
      debugPrint("save new onSiteAssessment");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/onSiteAssessments', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = OnSiteAssessment.fromJson(tmp["data"]);
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

  Future<bool> onSiteAssessmentsUpdate(context) async {
    try {
      debugPrint("update new onSiteAssessments");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = ApiService();
      http.Response response = await apiService.put(
          url: '/onSiteAssessments/$sId', body: body, context: context);

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

  Future<OnSiteAssessment> onSiteAssessmentsShow(context) async {
    OnSiteAssessment model = OnSiteAssessment();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.get(
          url: "/onSiteAssessments/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = OnSiteAssessment.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> onSiteAssessmentsDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.delete(
          url: "/onSiteAssessments/$sId", context: context);

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

Future<List<OnSiteAssessment>> onSiteAssessmentsIndex(context) async {
  List<OnSiteAssessment> model = [];
  try {
    ApiService apiService = ApiService();
    var response =
        await apiService.get(url: "/onSiteAssessments", context: context);
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
