import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventRescueCountCard extends StatelessWidget {
  const EventRescueCountCard({
    super.key,
    required this.eventCount,
    required this.rescueCount,
  });

  final String eventCount;
  final String rescueCount;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: (themeData.brightness == Brightness.dark)
            ? Theme.of(context).colorScheme.secondary
            : Colors.black87,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.green,
                size: 35.h,
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: "Events",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 220, 217, 217),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomTextWidget(
                    text: eventCount,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 220, 217, 217),
                  ),
                ],
              ),
            ],
          ),
          VerticalDivider(
            color: Colors.white,
            indent: 15.h,
            endIndent: 15.h,
          ),
          Row(
            children: [
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.green,
                size: 35.h,
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: 'Rescue Ops',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 220, 217, 217),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomTextWidget(
                    text: rescueCount,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 220, 217, 217),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
