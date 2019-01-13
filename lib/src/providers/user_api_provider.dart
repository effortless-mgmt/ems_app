import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../util/user_list.dart';

class UserApiProvider {
  final String api_url = "bluh";
  final String api_key = "bleh";
  UserList _currentUserList;

  Future<UserList> fetchUserList(String token) async {
    print("Fetching List of Users. Token used: $token");
    final response = await http.get("not a website yet/$token");

    if (response.statusCode == 200) {
      UserList userList = UserList.fromJson(json.decode(response.body));
      _currentUserList = userList;
      return userList;
    } else if (response.statusCode == 430) {
      // TODO: de-auth user and request resubmit of user credentials
    } else {
      throw TimeoutException("Failed to load contact");
    }
  }

  UserList get current => _currentUserList;
}