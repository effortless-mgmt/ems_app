import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';


import 'auth_state.dart';
import 'auth_event.dart';
import '../../providers/auth_api_provider.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthApiProvider authApiProvider;

  AuthenticationBloc({@required this.authApiProvider})
      : assert(authApiProvider != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationState currentState,
    AuthenticationEvent event,
  ) async* {
    if (event is AppStart) {
      final bool hasToken = await authApiProvider.hasToken();

      if (hasToken) {
        yield AuthenticationInitialized.authenticated();
      } else {
        yield AuthenticationInitialized.unauthenticated();
      }
    }

    if (event is Login) {
      yield AuthenticationInitialized.initialized();
      await authApiProvider.persistToken(event.token);
      yield AuthenticationInitialized.authenticated();
    }

    if (event is Logout) {
      yield AuthenticationInitialized.deauthenticated();
      await authApiProvider.deleteToken();
      yield AuthenticationInitialized.unauthenticated();
    }
  }
}
