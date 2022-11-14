import 'package:flutter/foundation.dart';

class Property {
  Property({
    this.id = 1,
    required this.clientId,
    required this.name,
    required this.street,
    this.street2 = "",
    required this.city,
    required this.state,
    required this.postalcode,
    required this.country,
    this.active = 1,
  });

  int id;
  int clientId;
  String name;
  String street;
  String street2;
  String city;
  String state;
  String postalcode;
  String country;
  int active;
  dynamic createdAt;
  dynamic updatedAt;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        clientId: json["client_id"],
        name: json["name"],
        street: json["street"],
        street2: json["street2"],
        city: json["city"],
        state: json["state"],
        postalcode: json["postalcode"],
        country: json["country"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "name": name,
        "street": street,
        "street2": street2,
        "city": city,
        "state": state,
        "postalcode": postalcode,
        "country": country,
      };

  saveClient() {
    debugPrint("save new Client: $name street: $street");
  }

  edit() {
    debugPrint("edit new Client: $name street: $street");
  }

  delete() {
    debugPrint("delete new Client: $name street: $street");
  }
}

getSingleProperty(int clientId) {
  debugPrint("ToDo: create connection to database");
  return Property(
      name: "Main Property",
      street: "Meta-Grube-Weg 29",
      city: "Cuxhaven",
      postalcode: "27474",
      state: "NI",
      clientId: 1,
      country: 'Test');
}

getAllProperties() {
  return [
    Property(
        name: "Main Property",
        street: "Meta-Grube-Weg 29",
        city: "Cuxhaven",
        postalcode: "27474",
        state: "NI",
        clientId: 1,
        country: 'Test'),
    Property(
        name: "Second Property",
        street: "Meta-Grube-Weg 29",
        city: "Cuxhaven",
        postalcode: "27474",
        state: "NI",
        clientId: 1,
        country: 'Test'),
  ];
}
