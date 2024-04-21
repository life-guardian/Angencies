import 'dart:convert';

import 'package:agencies_app/helper/constants/api_keys.dart';
import 'package:agencies_app/helper/functions/get_locality.dart';
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
      for (int i = 0; i < data.length; i++) {
        String alertLocality = await getLocality(
            lat: data[i].alertLocation!.coordinates![1],
            lng: data[i].alertLocation!.coordinates![0]);

        data[i].locality = alertLocality;
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
      for (int i = 0; i < data.length; i++) {
        String alertLocality = await getLocality(
            lat: data[i].agencyLocation!.coordinates![1],
            lng: data[i].agencyLocation!.coordinates![0]);

        data[i].locality = alertLocality;
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

      for (int i = 0; i < data.length; i++) {
        String alertLocality = await getLocality(
            lat: data[i].location!.coordinates![1],
            lng: data[i].location!.coordinates![0]);

        data[i].locality = alertLocality;
      }
    }
    return data;
  }
}
