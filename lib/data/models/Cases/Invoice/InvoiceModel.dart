import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/Cases/CaseModel.dart';
import 'package:the_helpful_toolbox/data/models/Cases/Invoice/InvoiceItem.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

import 'InvoicePaymentModel.dart';

List<Invoice> invoicesFromJson(String str) =>
    List<Invoice>.from(json.decode(str).map((x) => Invoice.fromJson(x)));

String invoicesToJson(List<Invoice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Invoice {
  Invoice(
      {this.id,
      this.issue_date,
      this.payment_due,
      this.billingAddress_id,
      this.total_amount,
      this.balance_amount,
      this.createdAt,
      this.updatedAt,
      this.sCase,
      this.payments,
      this.items});

  int? id;
  DateTime? issue_date;
  DateTime? payment_due;
  int? billingAddress_id;
  double? total_amount;
  double? balance_amount;
  DateTime? createdAt;
  DateTime? updatedAt;
  Case? sCase;
  List<InvoicePayment>? payments;
  List<InvoiceItem>? items;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        issue_date: DateTime.parse(json["issue_date"]),
        payment_due: DateTime.parse(json["payment_due"]),
        billingAddress_id: json["billingAddress_id"] ?? "",
        total_amount: json["total_amount"] ?? 0.00,
        balance_amount: json["balance_amount"] ?? 0.00,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sCase: json["case"],
        payments: List<InvoicePayment>.from(
            json["items"].map((x) => InvoicePayment.fromJson(x))),
        items: List<InvoiceItem>.from(
            json["visits"].map((x) => InvoiceItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "issue_date": issue_date,
        "payment_due": payment_due,
        "billingAddress_id": billingAddress_id.toString(),
        "total_amount": total_amount.toString(),
        "balance_amount": balance_amount.toString(),
      };

  Future<Invoice> invoicesStore(context) async {
    Invoice model = Invoice();
    try {
      debugPrint("save new invoice");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response =
          await apiService.post(url: '/invoices', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = Invoice.fromJson(tmp["data"]);
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

  Future<bool> invoicesUpdate(context) async {
    try {
      debugPrint("update new invoices");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = ApiService();
      http.Response response = await apiService.put(
          url: '/invoices/$sId', body: body, context: context);

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

  Future<Invoice> invoicesShow(context) async {
    Invoice model = Invoice();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/invoices/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = Invoice.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> invoicesDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/invoices/$sId", context: context);

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

Future<List<Invoice>> invoicesIndex(context) async {
  List<Invoice> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/invoices", context: context);
    if (response.statusCode == 200) {
      model = invoicesFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
