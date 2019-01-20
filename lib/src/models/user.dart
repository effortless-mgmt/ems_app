import 'package:meta/meta.dart';

class User {
  User(
      {@required this.firstName,
      @required this.lastName,
      @required this.address,
      @required this.email,
      @required this.phone,
      @required this.userRoles,
      @required this.profilePictureUrl});

  final String firstName;
  final String lastName;
  final String address;
  final String email;
  final String phone;
  final List<int> userRoles;
  final String profilePictureUrl;

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      address:
          json['address'] != null ? json['address']['readableAddress'] : '',
      email: json['email'],
      phone: json['phone'],
      userRoles: json['userRoles'],
      profilePictureUrl: json['profilePictureUrl'],
    );
  }

  @override
  String toString() =>
      'User { firstName: $firstName, lastName: $lastName, address: $address, email: $email, phone: $phone, userRoles: $userRoles }';
}
