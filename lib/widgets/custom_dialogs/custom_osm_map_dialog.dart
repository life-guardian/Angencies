import 'package:agencies_app/widgets/map_widgets/open_street_map.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

Future customOsmMapDialog({
  required BuildContext context,
  String? titleText,
}) =>
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: const OpenStreetMap(),
        ),
      ),
    );
