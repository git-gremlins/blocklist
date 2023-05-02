import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseClient {
  var client = http.Client();
  Future<dynamic> get(String endpoint) async {
    var url = Uri.parse("http://localhost:4000/$endpoint");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      dynamic jsonObject = (jsonDecode(response.body));
      return jsonObject["result"]["data"];
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
