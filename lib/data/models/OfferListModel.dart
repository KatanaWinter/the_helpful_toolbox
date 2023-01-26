import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<Offerlist> offerListFromJson(String str) =>
    List<Offerlist>.from(json.decode(str).map((x) => Offerlist.fromJson(x)));

String offerListToJson(List<Offerlist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Offerlist {
  Offerlist({
    this.id,
    this.name,
    this.description,
    this.active,
  });

  int? id;
  String? name;
  String? description;
  int? active;

  factory Offerlist.fromJson(Map<String, dynamic> json) => Offerlist(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id.toString(),
        "name": name.toString(),
        "description": description.toString(),
        "active": active.toString(),
      };

  Future<bool> offerlistStore(context) async {
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/offerlist', body: body, context: context);

      if (response.statusCode == 200) {
        debugPrint("Save Offerlist success");
      } else {
        debugPrint(response.body);
        return false;
      }
      return true;
    } catch (e) {
      debugPrint("Error in save :$e");
      return false;
    }
  }

  Future<bool> offerlistUpdate(context) async {
    try {
      var body = toJson();

      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.put(
          url: "/offerlist/$sId", context: context, body: body);
      if (response.statusCode == 200) {
        debugPrint("Update success");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Offerlist> offerlistShow(context) async {
    Offerlist model = Offerlist();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/offerlist/$sId", context: context);
      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = Offerlist.fromJson(tmp);
        debugPrint("Offerlist received successful");
      } else {
        debugPrint(response.body);
      }
      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> offerlistDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/offerlist/$sId", context: context);
      if (response.statusCode == 200) {
        debugPrint("Delete success");
      } else {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

Future<List<Offerlist>> offerlistIndex(context) async {
  List<Offerlist> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/offerlist", context: context);
    if (response.statusCode == 200) {
      model = offerListFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
