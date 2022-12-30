import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

List<BillingAddress> billingAddressFromJson(String str) =>
    List<BillingAddress>.from(
        json.decode(str).map((x) => BillingAddress.fromJson(x)));

String billingAddressToJson(List<BillingAddress> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillingAddress {
  BillingAddress({
    this.id,
    this.clientId,
    this.name,
    this.street,
    this.street2,
    this.city,
    this.state,
    this.postalcode,
    this.country,
    this.active,
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

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
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
        // "id": id.toString(),
        "client_id": clientId.toString(),
        "name": name.toString(),
        "street": street.toString(),
        "street2": street2.toString(),
        "city": city.toString(),
        "state": state.toString(),
        "postalcode": postalcode.toString(),
        "country": country.toString(),
        "active": active.toString(),
      };

  Future<bool> billingAddressStore(context) async {
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/billingAddresses', body: body, context: context);

      if (response.statusCode == 200) {
        debugPrint("Save Client success");
      } else {
        debugPrint(response.body);
        return false;
      }
      return true;
    } catch (e) {
      debugPrint("Error in save :$e");
      return false;
    }
  }

  Future<bool> billingAddressUpdate(context) async {
    try {
      var body = toJson();

      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.put(
          url: "/billingAddresses/$sId", context: context, body: body);
      if (response.statusCode == 200) {
        debugPrint("Update success");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<BillingAddress> billingAddressShow(context) async {
    BillingAddress model = BillingAddress();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/billingAddresses/$sId", context: context);
      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = BillingAddress.fromJson(tmp);
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

  Future<bool> billingAddressDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.delete(
          url: "/billingAddresses/$sId", context: context);
      if (response.statusCode == 200) {
        debugPrint("Delete success");
      } else {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

Future<List<BillingAddress>> billingAddressIndex(context) async {
  List<BillingAddress> model = [];
  try {
    ApiService apiService = ApiService();
    var response =
        await apiService.get(url: "/billingAddresses", context: context);
    if (response.statusCode == 200) {
      model = billingAddressFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
