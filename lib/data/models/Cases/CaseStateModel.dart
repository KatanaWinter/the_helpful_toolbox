import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/cases/data/case.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

import 'CaseStatusModel.dart';

List<CaseState> caseStatesFromJson(String str) =>
    List<CaseState>.from(json.decode(str).map((x) => CaseState.fromJson(x)));

String caseStatesToJson(List<CaseState> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CaseState {
  CaseState(
      {this.id, this.name, this.createdAt, this.updatedAt, this.statuses});

  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<CaseStatus>? statuses;

  factory CaseState.fromJson(Map<String, dynamic> json) => CaseState(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        statuses: List<CaseStatus>.from(
            json["statuses"].map((x) => CaseStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name};

  Future<CaseState> caseStateStore(context) async {
    CaseState _model = CaseState();
    try {
      debugPrint("save new Case: $name");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/caseStates', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _model = CaseState.fromJson(tmp["data"]);
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

  Future<bool> caseStateUpdate(context) async {
    try {
      debugPrint("update new case: $name");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = new ApiService();
      http.Response response = await apiService.put(
          url: '/caseStates/$sId', body: body, context: context);

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

  Future<CaseState> caseNotesShow(context) async {
    CaseState _model = CaseState();
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/caseStates/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _model = CaseState.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return _model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return _model;
  }

  Future<bool> caseNotesDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/caseStates/$sId", context: context);

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

Future<List<CaseState>> caseStateIndex(context) async {
  List<CaseState> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/caseStates", context: context);
    if (response.statusCode == 200) {
      model = caseStatesFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
