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
