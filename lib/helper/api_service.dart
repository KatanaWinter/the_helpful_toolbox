import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/helper/constants.dart';

class ApiService {
  Future<List<Client>> getClients() async {
    List<Client> model = [];
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.clientsEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        model = clientFromJson(response.body);
        // debugPrint("test");
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return model;
  }
}
