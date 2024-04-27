import 'package:agencies_app/widget/buttons/back_navigation_button.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Image(
            image: const AssetImage('assets/logos/indiaflaglogo.png'),
            height: 25.h,
          ),
          SizedBox(
            width: 18.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Jai Hind!',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextWidget(
                  text: agencyName,
                  fontSize: 14.sp,
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
