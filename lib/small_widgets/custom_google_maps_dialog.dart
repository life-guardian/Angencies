import 'package:agencies_app/google_maps/google_map.dart';
import 'package:agencies_app/google_maps/open_street_map.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future customGoogleMapsDialog({
  required BuildContext context,
  required String titleText,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Set borderRadius to desired value
        ),
        child: const OpenStreetMap(),
      ),
    );
