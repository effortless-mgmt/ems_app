import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ems_app/src/models/DEMO/user_list.dart';

class UserApiProvider {
  final String api_url = "bluh";
  final String api_key = "bleh";
  UserListDEMO _currentUserList;

  Future<UserListDEMO> fetchUserList(String token) async {
    print("Fetching List of Users. Token used: $token");
    final response = await http.get("not a website yet/$token");

    if (response.statusCode == 200) {
      UserListDEMO userList = UserListDEMO.fromJson(json.decode(response.body));
      _currentUserList = userList;
      return userList;
    } else if (response.statusCode == 430) {
      // TODO: de-auth user and request resubmit of user credentials
    } else {
      throw TimeoutException("Failed to load contact");
    }
  }

  UserListDEMO get current => _currentUserList;
}
