import 'package:ems_app/src/bloc/auth/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'auth_state.dart';
import 'auth_event.dart';
import 'package:ems_app/src/providers/auth_api_provider.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthApiProvider authApiProvider;

  AuthenticationBloc({@required this.authApiProvider})
      : assert(authApiProvider != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  // Each time the yield statement is called,
  // it adds the result of the expression that
  // follows the yield to the output Stream.
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationState currentState,
    AuthenticationEvent event,
  ) async* {
    if (event is AppStart) {
      final bool hasToken = await AuthenticationRepository.get().hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated(
            token: await AuthenticationRepository.get().readToken(),
            user: AuthenticationRepository.get().user);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is Login) {
      yield AuthenticationLoading();
      final String token =
          AuthenticationRepository.get().convertAuthJsonToToken(event.authjson);
      await AuthenticationRepository.get().persistToken(token);
      yield AuthenticationAuthenticated(
          token: token, user: AuthenticationRepository.get().user);
    }

    if (event is Logout) {
      yield AuthenticationLoading();
      await AuthenticationRepository.get().deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
