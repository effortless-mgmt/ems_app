import 'package:ems_app/src/providers/auth_api_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:ems_app/src/bloc/auth/auth.dart';

class MockAuthApiProvider extends Mock implements AuthApiProvider {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  AuthApiProvider _authApiProvider;
  AuthenticationBloc _authBloc;

  setUp(() {
    _authApiProvider = MockAuthApiProvider();
    _authBloc = AuthenticationBloc(authApiProvider: _authApiProvider);
  });

  test('initial state is correct', () {
    expect(_authBloc.initialState, AuthenticationUninitialized());
  });

  test('dispose does not emit new states', () {
    expectLater(
      _authBloc.state,
      emitsInOrder([]),
    );
    _authBloc.dispose();
  });

  group('AppStarted', () {
    test('emits [uninitialized, unauthenticated] for invalid token', () {
      final expectedResponse = [
        AuthenticationUninitialized(),
        AuthenticationUnauthenticated()
      ];

      when(_authApiProvider.hasToken()).thenAnswer((_) => Future.value(false));

      expectLater(
        _authBloc.state,
        emitsInOrder(expectedResponse),
      );

      _authBloc.dispatch(AppStart());
    });
  });

  group('Login', () {
    test(
        'emits [uninitialized, loading, authenticated] when token is persisted',
        () {
      final expectedResponse = [
        AuthenticationUninitialized(),
        AuthenticationLoading(),
        AuthenticationAuthenticated(),
      ];

      expectLater(
        _authBloc.state,
        emitsInOrder(expectedResponse),
      );

      _authBloc.dispatch(Login(
        token: 'instance.token',
      ));
    });
  });

  group('Logout', () {
    test(
        'emits [uninitialized, loading, unauthenticated] when token is deleted',
        () {
      final expectedResponse = [
        AuthenticationUninitialized(),
        AuthenticationLoading(),
        AuthenticationUnauthenticated(),
      ];

      expectLater(
        _authBloc.state,
        emitsInOrder(expectedResponse),
      );

      _authBloc.dispatch(Logout());
    });
  });
}
