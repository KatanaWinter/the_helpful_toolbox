import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

import '../CaseModel.dart';
import 'QuoteItemModel.dart';

List<Quote> quotesFromJson(String str) =>
    List<Quote>.from(json.decode(str).map((x) => Quote.fromJson(x)));

String quotesToJson(List<Quote> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quote {
  Quote(
      {this.id,
      this.number,
      this.opportunity,
      this.message,
      this.subtotal,
      this.discount,
      this.tax,
      this.required_deposit,
      this.deposit,
      this.total,
      this.sCase,
      this.createdAt,
      this.updatedAt,
      this.items});

  int? id;
  String? number;
  int? opportunity;
  String? message;
  double? subtotal;
  double? discount;
  double? tax;
  double? total;
  double? deposit;
  double? required_deposit;
  DateTime? createdAt;
  DateTime? updatedAt;
  Case? sCase;
  List<QuoteItem>? items;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        number: json["number"] ?? "",
        opportunity: json["opportunity"] ?? "",
        message: json["message"] ?? "",
        subtotal: json["subtotal"] ?? 0.00,
        discount: json["discount"] ?? 0.00,
        tax: json["tax"] ?? 0.00,
        total: json["total"] ?? 0.00,
        deposit: json["deposit"] ?? 0.00,
        required_deposit: json["required_deposit"] ?? 0.00,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sCase: json["case"],
        items: List<QuoteItem>.from(
            json["items"].map((x) => QuoteItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "number": number,
        "opportunity": opportunity.toString(),
        "message": message,
        "subtotal": subtotal.toString(),
        "discount": discount.toString(),
        "tax": tax.toString(),
        "total": total.toString(),
        "deposit": deposit.toString(),
        "required_deposit": required_deposit.toString()
      };

  Future<Quote> quotesStore(context) async {
    Quote model = Quote();
    try {
      debugPrint("save new quotes: $message");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response =
          await apiService.post(url: '/quotes', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = Quote.fromJson(tmp["data"]);
        return model;
      } else {
        debugPrint(response.body);
        return model;
      }
    } catch (e) {
      debugPrint("Error in update :$e");
    }
    return model;
  }

  Future<bool> quotesUpdate(context) async {
    try {
      debugPrint("update new quotes: $message");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = ApiService();
      http.Response response = await apiService.put(
          url: '/quotes/$sId', body: body, context: context);

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

  Future<Quote> quotesShow(context) async {
    Quote model = Quote();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/quotes/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = Quote.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> quotesDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/quotes/$sId", context: context);

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

Future<List<Quote>> quotesIndex(context) async {
  List<Quote> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/quotes", context: context);
    if (response.statusCode == 200) {
      model = quotesFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
