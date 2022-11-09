import 'package:flutter/foundation.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';

class Client {
  int id;
  String title;
  String firstname;
  String lastname;
  String phonenumber;
  String mobilenumber;
  bool active;
  String email;
  int rating;
  Property? billingAddress;

  Client(
      {this.id = 1,
      this.title = "",
      required this.firstname,
      required this.lastname,
      this.mobilenumber = "",
      this.phonenumber = "",
      this.email = "",
      this.rating = 5,
      this.active = true});

  saveClient() {
    debugPrint("save new Client: ${this.firstname} ${this.lastname}");
  }

  edit() {
    debugPrint("edit new Client: ${this.firstname} ${this.lastname}");
  }

  delete() {
    debugPrint("delete new Client: ${this.firstname} ${this.lastname}");
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

getSingleClient(int clientId) {
  debugPrint("ToDo: create connection to database");
  return Client(id: clientId, firstname: "Kevin", lastname: "Winter");
}

getAllClients() {
  return [
    Client(
        firstname: "Kevin", lastname: "Winter", email: "kcgwinter@gmail.com"),
    Client(
        firstname: "Vanessa",
        lastname: "Winter",
        email: "vou.winter@gmail.com"),
    Client(
        firstname: "Eugenio", lastname: "Oujo Millan", email: "emillan@gmx.de"),
    Client(firstname: "Heike", lastname: "Oujo Millan"),
    Client(firstname: "Pascal", lastname: "Oujo Millan"),
    Client(firstname: "Justine", lastname: "Müller"),
  ];
}
