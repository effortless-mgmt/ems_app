import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart';

class AuthApiProvider {
  final Client _client = Client();
  final String _baseUrl = "https://api.effortless.dk";
  final String _endpoint = "/api/auth/login";

  Future<Map<dynamic, dynamic>> authenticate({
    @required String username,
    @required String password,
  }) async {
    final response = await _client.post("$_baseUrl$_endpoint",
        headers: {"Content-Type": "application/json"},
        body: "{ \"username\": \"$username\", \"password\": \"$password\" }");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      Map<dynamic, dynamic> responsejson = json.decode(response.body);
      debugPrint(responsejson['token'].toString());
      debugPrint(responsejson['user'].toString());
      return responsejson;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
