import 'package:flutter/foundation.dart';

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

saveClient(Client client) {
  debugPrint("save new Client");
}

edit(Client client) {
  debugPrint("edit new Client");
}

delete(Client client) {
  debugPrint("delete new Client");
}
