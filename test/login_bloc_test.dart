import 'package:mockito/mockito.dart';

import 'package:ems_app/src/bloc/auth/auth.dart';
import 'package:ems_app/src/bloc/login/login.dart';
import 'package:ems_app/src/providers/auth_api_provider.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthApiProvider extends Mock implements AuthApiProvider {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  AuthApiProvider _authApiProvider;
  AuthenticationBloc _authBloc;
  LoginBloc _loginBloc;

  setUp(() {
    _authApiProvider = MockAuthApiProvider();
    _authBloc = MockAuthenticationBloc();
    _loginBloc = LoginBloc(
        authApiProvider: _authApiProvider, authenticationBloc: _authBloc);
  });

  test('initial state is correct', () {
    expect(LoginInitial(), _loginBloc.initialState);
  });
  test('dispose does not emit new states', () {
    expectLater(
      _loginBloc.state,
      emitsInOrder([]),
    );
    _loginBloc.dispose();
  });

  group('LoginButtonPressed', () {
    test('emits token on success', () {
      final expectedResponse = [
        LoginInitial(),
        LoginLoading(),
        LoginInitial(),
      ];

      when(_authApiProvider.authenticate(
        username: 'valid.username',
        password: 'valid.password',
      )).thenAnswer((_) => Future.value('token'));

      expectLater(
        _loginBloc.state,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verify(_authBloc.dispatch(Login(token: 'token'))).called(1);
      });

      _loginBloc.dispatch(LoginButtonPressed(
        username: 'valid.username',
        password: 'valid.password',
      ));
    });
  });

  group('LoginButtonPressed error', () {
    test('emits token on error', () {
      final expectedResponse = [
        LoginInitial(),
        LoginLoading(),
        LoginFailure(error: 'error'),
      ];

      when(_authApiProvider.authenticate(
        username: 'invalid.username',
        password: 'invalid.password',
      )).thenAnswer((_) => Future.error("error"));

      expectLater(
        _loginBloc.state,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verifyNever(_authBloc.dispatch(Login(token: 'token')));
      });

      _loginBloc.dispatch(LoginButtonPressed(
        username: 'invalid.username',
        password: 'invalid.password',
      ));
    });
  });
}
