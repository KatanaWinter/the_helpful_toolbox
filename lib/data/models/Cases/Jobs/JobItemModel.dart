import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<JobItem> jobsItemsFromJson(String str) =>
    List<JobItem>.from(json.decode(str).map((x) => JobItem.fromJson(x)));

String jobsItemsToJson(List<JobItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobItem {
  JobItem(
      {this.id,
      this.job_id,
      this.name,
      this.description,
      this.quantity,
      this.unit_price,
      this.total,
      this.optional,
      this.discount,
      this.createdAt,
      this.updatedAt});

  int? id;
  int? job_id;
  String? name;
  String? description;
  double? quantity;
  double? unit_price;
  double? total;
  int? optional;
  double? discount;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory JobItem.fromJson(Map<String, dynamic> json) => JobItem(
        id: json["id"],
        job_id: json["job_id"] ?? "",
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        quantity: json["quantity"] ?? 0.00,
        unit_price: json["unit_price"] ?? 0.00,
        total: json["total"] ?? 0.00,
        optional: json["optional"] ?? 0,
        discount: json["discount"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "job_id": job_id.toString(),
        "name": name,
        "description": description,
        "quantity": quantity.toString(),
        "unit_price": unit_price.toString(),
        "total": total.toString(),
        "discount": discount.toString(),
        "optional": optional.toString()
      };

  Future<JobItem> jobsItemsStore(context) async {
    JobItem model = JobItem();
    try {
      debugPrint("save new job item");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/jobsItems', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = JobItem.fromJson(tmp["data"]);
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

  Future<bool> jobsItemsUpdate(context) async {
    try {
      debugPrint("update new jobsItems");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = ApiService();
      http.Response response = await apiService.put(
          url: '/jobsItems/$sId', body: body, context: context);

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

  Future<JobItem> jobsItemsShow(context) async {
    JobItem model = JobItem();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/jobsItems/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = JobItem.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> jobsItemsDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/jobsItems/$sId", context: context);

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

Future<List<JobItem>> jobsItemsIndex(context) async {
  List<JobItem> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/jobsItems", context: context);
    if (response.statusCode == 200) {
      model = jobsItemsFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
