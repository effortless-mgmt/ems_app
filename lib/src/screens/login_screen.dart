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

  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final asset = AssetImage("assets/logo-bw.png");
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
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: GestureDetector(
        // Enables user to tap anywhere above the soft keyboard  to dismiss it
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        // Needs to be inside a scrollableview for automatic displacement
        // to work when soft keyboard is shown
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 32.0, bottom: 24.0),
                child: Image(
                  image: asset,
                ),
              ),
              Card(
                elevation: 12,
                margin:
                    EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
                child: LoginForm(
                  authenticationBloc:
                      BlocProvider.of<AuthenticationBloc>(context),
                  loginBloc: _loginBloc,
                ),
              ),
            ],
          )
        )
      )
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
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

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
      focusNode: _emailFocusNode,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
        labelText: "Email Address",
        hintText: "me@example.com",
        // errorText: "No account exists for this email address",
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          labelText: "Password",
          hintText: "yourS3cur3P4ssw0rd",
          // errorText: "Incorrect Password!",
          suffixIcon: InkWell(
            onTap: _togglePasswordVisibility,
            customBorder: CircleBorder(),
            child: Icon(
              (_passwordVisible ? Icons.visibility : Icons.visibility_off),
              size: 15.0,
            ),
          )),
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

  void _onWidgetDidBuild(Function callback) =>
      WidgetsBinding.instance.addPostFrameCallback((_) => callback());

  void _onLoginButtonPressed() {
    widget.loginBloc.dispatch(LoginButtonPressed(
      username: _emailController.text,
      password: _passwordController.text,
    ));
  }

  void _togglePasswordVisibility() =>
      setState(() => _passwordVisible = !_passwordVisible);
}

class FormElement extends StatelessWidget {
  final Widget child;
  FormElement({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: this.child,
    );
  }
}
