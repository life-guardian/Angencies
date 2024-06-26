import 'package:agencies_app/widget/buttons/back_navigation_button.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';

class CustomEventsAppBar extends StatelessWidget {
  const CustomEventsAppBar({
    super.key,
    required this.agencyName,
  });

  final String agencyName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/logos/indiaflaglogo.png'),
          const SizedBox(
            width: 21,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextWidget(
                  text: 'Jai Hind!',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextWidget(
                  text: agencyName,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // maxLines: 3,
                  // textOverflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const BackNavigationButton(
            text: "back",
          ),
        ],
      ),
    );
  }
}
