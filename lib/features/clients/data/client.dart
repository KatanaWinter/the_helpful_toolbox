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
  });

  int id;
  dynamic title;
  String firstname;
  String lastname;
  String mobilenumber;
  String phonenumber;
  String email;
  int rating;
  int active;
  dynamic createdAt;
  dynamic updatedAt;
  List<Property> properties;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        title: json["title"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        mobilenumber: json["mobilenumber"],
        phonenumber: json["phonenumber"],
        email: json["email"],
        rating: json["rating"],
        active: json["active"],
        properties: List<Property>.from(
            json["properties"].map((x) => Property.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "firstname": firstname,
        "lastname": lastname,
        "mobilenumber": mobilenumber,
        "phonenumber": phonenumber,
        "email": email,
        "rating": rating,
        "active": active,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
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
        debugPrint("Save success");
      } else {
        debugPrint("Error in save :${response.body}");
      }

      return response;
    } catch (e) {
      debugPrint("Error in save :$e");
    }
    return null;
  }

  edit() {
    debugPrint("edit new Client: $firstname $lastname");
  }

  delete() {
    debugPrint("delete new Client: $firstname $lastname");
  }

  getBillingAddress(Client client) {
    debugPrint("get Property of Client");
    Property prop = Property(
        name: "Main Property",
        street: "Meta-Grube-Weg 29",
        city: "Cuxhaven",
        postalcode: "27474",
        state: "NI",
        clientId: 1,
        country: "test");

    return prop;
  }
}
