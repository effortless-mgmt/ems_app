import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ems_app/src/blocs/auth/auth_utils.dart';
import 'package:ems_app/src/blocs/login/login_utils.dart';
import 'package:ems_app/src/providers/auth_api_provider.dart';

class LoginScreen extends StatefulWidget {
  final AuthApiProvider authApiProvider;

  LoginScreen({Key key, @required this.authApiProvider})
      : assert(authApiProvider != null),
        super(key: key);

  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc(authApiProvider: widget.authApiProvider);
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var asset = AssetImage("assets/logo-bw.png");
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: LoginForm(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              loginBloc: _loginBloc,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 64.0, bottom: 72.0),
            child: Image(
              image: asset,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: widget.loginBloc,
      builder: (
        BuildContext context,
        LoginState loginState,
      ) {
        if (_loginSucceeded(loginState)) {
          widget.authenticationBloc.dispatch(Login(token: loginState.token));
          widget.loginBloc.dispatch(LoggedIn());
        }

        if (_loginFailed(loginState)) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${loginState.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return _form(loginState);
      },
    );
  }

  Widget _form(LoginState loginState) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(title: Text("Sign In"), trailing: Icon(Icons.verified_user)),
          FormElement(child: _emailField()),
          FormElement(child: _passwordField()),
          ButtonTheme.bar(
              child: ButtonBar(
            children: <Widget>[_loginButton(loginState)],
          ))
        ],
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email Address",
        hintText: "me@example.com",
        // errorText: "No account  exists for this email address",
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "yourS3cur3P4ssw0rd",
        // errorText: "Incorrect Password!",
      ),
    );
  }

  Widget _loginButton(LoginState loginState) {
    return RaisedButton(
      child: Text("Login"),
      onPressed: loginState.isLoginButtonEnabled ? _onLoginButtonPressed : null,
    );
  }

  bool _loginSucceeded(LoginState state) => state.token.isNotEmpty;
  bool _loginFailed(LoginState state) => state.error.isNotEmpty;

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    widget.loginBloc.dispatch(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}

class FormElement extends StatelessWidget {
  final Widget child;
  FormElement({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: this.child,
    );
  }
}
