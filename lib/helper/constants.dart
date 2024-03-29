import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_helpful_toolbox/features/dashboard/dashboard.dart';

class ApiConstants {
  static String baseUrl = 'http://localhost:8000/api';
  static String clientsEndpoint = '/clients';
  static String propertiesEndpoint = '/properties';
  static String authEndpoint = '/auth';
}

class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://127.0.0.1:8000/api";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String users = '/users';
  static const String auth = '/auth';
}

getBaseUrl() async {
  final prefs = await SharedPreferences.getInstance();
  var connectionBaseString = prefs.getString('ConnectionString');
  if (connectionBaseString != null) {
    connectionBaseString = "$connectionBaseString/api";
  } else {
    connectionBaseString = Endpoints.baseUrl;
  }

  return connectionBaseString;
}

getBearerToken(context) async {
  final prefs = await SharedPreferences.getInstance();
  var bearerToken = prefs.getString('Bearer Token');

  if (bearerToken != null) {
    return bearerToken;
  } else {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Dashboard()),
      (route) => false,
    );
  }
}
