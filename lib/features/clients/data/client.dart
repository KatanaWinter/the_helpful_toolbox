import 'package:flutter/foundation.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/helper/constants.dart';

List<Client> clientFromJson(String str) =>
    List<Client>.from(json.decode(str).map((x) => Client.fromJson(x)));

String clientToJson(List<Client> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Client {
  Client({
    this.id = 1,
    this.title = "",
    required this.firstname,
    required this.lastname,
    this.mobilenumber = "",
    this.phonenumber = "",
    required this.email,
    this.rating = 5,
    required this.active,
    required this.properties,
    this.billingAddress,
  });

  int id;
  String? title;
  String firstname;
  String lastname;
  String? mobilenumber;
  String? phonenumber;
  String? email;
  int rating;
  int active;
  int? billingAddress_id;
  List<Property> properties;
  Property? billingAddress;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        title: json["title"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        mobilenumber: json["mobilenumber"] != null ? json["mobilenumber"] : "",
        phonenumber: json["phonenumber"] != null ? json["phonenumber"] : "",
        email: json["email"] != null ? json["email"] : "",
        rating: json["rating"],
        active: json["active"],
        properties: List<Property>.from(
            json["properties"].map((x) => Property.fromJson(x))),
        billingAddress: json["billing_address"] != null
            ? Property.fromJson(json["billing_address"])
            : null,
      );

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
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString(),
        // "billingAddress_id": billingAddress != null ? billingAddress!.id : null,
        "properties":
            List<dynamic>.from(properties.map((x) => x.toJson())).toString(),
        // "billing_address": billingAddress!.toJson(),
      };

  Future<http.Response?> saveClient(Client client) async {
    try {
      debugPrint("save new Client: $firstname $lastname");

      var body = client.toJson();

      http.Response response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.clientsEndpoint),
        body: body,
      );

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

  Future<http.Response?> updateClient(Client client) async {
    try {
      debugPrint("save new Client: $firstname $lastname");

      var body = client.toJson();

      http.Response response = await http.put(
        Uri.parse(ApiConstants.baseUrl +
            ApiConstants.clientsEndpoint +
            "/" +
            client.id.toString()),
        body: body,
      );

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

  Future<http.Response?> deleteClient() async {
    try {
      debugPrint("delete Client: ${this.firstname} ${this.lastname}");

      var body = this.toJson();

      http.Response response = await http.delete(
        Uri.parse(ApiConstants.baseUrl +
            ApiConstants.clientsEndpoint +
            "/" +
            this.id.toString()),
        body: body,
      );

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
