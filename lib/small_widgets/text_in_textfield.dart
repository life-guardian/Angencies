import 'package:flutter/material.dart';

class TextInTextField extends StatelessWidget {
  const TextInTextField({
    super.key,
    required this.text,
    this.color = const Color.fromARGB(255, 105, 104, 104),
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
  });
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
