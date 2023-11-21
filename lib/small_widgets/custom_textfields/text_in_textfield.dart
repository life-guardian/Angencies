import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      style: GoogleFonts.mulish(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
