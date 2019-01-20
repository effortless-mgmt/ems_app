import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

class JwtUtils {
  void decodeAll(String token) {
    List<String> parts = token.split('.');
    debugPrint('Split token { parts: $parts }');
    String decodedHeader = Utf8Decoder().convert(base64Decode(parts[0]));
    debugPrint('Decoded header { decodedHeader: $decodedHeader }');
    String decodedPayload = Utf8Decoder().convert(base64Decode(parts[1]));
    debugPrint('Decoded payload { decodedPayload: $decodedPayload }');
    // String decodedSignature = Utf8Decoder().convert(base64Decode(parts[2]));
    // debugPrint('Decoded signature { decodedSignature: $decodedSignature }');
    Map<dynamic, dynamic> jsonHeader = JsonDecoder().convert(decodedHeader);
    debugPrint('Deserialized header { jsonHeader: $jsonHeader }');
    Map<dynamic, dynamic> jsonPayload = JsonDecoder().convert(decodedPayload);
    debugPrint('Deserialized payload { jsonPayload: $jsonPayload }');
  }

  Map<dynamic, dynamic> decodePayload(String token) {
    String payload = token.split('.')[1];
    // We use JWS tokens in the backend, these do not adhere to the 'length is a multiple of 4'-rule of base64.
    final int missingChars = payload.length % 4;
    debugPrint('decodePayload { missingchars: $missingChars }');
    if (missingChars != 0) {
      payload = payload.padRight(payload.length + (4 - missingChars), '=');
      // debugPrint('payload: $payload');
    }
    final String decodedPayload = Utf8Decoder().convert(base64Decode(payload));
    return JsonDecoder().convert(decodedPayload);
  }

  bool validate(String token) {
    final Map<dynamic, dynamic> json = decodePayload(token);
    debugPrint(
        'validate { exp(ms): ${(json['exp'] * 1000)}, current epoch(ms): ${DateTime.now().millisecondsSinceEpoch} }');
    // TODO: write a method to detect whether or not epoch is in milliseconds.
    if ((json['exp'] * 1000) > DateTime.now().millisecondsSinceEpoch) {
      return true;
    }
    return false;
  }

  Jwt getTokenObject(String token) => Jwt.fromJson(decodePayload(token));
}

class Jwt {
  final String name;
  final String email;
  final int expires;
  final String issuer;

  Jwt({
    @required this.name,
    @required this.email,
    @required this.expires,
    @required this.issuer,
  });

  factory Jwt.fromJson(Map<dynamic, dynamic> json) {
    return Jwt(
      name: json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'],
      email: json[
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'],
      expires: json['exp'],
      issuer: json['iss'],
    );
  }

  @override
  String toString() =>
      "JWT TOKEN { name: $name, email: $email, expires: $expires, issuer: $issuer }";
}
