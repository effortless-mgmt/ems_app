import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([Iterable props]) : super(props);
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationInitialized extends AuthenticationState {
  final bool isLoading;
  final bool isAuthenticated;

  AuthenticationInitialized({
    @required this.isLoading,
    @required this.isAuthenticated,
  }) : super([isLoading, isAuthenticated]);

  factory AuthenticationInitialized.deauthenticated() {
    return AuthenticationInitialized(
      isLoading: true,
      isAuthenticated: true,
    );
  }

  factory AuthenticationInitialized.initialized() {
    return AuthenticationInitialized(
      isLoading: true,
      isAuthenticated: false,
    );
  }

  factory AuthenticationInitialized.authenticated() {
    return AuthenticationInitialized(
      isLoading: false,
      isAuthenticated: true,
    );
  }

  factory AuthenticationInitialized.unauthenticated() {
    return AuthenticationInitialized(
      isLoading: false,
      isAuthenticated: false,
    );
  }

  @override
  String toString() =>
      'AuthenticationState { isLoading: $isLoading, isAuthenticated: $isAuthenticated }';
}
