import 'dart:convert';
import 'package:frontend/types/generic/json_types.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  var client = http.Client();
  final root = "http://localhost:4000";
  Future<T> get<T>(String endpoint) async {
    var url = Uri.parse("$root/$endpoint");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      dynamic jsonObject = (jsonDecode(response.body));
      return jsonObject["result"]["data"] as T;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<T> patch<T>(String endpoint, JSONMutationObject mutationObject) async {
    final url = Uri.parse("$root/$endpoint");
    final response = await client.post(
      url,
      body: jsonEncode(mutationObject),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      dynamic jsonObject = (jsonDecode(response.body));
      return jsonObject["result"]["data"] as T;
    } else {
      throw Exception("Failed to update object");
    }
  }

  Future<T> delete<T>(
      String endpoint, JSONMutationObject mutationObject) async {
    final url = Uri.parse("$root/$endpoint");
    final response = await client.post(
      url,
      body: jsonEncode(mutationObject),
      headers: {'Content-Type': 'application/json'},
    );
    dynamic jsonObject = (jsonDecode(response.body));
    if (response.statusCode == 200) {
      return jsonObject["result"]["data"] as T;
    } else {
      throw Exception("Failed to delete object");
    }
  }

  Future<T> post<T>(String endpoint, dynamic mutationObject) async {
    final url = Uri.parse("$root/$endpoint");
    final response = await client.post(
      url,
      body: jsonEncode(mutationObject),
      headers: {'Content-Type': 'application/json'},
    );
    dynamic jsonObject = (jsonDecode(response.body));
    if (response.statusCode == 200) {
      return jsonObject["result"]["data"] as T;
    } else {
      throw Exception("Failed to delete object");
    }
  }
}
