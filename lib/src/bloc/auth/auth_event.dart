import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStart extends AuthenticationEvent {
  @override
  String toString() => 'AppStart';
}

class Login extends AuthenticationEvent {
  final Map<dynamic, dynamic> authjson;

  Login({@required this.authjson}) : super([authjson]);

  @override
  String toString() => 'Login { authjson: $authjson }';
}

class Logout extends AuthenticationEvent {
  @override
  String toString() => 'Logout';
}
