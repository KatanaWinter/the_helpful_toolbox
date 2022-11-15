import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/helper/constants.dart';

class Property {
  Property({
    this.id,
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

  int? id;
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
        id: json["id"] ?? "",
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
  }

  Map<String, dynamic> toJson() => {
        "id": "",
        "client_id": clientId.toString(),
        "name": name.toString(),
        "street": street.toString(),
        "street2": street2.toString(),
        "city": city.toString(),
        "state": state.toString(),
        "postalcode": postalcode.toString(),
        "country": country.toString(),
      };

  Future<http.Response?> saveProperty(Property property) async {
    try {
      debugPrint("save new Property: $name");

      var body = property.toJson();

      http.Response response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.propertiesEndpoint),
        body: body,
      );

      if (response.statusCode == 200) {
        debugPrint("Save success");
      } else {
        debugPrint(response.body);
      }

      return response;
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return null;
  }

  Future<http.Response?> updateProperty(Property property) async {
    try {
      debugPrint("update new Property: $name");

      var body = property.toJson();
      String url = ApiConstants.baseUrl +
          ApiConstants.propertiesEndpoint +
          "/" +
          property.id.toString();
      http.Response response = await http.put(
        Uri.parse(url),
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

  Future<http.Response?> deleteProperty() async {
    try {
      debugPrint("delete Property: ${name}");

      var body = toJson();

      http.Response response = await http.delete(
        Uri.parse(ApiConstants.baseUrl +
            ApiConstants.propertiesEndpoint +
            "/" +
            id.toString()),
        body: id.toString(),
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

  Future<http.Response?> getProperty() async {
    try {
      debugPrint("get Property: ${id}");

      var body = toJson();

      http.Response response = await http.get(
        Uri.parse(ApiConstants.baseUrl +
            ApiConstants.propertiesEndpoint +
            "/" +
            id.toString()),
      );

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

  delete() {
    debugPrint("delete new Client: $name street: $street");
  }
}

getSingleProperty(int clientId) {
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
