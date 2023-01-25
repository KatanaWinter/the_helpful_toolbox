import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/Cases/Jobs/JobItemModel.dart';
import 'package:the_helpful_toolbox/features/cases/data/case.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

import 'InvoicePaymentModel.dart';

List<InvoiceItem> invoicesItemsFromJson(String str) => List<InvoiceItem>.from(
    json.decode(str).map((x) => InvoiceItem.fromJson(x)));

String invoicesItemsToJson(List<InvoiceItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceItem {
  InvoiceItem(
      {this.id,
      this.invoice_id,
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
  int? invoice_id;
  String? name;
  String? description;
  int? quantity;
  double? unit_price;
  double? total;
  int? optional;
  double? discount;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
        id: json["id"],
        invoice_id: json["invoice_id"] ?? "",
        name: json["name"],
        description: json["description"],
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
        "invoice_id": invoice_id,
        "name": name,
        "description": description,
        "quantity": quantity.toString(),
        "unit_price": unit_price.toString(),
        "total": total.toString(),
        "optional": optional.toString(),
        "discount": discount.toString(),
      };

  Future<InvoiceItem> invoicesItemsStore(context) async {
    InvoiceItem _model = InvoiceItem();
    try {
      debugPrint("save new invoice");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/invoicesItems', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _model = InvoiceItem.fromJson(tmp["data"]);
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

  Future<bool> invoicesItemsUpdate(context) async {
    try {
      debugPrint("update new invoices");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = new ApiService();
      http.Response response = await apiService.put(
          url: '/invoicesItems/$sId', body: body, context: context);

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

  Future<InvoiceItem> invoicesItemsShow(context) async {
    InvoiceItem _model = InvoiceItem();
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/invoicesItems/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        _model = InvoiceItem.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return _model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return _model;
  }

  Future<bool> invoicesItemsDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/invoicesItems/$sId", context: context);

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

Future<List<InvoiceItem>> invoicesItemsIndex(context) async {
  List<InvoiceItem> model = [];
  try {
    ApiService apiService = ApiService();
    var response =
        await apiService.get(url: "/invoicesItems", context: context);
    if (response.statusCode == 200) {
      model = invoicesItemsFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
