import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.color1,
    required this.color2,
    required this.onTap,
    required this.circleColor,
  });
  final String text1;

  final String text2;
  final String text3;
  final Color color1;
  final Color color2;
  final Color circleColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: (themeData.brightness == Brightness.dark)
                  ? Theme.of(context).colorScheme.secondary
                  : null,
              gradient: (themeData.brightness == Brightness.light)
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color1,
                        color2,
                      ],
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 15.r,
                  backgroundColor: circleColor,
                  child: Center(
                    child: Text(
                      text1,
                      style: GoogleFonts.inter().copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    CustomTextWidget(
                      text: text2,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(206, 255, 255, 255),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextWidget(
                      text: text3,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(206, 255, 255, 255),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
