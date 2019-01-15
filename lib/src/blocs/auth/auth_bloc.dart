import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'auth_state.dart';
import 'auth_event.dart';
import '../../providers/auth_api_provider.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthApiProvider authApiProvider;
  // final UserRepository userRepository;

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
      // TODO: check for token in userrepo instead
      final bool hasToken = await authApiProvider.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is Login) {
      yield AuthenticationLoading();
      // TODO: put token into persistant storage through the userrepo
      await authApiProvider.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is Logout) {
      yield AuthenticationLoading();
      //TODO: delete token from persistant storage in userrepo
      await authApiProvider.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
