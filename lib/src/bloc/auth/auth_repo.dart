import 'package:ems_app/src/providers/user_api_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:ems_app/src/models/user.dart';
import 'package:ems_app/src/util/jwt_utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationRepository {
  static final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository._internal();
  final FlutterSecureStorage _storage = new FlutterSecureStorage();
  User _user;

  final String _tokenStorageKey = "token";

  // private internal constructor to make it singleton
  AuthenticationRepository._internal();

  static AuthenticationRepository get() {
    return _authenticationRepository;
  }

  /// delete token from keychain
  Future<void> deleteToken() async {
    return await _storage.delete(key: _tokenStorageKey);
  }

  /// write token to keychain
  Future<void> persistToken(String token) async {
    return await _storage.write(key: _tokenStorageKey, value: token);
  }

  /// read token from keychain
  Future<String> readToken() async {
    final dynamic result = await _storage.read(key: _tokenStorageKey);
    if (result != null) {
      return result;
    } else {
      throw Exception('No value associated with key: $_tokenStorageKey');
    }
  }

  /// check if token exists in keychain and is valid
  Future<bool> hasToken() async {
    final dynamic result = await _storage.read(key: _tokenStorageKey);
    debugPrint('hasToken result: $result');
    if (result != null) {
      bool valid = JwtUtils().validate(result);
      if (valid) {
        if (_user == null) {
          _user = await UserApiProvider().getUser(
              token: result, name: JwtUtils().getTokenObject(result).name);
        }
        return true;
      } else {
        debugPrint('Token expired!');
        _user = null;
        return false;
      }
    }
    debugPrint('Token not found!');
    return false;
  }

  String convertAuthJsonToToken(Map<dynamic, dynamic> authjson) {
    _user = User.fromJson(authjson['user']);
    return authjson['token'];
  }

  get user => _user;
}
