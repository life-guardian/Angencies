import 'package:flutter/material.dart';

Future<DateTime?> customDatePicker(BuildContext context) async {
  final now = DateTime.now();
  final lastDate = DateTime(now.year - 1, now.month, now.day);
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: now,
    lastDate: DateTime(2099),
  );

  return pickedDate;
}
