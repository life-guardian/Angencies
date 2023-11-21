import 'package:flutter/material.dart';

Future<DateTime?> customDatePicker(BuildContext context) async {
  final now = DateTime.now();

  final pickedDate = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: now,
    lastDate: DateTime(now.year + 100),
    confirmText: 'Select',
    cancelText: 'Cancel',
  );

  return pickedDate;
}
