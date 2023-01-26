import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/EmployeeModel.dart';
import 'package:the_helpful_toolbox/data/models/OfferListModel.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'MediaModel.dart';

List<Company> companyFromJson(String str) =>
    List<Company>.from(json.decode(str).map((x) => Company.fromJson(x)));

String companyToJson(List<Company> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Company {
  int? id;
  String? name;
  String? logoPath;
  String? phone;
  String? mobile;
  String? email;
  int? propertieId;
  List<Employee>? employees;
  List<Offerlist>? offerlists;
  Property? propertie;
  List<Media>? media;

  Company(
      {this.id,
      this.name,
      this.logoPath,
      this.phone,
      this.mobile,
      this.email,
      this.propertieId,
      this.employees,
      this.offerlists,
      this.propertie,
      this.media});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        logoPath: json["logo_path"],
        phone: json["phone"],
        mobile: json["mobile"],
        email: json["email"],
        propertieId: json["propertie_id"],
        employees: List<Employee>.from(
            json["employees"].map((x) => Employee.fromJson(x))),
        offerlists: List<Offerlist>.from(
            json["offerlists"].map((x) => Offerlist.fromJson(x))),
        propertie: json["propertie"] == null
            ? null
            : Property.fromJson(json["propertie"]),
        media: json["media"] == null
            ? null
            : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "name": name.toString(),
        "logo_path": logoPath.toString(),
        "phone": phone ?? "",
        "mobile": mobile ?? "",
        "email": email.toString(),
      };

  Future<bool> companieStore(context) async {
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/companies', body: body, context: context);

      if (response.statusCode == 200) {
        debugPrint("Save Company success");
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

  Future<bool> companyUpdate(context) async {
    try {
      var body = toJson();

      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.put(
          url: "/companies/$sId", context: context, body: body);
      if (response.statusCode == 200) {
        debugPrint("Update success");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<Company> companyShow(context) async {
    Company model = Company();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/companies/$sId", context: context);
      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = Company.fromJson(tmp);
        debugPrint("Company received successful");
      } else {
        debugPrint(response.body);
      }
      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> companyDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/companies/$sId", context: context);
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

Future<List<Company>> companyIndex(context) async {
  List<Company> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/companies", context: context);
    if (response.statusCode == 200) {
      model = companyFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
