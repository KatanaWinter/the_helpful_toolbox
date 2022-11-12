import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/helper/constants.dart';

class ApiService {
  Future<List<ClientElement>?> getClients() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.clientsEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ClientElement> _model = clientFromJson(response.body).clients;
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
