import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  Employee({
    this.id,
    this.companyId,
    this.firstname,
    this.lastname,
    this.phone,
    this.mobile,
    this.email,
    this.propertieId,
    this.birthdate,
  });

  int? id;
  int? companyId;
  String? firstname;
  String? lastname;
  String? phone;
  String? mobile;
  String? email;
  String? propertieId;
  DateTime? birthdate;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        companyId: json["company_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        mobile: json["mobile"],
        email: json["email"],
        propertieId: json["propertie_id"],
        birthdate: DateTime.parse(json["birthdate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "company_id": companyId.toString(),
        "firstname": firstname.toString(),
        "lastname": lastname.toString(),
        "phone": phone.toString(),
        "mobile": mobile.toString(),
        "email": email.toString(),
        "propertie_id": propertieId,
        "birthdate": birthdate.toString(),
      };

  Future<bool> employeeStore(context) async {
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/employees', body: body, context: context);

      if (response.statusCode == 200) {
        debugPrint("Save Employee success");
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

  Future<bool> employeeUpdate(context) async {
    try {
      var body = toJson();

      ApiService apiService = ApiService();
      String sId = id.toString();
      var response = await apiService.put(
          url: "/employees/$sId", context: context, body: body);
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

  Future<Employee> companyShow(context) async {
    Employee model = Employee();
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.get(url: "/employees/$sId", context: context);
      if (response.statusCode == 200) {
        var tmp = json.decode(response.body);
        model = Employee.fromJson(tmp);
        debugPrint("Employee received successful");
      } else {
        debugPrint(response.body);
      }
      return model;
    } catch (e) {
      debugPrint("Error in show :$e");
    }
    return model;
  }

  Future<bool> employeeDelete(context) async {
    try {
      ApiService apiService = ApiService();
      String sId = id.toString();
      var response =
          await apiService.delete(url: "/employees/$sId", context: context);
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

Future<List<Employee>> employeeIndex(context) async {
  List<Employee> model = [];
  try {
    ApiService apiService = ApiService();
    var response = await apiService.get(url: "/employees", context: context);
    if (response.statusCode == 200) {
      model = employeeFromJson(response.body);
      // debugPrint("test");
      return model;
    }
  } catch (e) {
    rethrow;
  }
  return model;
}
