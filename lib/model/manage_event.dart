// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

class ManageEventData {
  final String title;
  final String desc;
  final Color lineColor1;
  final Color lineColor2;
  final void Function()? onPressed;

  ManageEventData({
    required this.title,
    required this.desc,
    required this.lineColor1,
    required this.lineColor2,
    this.onPressed,
  });
}
