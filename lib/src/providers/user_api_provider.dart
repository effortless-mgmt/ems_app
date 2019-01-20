import 'dart:async';
import 'dart:convert';
import 'package:ems_app/src/models/user.dart';
import 'package:http/http.dart' show Client;
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

class UserApiProvider {
  final Client _client = Client();
  final String _baseUrl = "https://api.effortless.dk";
  final String _endpoint = "/api/user";

  Future<User> getUser({
    @required String token,
    @required String name,
  }) async {
    final response = await _client.get("$_baseUrl$_endpoint/$name",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      Map<dynamic, dynamic> responsejson = json.decode(response.body);
      final String userstring = responsejson.toString();
      debugPrint(userstring);
      User user = User.fromJson(responsejson);
      debugPrint(user.toString());
      return user;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
