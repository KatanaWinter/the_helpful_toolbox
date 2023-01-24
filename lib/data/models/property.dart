import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:the_helpful_toolbox/helper/constants.dart';

List<Property> propertiesFromJson(String str) =>
    List<Property>.from(json.decode(str).map((x) => Property.fromJson(x)));

String propertiesToJson(List<Property> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Property {
  Property({
    this.id,
    this.clientId,
    this.name,
    this.street,
    this.street2 = "",
    this.city,
    this.state,
    this.postalcode,
    this.country,
    this.active = 1,
  });

  int? id;
  int? clientId;
  String? name;
  String? street;
  String? street2;
  String? city;
  String? state;
  String? postalcode;
  String? country;
  int? active;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        clientId: json["client_id"],
        name: json["name"] ?? "",
        street: json["street"] ?? "",
        street2: json["street2"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        postalcode: json["postalcode"] ?? "",
        country: json["country"] ?? "",
        active: json["active"],
      );
  Property fromJson(Map<String, dynamic> json) {
    return Property(
      id: json["id"] ?? "",
      clientId: json["client_id"] ?? "",
      name: json["name"] ?? "",
      street: json["street"] ?? "",
      street2: json["street2"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      postalcode: json["postalcode"] ?? "",
      country: json["country"] ?? "",
      active: json["active"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? "" : id.toString(),
        "client_id": clientId == null ? "" : clientId.toString(),
        "name": name.toString(),
        "street": street.toString(),
        "street2": street2.toString(),
        "city": city.toString(),
        "state": state.toString(),
        "postalcode": postalcode.toString(),
        "country": country.toString(),
      };

  Future<Property> propertyStore(context) async {
    Property property = Property();
    try {
      debugPrint("save new Property: $name");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/properties', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        property = Property.fromJson(tmp["data"]);
        return property;
      } else {
        debugPrint(response.body);
        return property;
      }
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return property;
  }

  Future<bool> propertyUpdate(context) async {
    try {
      debugPrint("update new Property: $name");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = new ApiService();
      http.Response response = await apiService.put(
          url: '/properties/$sId', body: body, context: context);

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

  Future<http.Response?> propertyShow(context) async {
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/properties/$sId", context: context);

      if (response.statusCode == 200) {
        debugPrint("Property received successful");
      } else {
        debugPrint(response.body);
      }

      return response;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return null;
  }

  Future<http.Response?> propertyDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/properties/$sId", context: context);

      if (response.statusCode == 200) {
        debugPrint("Delete success");
      } else {
        debugPrint(response.body);
      }

      return response;
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return null;
  }
}

Future<List<Property>> propertyIndex(context) async {
  List<Property> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/properties", context: context);
    if (response.statusCode == 200) {
      model = propertiesFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
