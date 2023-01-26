import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/Cases/Invoice/InvoiceModel.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<InvoicePayment> invoicesPaymentFromJson(String str) =>
    List<InvoicePayment>.from(
        json.decode(str).map((x) => InvoicePayment.fromJson(x)));

String invoicesPaymentToJson(List<InvoicePayment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoicePayment {
  InvoicePayment(
      {this.id,
      this.method,
      this.invoice_id,
      this.total_amount,
      this.amount,
      this.transaction_date,
      this.details,
      this.createdAt,
      this.updatedAt});

  int? id;
  String? method;
  int? invoice_id;
  double? amount;
  double? total_amount;
  DateTime? transaction_date;
  String? details;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory InvoicePayment.fromJson(Map<String, dynamic> json) => InvoicePayment(
        id: json["id"],
        method: json["method"],
        invoice_id: json["invoice_id"] ?? "",
        amount: json["amount"] ?? 0.00,
        total_amount: json["total_amount"] ?? 0.00,
        transaction_date: DateTime.parse(json["total_amount"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "method": method,
        "invoice_id": invoice_id.toString(),
        "amount": amount,
        "total_amount": total_amount.toString(),
        "transaction_date": transaction_date,
      };

  Future<InvoicePayment> invoicePaymentsStore(context) async {
    InvoicePayment model = InvoicePayment();
    try {
      debugPrint("save new invoicesPayments");

      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/invoicesPayments', body: body, context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = InvoicePayment.fromJson(tmp["data"]);
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

  Future<bool> invoicePaymentsUpdate(context) async {
    try {
      debugPrint("update new invoicesPayments");

      var body = toJson();
      String sId = id.toString();
      ApiService apiService = ApiService();
      http.Response response = await apiService.put(
          url: '/invoicesPayments/$sId', body: body, context: context);

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

  Future<InvoicePayment> invoicePaymentsShow(context) async {
    InvoicePayment model = InvoicePayment();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/invoicesPayments/$sId", context: context);

      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = InvoicePayment.fromJson(tmp["data"]);
      } else {
        debugPrint(response.body);
      }

      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> invoicePaymentsDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.delete(
          url: "/invoicesPayments/$sId", context: context);

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

Future<List<Invoice>> invoicePaymentsIndex(context) async {
  List<Invoice> model = [];
  try {
    ApiService apiService = ApiService();
    var response =
        await apiService.get(url: "/invoicesPayments", context: context);
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
