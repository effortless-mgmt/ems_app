import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:ems_app/src/providers/auth_api_provider.dart';
import 'package:ems_app/src/bloc/auth/auth.dart';
import 'login_state.dart';
import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthApiProvider authApiProvider;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authApiProvider, @required this.authenticationBloc})
      : assert(authApiProvider != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginState currentState,
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await authApiProvider.authenticate(
          username: event.username,
          password: event.password,
        );

        // change authentication state to authenticated.
        authenticationBloc.dispatch(Login(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
