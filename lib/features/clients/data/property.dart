import 'package:flutter/foundation.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';

class Property {
  int id;
  String name;
  Client? client;
  String street;
  String street2;
  String city;
  String state;
  String postalcode;
  String country;
  bool active;

  Property({
    this.id = 1,
    this.name = "",
    this.street = "",
    this.street2 = "",
    this.city = "",
    this.state = "",
    this.postalcode = "",
    this.country = "",
    this.active = true,
  });

  saveClient() {
    debugPrint("save new Client: ${this.name} street: ${this.street}");
  }

  edit() {
    debugPrint("edit new Client: ${this.name} street: ${this.street}");
  }

  delete() {
    debugPrint("delete new Client: ${this.name} street: ${this.street}");
  }
}

getSingleProperty(int clientId) {
  debugPrint("ToDo: create connection to database");
  return Property(
      name: "Main Property",
      street: "Meta-Grube-Weg 29",
      city: "Cuxhaven",
      postalcode: "27474",
      state: "NI");
}

getAllProperties() {
  return [
    Property(
        name: "Main Property",
        street: "Meta-Grube-Weg 29",
        city: "Cuxhaven",
        postalcode: "27474",
        state: "NI"),
    Property(
        name: "Second Property",
        street: "Meta-Grube-Weg 29",
        city: "Cuxhaven",
        postalcode: "27474",
        state: "NI"),
  ];
}
