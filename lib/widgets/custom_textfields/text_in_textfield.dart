import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInTextField extends StatelessWidget {
  const TextInTextField({
    super.key,
    this.selectedText,
    this.color = const Color.fromARGB(255, 105, 104, 104),
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    required this.initialText,
  });
  final dynamic selectedText;
  final String initialText;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return CustomTextWidget(
      text: selectedText ?? initialText,
      color: (selectedText == null)
          ? Colors.grey.shade700
          : Theme.of(context).colorScheme.onBackground,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
