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
  Future<List<Appointment>> getAllAppointments({@required String token}) async {
    final response = await _client.get("$_baseUrl$_endpoint",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      // debugPrint('getAppointments { appointments: $responsejson }');
      return _createAppointmentList(responsejson);
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Returns [Appointment] with [id].
  Future<List<Appointment>> getAppointmentById(
      {@required int id, @required String token}) async {
    final response = await _client.get("$_baseUrl$_endpoint/$id",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      // debugPrint('getAppointmentById { appointment: $responsejson, id: $id }');
      return responsejson;
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Returns list of all [Appointment]'s not yet claimed by a substitute.
  Future<List<Appointment>> getAppointmentsAvailable({@required String token}) async {
    final response = await _client.get("$_baseUrl$_endpoint/available",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      // debugPrint(
      //     'getAppointmentsAvailable { available appointments: $responsejson }');
      return _createAppointmentList(responsejson);
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Returns list of all [Appointment]'s not yet approved by this user.
  Future<List<Appointment>> getAppointmentsUnapproved({@required String token}) async {
    final response = await _client.get(
        "$_baseUrl$_endpoint/unapproved/substitute",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      // debugPrint(
      //     'getAppointmentsUnapproved { unapproved appointments: $responsejson }');
      return _createAppointmentList(responsejson);
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
      // debugPrint(
          // 'getAppointmentsUpcoming { upcoming appointments: $responsejson }');
      return _createAppointmentList(responsejson);
    } else {
      throw Exception('Failed to load post');
    }
  }

   /// Returns all upcoming [Appointment]'s for this user
  Future<Appointment> getAppointmentUpcomingNext({@required String token}) async {
    final response = await _client.get("$_baseUrl$_endpoint/upcoming?limit=1",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final List<dynamic> responsejson = json.decode(response.body);
      // debugPrint(
      //     'getAppointmentUpcomingNext { upcoming appointment: $responsejson }');
      return Appointment.fromJson(responsejson.first);
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Takes a modified [Appointment] as a json serialized string
  /// along with the [id] of the modified [Appointment].
  /// Returns the modified [Appointment] received from the server
  Future<Appointment> putAppointment(
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
          'putAppointment { id: $id }');
      return Appointment.fromJson(responsejson);
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Takes the [id] of the approved [Appointment].
  /// Returns the approved [Appointment] received from the server
  Future<Appointment> putAppointmentApproved(
      {@required String token, @required int id}) async {
    final response = await _client.put("$_baseUrl$_endpoint/$id/approve",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      debugPrint(
          'putAppointmentApproved { id: $id }');
      return Appointment.fromJson(responsejson);
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// Takes the [id] of the claimed [Appointment].
  /// Returns the claimed [Appointment] received from the server
  Future<Appointment> claimAppointmentAvailable(
      {@required String token, @required int id}) async {
    final response = await _client.put("$_baseUrl$_endpoint/$id/claim",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final dynamic responsejson = json.decode(response.body);
      debugPrint(
          'claimAppointmentAvailable { id: $id }');
      return Appointment.fromJson(responsejson);
    } else {
      throw Exception('Failed to load post');
    }
  }

  _createAppointmentList(List<dynamic> json) {
    final List<Appointment> list = List<Appointment>();
    for (var appointment in json) {
      list.add(Appointment.fromJson(appointment));
    }
    return list;
  }
}
