import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectMapLocationField extends StatelessWidget {
  const SelectMapLocationField({
    super.key,
    required this.onTap,
    this.address,
    required this.initialText,
  });

  final void Function() onTap;
  final dynamic address;
  final String initialText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
            children: [
              Icon(
                Icons.near_me_outlined,
                size: 20.h,
                color: (address == null)
                    ? Colors.grey.shade700
                    : Theme.of(context).colorScheme.onBackground,
              ),
              SizedBox(
                width: 11.w,
              ),
              Flexible(
                child: CustomTextWidget(
                  text: address ?? initialText,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                  color: (address == null)
                      ? Colors.grey.shade500
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
