import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.borderRadius,
    this.textColor,
    this.outlinedBorderColor,
    this.textFontSize,
    this.textFontWeight, this.onPressed,
  });

  final String text;
  final Color? textColor;
  final Color? outlinedBorderColor;
  final double? borderRadius;
  final double? textFontSize;
  final void Function()? onPressed;
  final FontWeight? textFontWeight;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed:onPressed?? () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: outlinedBorderColor ??
                Theme.of(context).colorScheme.onBackground),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 0,
          ),
        ),
      ),
      child: CustomTextWidget(
        text: "Retry",
        color: textColor ?? Theme.of(context).colorScheme.onBackground,
        fontSize: textFontSize,
        fontWeight: textFontWeight,
      ),
    );
  }
}
