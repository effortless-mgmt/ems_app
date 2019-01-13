// import 'package:flutter/foundation.dart';

class AuthItemModel {
  String _token;

  AuthItemModel.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
  }

}