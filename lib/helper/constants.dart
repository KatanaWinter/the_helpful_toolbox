import 'package:shared_preferences/shared_preferences.dart';

class ApiConstants {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String baseUrl = _getBaseUrl();
  baseUrl = 'http://localhost:8000/api';
  static String clientsEndpoint = '/clients';
  static String propertiesEndpoint = '/properties';
  static String authEndpoint = '/auth';

  Future<String> _getBaseUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('ConnectionString') ?? '';
  }
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
