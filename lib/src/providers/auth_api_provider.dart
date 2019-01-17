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

  // TODO: implement non-mock authenticate call
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
      debugPrint(responsejson['user'].toString());
      debugPrint(responsejson['token'].toString());
      // AuthItemModel authItemModel = AuthItemModel.fromJson(responsejson['token']);
      // return AuthItemModel.fromJson(json.decode(response.body));
      return responsejson['token'].toString();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
    // await Future.delayed(Duration(seconds: 1));
  }

  Future<void> deleteToken() async {
    // delete token from keychain
    // await Future.delayed(Duration(seconds: 1));
    await _storage.delete(key: _tokenStorageKey);
    return;
  }

  Future<void> persistToken(String token) async {
    // write token to keychain
    // await Future.delayed(Duration(seconds: 1));
    await _storage.write(key: _tokenStorageKey, value: token);
    return;
  }

  // TODO: implement non-mock hasToken call
  Future<bool> hasToken() async {
    // // read token from keychain
    // await Future.delayed(Duration(seconds: 1));
    dynamic result = await _storage.read(key: _tokenStorageKey);
    debugPrint('hasToken result: $result');
    return false;
  }
}
