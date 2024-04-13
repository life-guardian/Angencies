import 'package:agencies_app/view/theme/textstyle_theme.dart';
import 'package:flutter/material.dart';

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
      style: textStyleFont().copyWith(
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize ?? 12,
        color: color == Colors.transparent
            ? Theme.of(context).colorScheme.onBackground
            : color,
      ),
    );
  }
}
