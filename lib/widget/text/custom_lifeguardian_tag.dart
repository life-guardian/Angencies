import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLifeGuardianTag extends StatelessWidget {
  const CustomLifeGuardianTag({super.key, this.showLogo = true});
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTextWidget(
          text: 'Life ',
          color: Colors.orange,
          fontWeight: FontWeight.w700,
          fontSize: 12.sp,
        ),
        CustomTextWidget(
          text: 'Guardian',
          color: Colors.green,
          fontWeight: FontWeight.w900,
          fontSize: 15.sp,
        ),
        SizedBox(
          width: 5.w,
        ),
        if (showLogo)
          SizedBox(
            width: 25.w,
            child: Image.asset(
              'assets/images/disasterImage2.jpg',
            ),
          )
      ],
    );
  }
}
