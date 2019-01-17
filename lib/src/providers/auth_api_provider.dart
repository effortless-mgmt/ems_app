import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'auth_item_model.dart';

class AuthApiProvider {
  final FlutterSecureStorage _storage = new FlutterSecureStorage();
  final Client _client = Client();
  final String _baseUrl = "https://api.effortless.dk";

  final String _tokenStorageKey = "token";

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    final response = await _client.post("$_baseUrl/api/auth/login",
        headers: {"Content-Type": "application/json"},
        body: "{ \"username\": \"$username\", \"password\": \"$password\" }");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      dynamic responsejson = json.decode(response.body);
      final String token = responsejson['token'].toString();
      debugPrint(responsejson['user'].toString());
      debugPrint(token);
      // AuthItemModel authItemModel = AuthItemModel.fromJson(responsejson['token']);
      // return AuthItemModel.fromJson(json.decode(response.body));
      return token;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  // delete token from keychain
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenStorageKey);
    return;
  }

  // write token to keychain
  Future<void> persistToken(String token) async {
    await _storage.write(key: _tokenStorageKey, value: token);
    return;
  }

  // read token from keychain
  Future<String> readToken() async {
    dynamic result = await _storage.read(key: _tokenStorageKey);
    if (result != null) {
      return result;
    } else {
      throw Exception('No value associated with key: $_tokenStorageKey');
    }
  }

  // check if token exists in keychain
  Future<bool> hasToken() async {
    dynamic result = await _storage.read(key: _tokenStorageKey);
    debugPrint('hasToken result: $result');
    return (result != null);
  }
}
