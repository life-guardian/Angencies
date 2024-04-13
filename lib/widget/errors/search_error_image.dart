import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';

class SearchErrorImage extends StatelessWidget {
  const SearchErrorImage({
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
