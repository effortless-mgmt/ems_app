import 'package:ems_app/src/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  final User user;
  final String token;

  AuthenticationAuthenticated({this.user, this.token});

  @override
  String toString() =>
      'AuthenticationAuthenticated { user: $user, token: $token }';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}
