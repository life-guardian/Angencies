// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:agencies_app/animations/snackbar_animations/awesome_snackbar_animation.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> customDeleteEventsApi({
  required String apiUrl,
  required BuildContext? context,
  required bool mounted,
  required String token,
  required bool isUndo,
}) async {
  if (!isUndo) {
    var response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    var jsonResponse = jsonDecode(response.body);

    String message = jsonResponse['message'];

    if (response.statusCode == 200) {
      if (mounted) {
        showAwesomeSnackBarAnimation(
          context: context!,
          title: "Rescue Operation!",
          message: message,
          contentType: ContentType.success,
        );
      }
    } else {
      if (mounted) {
        showAwesomeSnackBarAnimation(
          context: context!,
          title: "Something went wrong!",
          message: message,
          contentType: ContentType.failure,
        );
      }
    }
  }
}
