import 'package:agencies_app/theme/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color = Colors.transparent,
    this.textOverflow,
    this.maxLines,
    this.textAlign,
  });

  final String text;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: customTextStyle().copyWith(
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize ?? 12,
        color: color == Colors.transparent
            ? Theme.of(context).colorScheme.onBackground
            : color,
      ),
    );
  }
}
