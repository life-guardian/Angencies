import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class CustomErrorImage extends StatelessWidget {
  const CustomErrorImage({
    super.key,
    this.headingText,
    required this.imagePath,
  });
  final String? headingText;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            child: Image.asset(
              imagePath,
              // "assets/images/animated_images/nothingfound.png",
            ),
          ),
          CustomTextWidget(
            text: headingText ?? "",
            textAlign: TextAlign.center,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          )
        ],
      ),
    );
  }
}
