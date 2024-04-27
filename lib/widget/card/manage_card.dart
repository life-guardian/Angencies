import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageCard extends StatelessWidget {
  const ManageCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.onPressed,
    required this.lineColor1,
    required this.lineColor2,
    this.stop1 = 0.5,
    this.width,
    this.height,
  });

  final void Function() onPressed;

  final String text1;
  final String text2;
  final Color lineColor1;
  final Color lineColor2;
  final double stop1;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 3,
        child: Container(
          height: 20.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: (themeData.brightness == Brightness.dark)
                ? Theme.of(context).colorScheme.secondary
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: text1,
                            color: const Color.fromARGB(255, 185, 182, 182),
                            maxLines: 2,
                            fontSize: 10.sp,
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          CustomTextWidget(
                            text: text2,
                            maxLines: 2,
                            fontSize: 12.8.sp,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 30.h,
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  height: 10.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: const [0.5, 0.5],
                      colors: [
                        lineColor1,
                        lineColor2,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
