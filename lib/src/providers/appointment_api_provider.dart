import 'dart:convert';
import 'package:ems_app/src/models/appointment.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart';

class AppointmentApiProvider {
  final Client _client = Client();
  static const String _baseUrl = "https://api.effortless.dk";
  static const String _endpoint = "/api/appointment";

  /// Returns list of all [Appointment]'s (past, present, future) for this user
  /// EXCLUDING those available but not yet claimed by a substitute.
  Future<String> getAllAppointments({@required String token}) async {
    final response = await _client.get("$_baseUrl$_endpoint",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      debugPrint('getAppointments { appointments: $responsejson }');
      return responsejson;
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Returns [Appointment] with [id].
  Future<String> getAppointmentById(
      {@required int id, @required String token}) async {
    final response = await _client.get("$_baseUrl$_endpoint/$id",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      debugPrint('getAppointmentById { appointment: $responsejson, id: $id }');
      return responsejson;
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Returns list of all [Appointment]'s not yet claimed by a substitute.
  Future<String> getAppointmentsAvailable({@required String token}) async {
    final response = await _client.get("$_baseUrl$_endpoint/available",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      debugPrint(
          'getAppointmentsAvailable { available appointments: $responsejson }');
      return responsejson;
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Returns list of all [Appointment]'s not yet approved by this user.
  Future<String> getAppointmentsUnapproved({@required String token}) async {
    final response = await _client.get(
        "$_baseUrl$_endpoint/unapproved/substitute",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      debugPrint(
          'getAppointmentsUnapproved { unapproved appointments: $responsejson }');
      return responsejson;
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Returns all upcoming [Appointment]'s for this user
  Future<List<Appointment>> getAppointmentsUpcoming({@required String token}) async {
    final response = await _client.get("$_baseUrl$_endpoint/upcoming",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      debugPrint(
          'getAppointmentsUpcoming { upcoming appointments: $responsejson }');
      return _createAppointmentList(responsejson);
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Takes a modified [Appointment] as a json serialized string
  /// along with the [id] of the modified [Appointment].
  /// Returns the modified [Appointment] received from the server
  Future<String> putAppointment(
      {@required String token,
      @required String appointment,
      @required int id}) async {
    final response = await _client.put("$_baseUrl$_endpoint/$id",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: appointment);
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      debugPrint(
          'putAppointment { modified appointment: $responsejson, id: $id }');
      return responsejson;
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Takes the [id] of the approved [Appointment].
  /// Returns the approved [Appointment] received from the server
  Future<String> putAppointmentApproved(
      {@required String token, @required int id}) async {
    final response = await _client.put("$_baseUrl$_endpoint/$id/approve",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      debugPrint(
          'putAppointmentApproved { approved appointment: $responsejson, id: $id }');
      return responsejson;
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Takes the [id] of the claimed [Appointment].
  /// Returns the claimed [Appointment] received from the server
  Future<String> claimAppointmentAvailable(
      {@required String token, @required int id}) async {
    final response = await _client.put("$_baseUrl$_endpoint/$id/claim",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      debugPrint(
          'claimAppointmentAvailable { claimed appointment: $responsejson, id: $id }');
      return responsejson;
    } else {
      throw Exception('Failed to load post');
    }
  }

  _createAppointmentList(Map<String, dynamic> json) {
    final List<Appointment> list = List<Appointment>();
    for (var appointment in json.entries) {
      list.add(Appointment.fromJson(appointment.value));
    }
    return list;
  }
}
