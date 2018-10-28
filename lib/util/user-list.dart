import 'package:ems_app/util/user.dart';

class UserList {
  UserList({this.userList});

  final List<User> userList;

  factory UserList.fromJson(Map<dynamic, dynamic> json) {
    List<User> temp;
    for (var user in json.entries) {
      temp.add(User.fromJson(user.value));
    }
    return UserList(userList: temp);
  }
}

final sampleUserList = new UserList(userList: <User>[
  sampleUser1,
  sampleUser2,
  sampleUser3,
  sampleUser4,
  sampleUser5,
  sampleUser6,
  sampleUser7
]);
