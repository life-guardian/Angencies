import 'dart:convert';

import 'package:agencies_app/helper/constants/api_keys.dart';
import 'package:agencies_app/model/alert_history.dart';
import 'package:agencies_app/model/event_history.dart';
import 'package:agencies_app/model/operation_history.dart';
import 'package:http/http.dart' as http;

class HistoryApi {
  static String baseUrl = ApiKeys.baseUrl;

  Future<List<AlertHistory>> getAlertHistoryData(
      {required String token}) async {
    var response = await http.get(
      Uri.parse('$baseUrl/api/history/agency/alerts'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    List<AlertHistory> data = [];

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var jsonData in jsonResponse) {
        data.add(AlertHistory.fromJson(jsonData));
      }
    }

    return data;
  }

  Future<List<RescueOperationHistory>> getOperationHistoryData(
      {required String token}) async {
    var response = await http.get(
      Uri.parse('$baseUrl/api/history/agency/operations'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    List<RescueOperationHistory> data = [];

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var jsonData in jsonResponse) {
        data.add(RescueOperationHistory.fromJson(jsonData));
      }
    }

    return data;
  }

  Future<List<EventHistory>> getEventHistoryData(
      {required String token}) async {
    var response = await http.get(
      Uri.parse('$baseUrl/api/history/agency/events'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    List<EventHistory> data = [];

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var jsonData in jsonResponse) {
        data.add(EventHistory.fromJson(jsonData));
      }
    }
    return data;
  }
}
