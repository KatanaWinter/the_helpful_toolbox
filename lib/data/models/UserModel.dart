import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_helpful_toolbox/helper/constants.dart';
import 'package:http/http.dart' as http;

class UserModel {
  int? id;
  String? email;
  String? name = "";
  String? password;

  UserModel({this.id, this.email, this.name, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id ?? -1;
    data['email'] = email ?? "";
    data['name'] = name ?? "";
    data['password'] = password ?? "";
    return data;
  }

  Future<http.Response?> loginUser(UserModel user) async {
    try {
      var body = user.toJson();
      String connString = await getBaseUrl();
      http.Response response = await http.post(
        Uri.parse(connString + Endpoints.auth + "/login"),
        body: body,
      );
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('Bearer Token', response.body);
        await prefs.setString('loginEmail', user.email!);
        debugPrint("User login successful");
        return response;
      } else {
        debugPrint(response.body);
        return response;
      }

      return response;
    } catch (e) {
      debugPrint("Error in save :$e");
    }
    return null;
  }
}
