import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<OfferlistItem> offerListItemFromJson(String str) =>
    List<OfferlistItem>.from(
        json.decode(str).map((x) => OfferlistItem.fromJson(x)));

String offerListItemToJson(List<OfferlistItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfferlistItem {
  OfferlistItem({
    this.id,
    this.company_offerlist_id,
    this.name,
    this.description,
    this.unit_price,
    this.active,
  });

  int? id;
  int? company_offerlist_id;
  String? name;
  String? description;
  double? unit_price;
  int? active;

  factory OfferlistItem.fromJson(Map<String, dynamic> json) => OfferlistItem(
        id: json["id"],
        company_offerlist_id: json["company_offerlist_id"],
        name: json["name"],
        description: json["description"],
        unit_price: json["unit_price"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id.toString(),
        "company_offerlist_id": company_offerlist_id.toString(),
        "name": name.toString(),
        "description": description.toString(),
        "unit_price": unit_price.toString(),
        "active": active.toString(),
      };

  Future<bool> offerlistItemStore(context) async {
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/offerlistitems', body: body, context: context);

      if (response.statusCode == 200) {
        debugPrint("Save Offerlist success");
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

  Future<bool> offerlistItemUpdate(context) async {
    try {
      var body = toJson();

      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.put(
          url: "/offerlistitems/$sId", context: context, body: body);
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

  Future<OfferlistItem> offerlistItemShow(context) async {
    OfferlistItem model = OfferlistItem();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/offerlistitems/$sId", context: context);
      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = OfferlistItem.fromJson(tmp);
        debugPrint("offerlistitems received successful");
      } else {
        debugPrint(response.body);
      }
      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> offerlistItemDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.delete(
          url: "/offerlistitems/$sId", context: context);
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

Future<List<OfferlistItem>> offerlistItemIndex(context) async {
  List<OfferlistItem> model = [];
  try {
    ApiService apiService = ApiService();
    var response =
        await apiService.get(url: "/offerlistitems", context: context);
    if (response.statusCode == 200) {
      model = offerListItemFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
