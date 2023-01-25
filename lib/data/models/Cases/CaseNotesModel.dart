import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

import 'CaseModel.dart';

List<CaseNotes> caseNotesFromJson(String str) =>
    List<CaseNotes>.from(json.decode(str).map((x) => CaseNotes.fromJson(x)));

String caseNotesToJson(List<CaseNotes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CaseNotes {
  CaseNotes({
    this.id,
    this.text,
    this.caseId,
    this.createdAt,
    this.updatedAt,
    this.cases,
  });

  int? id;
  String? text;
  int? caseId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Case? cases;

  factory CaseNotes.fromJson(Map<String, dynamic> json) => CaseNotes(
        id: json["id"],
        text: json["text"],
        caseId: json["case_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        cases: json["cases"],
      );

  Map<String, dynamic> toJson() => {"id": id, "text": text, "case_id": caseId};

  Future<CaseNotes> caseNotesStore(context) async {
    CaseNotes _caseNotes = CaseNotes();
    try {
      debugPrint("save new Case: $text");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/caseNotes', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _caseNotes = CaseNotes.fromJson(tmp["data"]);
        return _caseNotes;
      } else {
        debugPrint(response.body);
        return _caseNotes;
      }
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return _caseNotes;
  }

  Future<bool> caseNotesUpdate(context) async {
    try {
      debugPrint("update new case: $text");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = new ApiService();
      http.Response response = await apiService.put(
          url: '/caseNotes/$sId', body: body, context: context);

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

  Future<CaseNotes> caseNotesShow(context) async {
    CaseNotes _case = CaseNotes();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/caseNotes/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _case = CaseNotes.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return _case;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return _case;
  }

  Future<bool> caseNotesDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/caseNotes/$sId", context: context);

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

Future<List<CaseNotes>> caseNotesIndex(context) async {
  List<CaseNotes> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/cases", context: context);
    if (response.statusCode == 200) {
      model = caseNotesFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
