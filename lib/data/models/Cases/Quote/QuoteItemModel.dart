import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/cases/data/case.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<QuoteItem> quotesItemsFromJson(String str) =>
    List<QuoteItem>.from(json.decode(str).map((x) => QuoteItem.fromJson(x)));

String quotesItemsToJson(List<QuoteItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuoteItem {
  QuoteItem(
      {this.id,
      this.quote_id,
      this.name,
      this.description,
      this.quantity,
      this.unit_price,
      this.total,
      this.optional,
      this.discount,
      this.createdAt,
      this.updatedAt});

  int? id;
  int? quote_id;
  String? name;
  String? description;
  int? quantity;
  double? unit_price;
  double? total;
  int? optional;
  double? discount;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory QuoteItem.fromJson(Map<String, dynamic> json) => QuoteItem(
        id: json["id"],
        quote_id: json["quote_id"] ?? "",
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        quantity: json["quantity"] ?? 0,
        unit_price: json["unit_price"] ?? 0.00,
        total: json["total"] ?? 0.00,
        optional: json["optional"] ?? 0,
        discount: json["discount"] ?? 0.00,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quote_id": quote_id,
        "name": name,
        "description": description,
        "quantity": quantity.toString(),
        "unit_price": unit_price.toString(),
        "total": total.toString(),
        "optional": optional.toString(),
        "discount": discount.toString()
      };

  Future<QuoteItem> quotesItemsStore(context) async {
    QuoteItem _model = QuoteItem();
    try {
      debugPrint("save new quotesItems");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/quotesItems', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _model = QuoteItem.fromJson(tmp["data"]);
        return _model;
      } else {
        debugPrint(response.body);
        return _model;
      }
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return _model;
  }

  Future<bool> quotesItemsUpdate(context) async {
    try {
      debugPrint("update new quotesitem");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = new ApiService();
      http.Response response = await apiService.put(
          url: '/quotesItems/$sId', body: body, context: context);

      if (response.statusCode == 200) {
        debugPrint("Update success");
        return true;
      } else {
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return false;
  }

  Future<QuoteItem> quotesShow(context) async {
    QuoteItem _model = QuoteItem();
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/quotesItems/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _model = QuoteItem.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return _model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return _model;
  }

  Future<bool> quotesItemsDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/quotesItems/$sId", context: context);

      if (response.statusCode == 200) {
        debugPrint("Delete success");
        return true;
      } else {
        debugPrint(response.body);
      }

      return false;
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return false;
  }
}

Future<List<QuoteItem>> quotesIndex(context) async {
  List<QuoteItem> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/quotesItems", context: context);
    if (response.statusCode == 200) {
      model = quotesItemsFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
