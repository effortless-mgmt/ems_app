import 'package:meta/meta.dart';

class User {
  User(
      {@required this.firstName,
      @required this.lastName,
      @required this.address,
      @required this.email,
      @required this.phone,
      @required this.userRoles});

  final String firstName;
  final String lastName;
  final String address;
  final String email;
  final String phone;
  final List<dynamic> userRoles;

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        firstName: json['firstName'],
        lastName: json['lastName'],
        address: json['address'],
        email: json['email'],
        phone: json['phone'],
        userRoles: json['userRoles']);
  }

  @override
    String toString() => 'User { firstName: $firstName, lastName: $lastName, address: $address, email: $email, phone: $phone, userRoles: $userRoles }';
}
