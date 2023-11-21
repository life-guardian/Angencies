import 'package:agencies_app/large_widgets/map_widgets/open_street_map.dart';
import 'package:flutter/material.dart';

Future customGoogleMapsDialog({
  required BuildContext context,
  required String titleText,
}) =>
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Set borderRadius to desired value
        ),
        child: const OpenStreetMap(),
      ),
    );
