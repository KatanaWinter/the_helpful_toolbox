import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/cases/data/case.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<AppointmentTimes> requestsFromJson(String str) =>
    List<AppointmentTimes>.from(
        json.decode(str).map((x) => AppointmentTimes.fromJson(x)));

String requestsToJson(List<AppointmentTimes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppointmentTimes {
  AppointmentTimes(
      {this.id,
      this.AnyTime,
      this.Morning,
      this.Afternoon,
      this.Evening,
      this.createdAt,
      this.updatedAt});

  int? id;
  int? AnyTime;
  int? Morning;
  int? Afternoon;
  int? Evening;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AppointmentTimes.fromJson(Map<String, dynamic> json) =>
      AppointmentTimes(
          id: json["id"],
          AnyTime: json["AnyTime"] ?? "",
          Morning: json["Morning"] ?? "",
          Afternoon: json["Afternoon"] ?? "",
          Evening: json["Evening"] ?? "",
          createdAt: DateTime.parse(json["created_at"]),
          updatedAt: DateTime.parse(json["updated_at"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "AnyTime": AnyTime.toString(),
        "Morning": Morning.toString(),
        "Afternoon": Afternoon.toString(),
        "Evening": Evening.toString()
      };

  Future<AppointmentTimes> appointmentTimesStore(context) async {
    AppointmentTimes _model = AppointmentTimes();
    try {
      debugPrint("save new AppointmentTimes");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/appointmentTimes', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _model = AppointmentTimes.fromJson(tmp["data"]);
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

  Future<bool> appointmentTimesUpdate(context) async {
    try {
      debugPrint("update new appointmentTimes");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = new ApiService();
      http.Response response = await apiService.put(
          url: '/appointmentTimes/$sId', body: body, context: context);

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

  Future<AppointmentTimes> appointmentTimesShow(context) async {
    AppointmentTimes _model = AppointmentTimes();
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/appointmentTimes/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _model = AppointmentTimes.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return _model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return _model;
  }

  Future<bool> appointmentTimesDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.delete(
          url: "/appointmentTimes/$sId", context: context);

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

Future<List<AppointmentTimes>> appointmentTimesIndex(context) async {
  List<AppointmentTimes> model = [];
  try {
    ApiService apiService = ApiService();
    var response =
        await apiService.get(url: "/appointmentTimes", context: context);
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
