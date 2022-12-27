import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/login/LoginPage.dart';
import 'package:the_helpful_toolbox/helper/constants.dart';

class ApiService {
  Future<http.Response> get(
      {String? url,
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      BuildContext? context}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var bearerToken = await prefs.getString('Bearer Token');
      if (bearerToken == null) {
        Navigator.of(context!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
      var headers = {
        'Authorization': 'Bearer $bearerToken',
      };
      String connString = await getBaseUrl();
      url = "$connString$url";
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (behaviorOnError(response.statusCode, context)) {
        return response;
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> post(
      {String? url, Map<String, dynamic>? body, BuildContext? context}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var bearerToken = await prefs.getString('Bearer Token');
      if (bearerToken == null) {
        Navigator.of(context!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
      var headers = {
        'Authorization': 'Bearer $bearerToken',
      };
      String connString = await getBaseUrl();
      url = "$connString$url";
      final http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (behaviorOnError(response.statusCode, context)) {
        return response;
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> put(
      {String? url,
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      BuildContext? context}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var bearerToken = await prefs.getString('Bearer Token');
      if (bearerToken == null) {
        Navigator.of(context!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
      var headers = {
        'Authorization': 'Bearer $bearerToken',
      };
      String connString = await getBaseUrl();
      url = "$connString$url";
      final http.Response response =
          await http.put(Uri.parse(url), headers: headers, body: body);
      if (behaviorOnError(response.statusCode, context)) {
        return response;
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> delete(
      {String? url,
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      BuildContext? context}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var bearerToken = await prefs.getString('Bearer Token');
      if (bearerToken == null) {
        Navigator.of(context!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
      var headers = {
        'Authorization': 'Bearer $bearerToken',
      };
      String connString = await getBaseUrl();
      url = "$connString$url";
      final http.Response response =
          await http.delete(Uri.parse(url), headers: headers, body: body);
      if (behaviorOnError(response.statusCode, context)) {
        return response;
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  behaviorOnError(statusCode, context) {
    String snackbartext = "";
    switch (statusCode) {
      case "400":
        snackbartext = "Bad Request";
        break;
      case "401":
        snackbartext = "Unauthorized";
        Navigator.of(context!).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
        break;
      case "404":
        snackbartext = "404 - not found";
        break;
      case "500":
        snackbartext = "Internal Server Error";
        break;
      case "502":
        snackbartext = "Bad Gateway";
        break;
      default:
    }
    if (snackbartext != "") {
      const snackBar = SnackBar(
        content: Text("Login Successful!"),
        backgroundColor: (Colors.red),
        duration: Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return true;
    }
    return true;
  }
}
