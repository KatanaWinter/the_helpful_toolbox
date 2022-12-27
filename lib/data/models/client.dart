import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/BillingAddressModel.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/helper/api_service.dart';

List<Client> clientsFromJson(String str) =>
    List<Client>.from(json.decode(str).map((x) => Client.fromJson(x)));

String clientsToJson(List<Client> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Client {
  Client({
    this.id = 1,
    this.title,
    this.firstname = "",
    this.lastname = "",
    this.mobilenumber,
    this.phonenumber,
    this.email,
    this.rating = 5,
    this.active = 1,
    this.billingAddressId,
    this.properties,
    this.billingAddress,
  });

  int id;
  String? title;
  String? firstname;
  String? lastname;
  String? mobilenumber;
  String? phonenumber;
  String? email;
  int? rating;
  int? active;
  int? billingAddressId;
  List<Property>? properties;
  BillingAddress? billingAddress;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
      id: json["id"],
      title: json["title"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      mobilenumber: json["mobilenumber"] ?? "",
      phonenumber: json["phonenumber"] ?? "",
      email: json["email"] ?? "",
      rating: json["rating"],
      active: json["active"],
      billingAddressId: json["billingAddress_id"],
      properties: List<Property>.from(
          json["properties"].map((x) => Property.fromJson(x))),
      billingAddress: json["billing_address"]);

  Client fromJson(Map<String, dynamic> json) {
    Client client = Client(
        id: json["id"],
        title: json["title"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        mobilenumber: json["mobilenumber"] ?? "",
        phonenumber: json["phonenumber"] ?? "",
        email: json["email"] ?? "",
        rating: json["rating"],
        active: json["active"],
        billingAddressId: json["billingAddress_id"],
        properties: List<Property>.from(
            json["properties"].map((x) => Property.fromJson(x))),
        billingAddress: json["billing_address"]);
    return client;
  }

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "title": title.toString(),
        "firstname": firstname,
        "lastname": lastname,
        "mobilenumber": mobilenumber,
        "phonenumber": phonenumber,
        "email": email,
        "rating": rating.toString(),
        "active": active.toString(),
        if (billingAddressId != null)
          "billingAddress_id": billingAddressId.toString(),
        "properties":
            List<dynamic>.from(properties!.map((x) => x.toJson())).toString(),
        "billing_address":
            billingAddress != null ? billingAddress!.toJson().toString() : "",
      };

  Future<http.Response?> saveClient(Client client, context) async {
    try {
      debugPrint("save new Client: $firstname $lastname");

      var body = client.toJson();
      ApiService apiService = ApiService();
      http.Response response =
          await apiService.post(url: '/clients', body: body, context: context);

      if (response.statusCode == 200) {
        debugPrint("Save Client success");
      } else {
        debugPrint(response.body);
      }

      return response;
    } catch (e) {
      debugPrint("Error in save :$e");
    }
    return null;
  }

  Future<http.Response?> updateClient(Client client, context) async {
    try {
      debugPrint("save new Client: $firstname $lastname");

      var body = client.toJson();

      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.put(
          url: "/clients/$sId", context: context, body: body);

      if (response.statusCode == 200) {
        debugPrint("Update success");
      } else {
        debugPrint(response.body);
      }

      return response;
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return null;
  }

  Future<http.Response?> deleteClient(context) async {
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/clients/$sId", context: context);

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

  Future<Client> showClient(context) async {
    Client model = Client();
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/clients/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = fromJson(tmp);

        debugPrint("Client received successful");
      } else {
        debugPrint(response.body);
      }
      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }
}

Future<List<Client>> getClients(context) async {
  List<Client> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/clients", context: context);
    if (response.statusCode == 200) {
      model = clientsFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
