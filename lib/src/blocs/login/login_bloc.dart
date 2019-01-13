import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:ems_app/src/providers/auth_api_provider.dart';
import 'package:ems_app/src/blocs/login/login_utils.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthApiProvider authApiProvider;

  LoginBloc({@required this.authApiProvider}) : assert(authApiProvider != null);

  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(
    LoginState currentState,
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginState.loading();

      try {
        final token = await authApiProvider.authenticate(
          username: event.username,
          password: event.password,
        );

        yield LoginState.success(token);
      } catch (error) {
        yield LoginState.failure(error.toString());
      }
    }

    if (event is LoggedIn) {
      yield LoginState.initial();
    }
  }
}