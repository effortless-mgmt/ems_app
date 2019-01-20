import 'user.dart';

class UserListDEMO {
  UserListDEMO({this.userList});

  final List<UserDEMO> userList;

  factory UserListDEMO.fromJson(Map<dynamic, dynamic> json) {
    List<UserDEMO> temp;
    for (var user in json.entries) {
      temp.add(UserDEMO.fromJson(user.value));
    }
    return UserListDEMO(userList: temp);
  }
}

final sampleUserList = new UserListDEMO(userList: <UserDEMO>[
  sampleUser1,
  sampleUser2,
  sampleUser3,
  sampleUser4,
]);