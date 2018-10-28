import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ems_app/util/user-list.dart';

class UserLoader {
  UserList _currentUserList;

  Future<UserList> fetchUserList(String token) async {
    print("Fetching List of Users. Token used: $token");
    final response = await http.get("not a website yet/$token");

    if (response.statusCode == 200) {
      UserList userList = UserList.fromJson(json.decode(response.body));
      _currentUserList = userList;
      return userList;
    } else {
      throw TimeoutException("Failed to load contact");
    }
  }

  UserList get current => _currentUserList;
}
