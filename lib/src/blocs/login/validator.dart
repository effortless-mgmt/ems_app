import 'dart:async';

class Validator {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    String emailValidationRule =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(emailValidationRule);
    if (regex.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Please enter a valid email address');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    String passwordValidationRule =
        r'((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#%]).{8,})';
    RegExp regex = new RegExp(passwordValidationRule);
    if (regex.hasMatch(password)) {
      sink.add(password);
    } else {
      sink.addError(
          'Please enter a valid password (min. 8 characters, includes special character(s), number(s), etc.)');
    }
  });
}
