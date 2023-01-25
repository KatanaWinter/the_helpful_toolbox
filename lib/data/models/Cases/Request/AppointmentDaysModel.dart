import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<AppointmentDays> requestsFromJson(String str) =>
    List<AppointmentDays>.from(
        json.decode(str).map((x) => AppointmentDays.fromJson(x)));

String requestsToJson(List<AppointmentDays> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppointmentDays {
  AppointmentDays(
      {this.id,
      this.Monday,
      this.Tuesday,
      this.Wednesday,
      this.Thurstday,
      this.Friday,
      this.Saturday,
      this.Sunday,
      this.createdAt,
      this.updatedAt});

  int? id;
  int? Monday;
  int? Tuesday;
  int? Wednesday;
  int? Thurstday;
  int? Friday;
  int? Saturday;
  int? Sunday;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AppointmentDays.fromJson(Map<String, dynamic> json) =>
      AppointmentDays(
          id: json["id"],
          Monday: json["Monday"] ?? "",
          Tuesday: json["Tuesday"] ?? "",
          Wednesday: json["Wednesday"] ?? "",
          Thurstday: json["Thurstday"] ?? "",
          Friday: json["Friday"] ?? "",
          Saturday: json["Saturday"] ?? "",
          Sunday: json["Sunday"] ?? "",
          createdAt: DateTime.parse(json["created_at"]),
          updatedAt: DateTime.parse(json["updated_at"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "Monday": Monday.toString(),
        "Tuesday": Tuesday.toString(),
        "Wednesday": Wednesday.toString(),
        "Thurstday": Thurstday.toString(),
        "Friday": Friday.toString(),
        "Saturday": Saturday.toString(),
        "Sunday": Sunday.toString()
      };

  Future<AppointmentDays> appointmentDaysStore(context) async {
    AppointmentDays model = AppointmentDays();
    try {
      debugPrint("save new AppointmentDays");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/appointmentDays', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = AppointmentDays.fromJson(tmp["data"]);
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

  Future<bool> appointmentDaysUpdate(context) async {
    try {
      debugPrint("update new appointmentDays");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = ApiService();
      http.Response response = await apiService.put(
          url: '/appointmentDays/$sId', body: body, context: context);

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

  Future<AppointmentDays> appointmentDaysShow(context) async {
    AppointmentDays model = AppointmentDays();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/appointmentDays/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = AppointmentDays.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> appointmentDaysDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.delete(
          url: "/appointmentDays/$sId", context: context);

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

Future<List<AppointmentDays>> appointmentDaysIndex(context) async {
  List<AppointmentDays> model = [];
  try {
    ApiService apiService = ApiService();
    var response =
        await apiService.get(url: "/appointmentDays", context: context);
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
