import 'package:flutter/foundation.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  Client({
    required this.clients,
  });

  List<ClientElement> clients;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        clients: List<ClientElement>.from(
            json["clients"].map((x) => ClientElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clients": List<dynamic>.from(clients.map((x) => x.toJson())),
      };
}

class ClientElement {
  ClientElement({
    required this.id,
    required this.title,
    required this.firstname,
    required this.lastname,
    required this.mobilenumber,
    required this.phonenumber,
    required this.email,
    required this.rating,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
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

  factory ClientElement.fromJson(Map<String, dynamic> json) => ClientElement(
        id: json["id"],
        title: json["title"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        mobilenumber: json["mobilenumber"],
        phonenumber: json["phonenumber"],
        email: json["email"],
        rating: json["rating"],
        active: json["active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
      };

  saveClient() {
    debugPrint("save new Client: $firstname $lastname");
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
        state: "NI");

    return prop;
  }
}
