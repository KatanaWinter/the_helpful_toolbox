import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
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

  Future<http.Response?> loginUser(UserModel user, BuildContext context) async {
    try {
      var body = user.toJson();
      String connString = await getBaseUrl();
      http.Response response = await http.post(
        Uri.parse(connString + Endpoints.auth + "/login"),
        body: body,
      );
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'Bearer Token', response.body.replaceAll('"', ''));
        await prefs.setString('loginEmail', user.email!);
        debugPrint("User login successful");
        return response;
      } else {
        debugPrint(response.body);
        return response;
      }
    } catch (e) {
      debugPrint("Error in save :$e");
      String eMessage = e.toString();
      var snackBar = SnackBar(
        content: Text("Login Error! $eMessage",
            style: TextStyle(color: Colors.white)),
        backgroundColor: (Colors.red),
        duration: Duration(seconds: 4),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return null;
  }
}

Future<List<UserModel>> getUsers(context) async {
  try {
    ApiService apiService = new ApiService();

    List<UserModel> lUsers = <UserModel>[];
    http.Response response =
        await apiService.get(url: "/users", context: context);
    if (response.statusCode == 200) {}

    return lUsers;
  } catch (e) {
    rethrow;
  }
}
