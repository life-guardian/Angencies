import 'package:agencies_app/google_maps/google_map.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future customGoogleMapsDialog({
  required BuildContext context,
  required String titleText,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          titleText,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        content: GoogleMaps(),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: const Text('Select'),
              ),
            ],
          ),
        ],
      ),
    );
