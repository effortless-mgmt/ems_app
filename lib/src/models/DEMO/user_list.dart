import 'user.dart';

class UserList_DEMO {
  UserList_DEMO({this.userList});

  final List<User_DEMO> userList;

  factory UserList_DEMO.fromJson(Map<dynamic, dynamic> json) {
    List<User_DEMO> temp;
    for (var user in json.entries) {
      temp.add(User_DEMO.fromJson(user.value));
    }
    return UserList_DEMO(userList: temp);
  }
}

final sampleUserList = new UserList_DEMO(userList: <User_DEMO>[
  sampleUser1,
  sampleUser2,
  sampleUser3,
  sampleUser4,
]);