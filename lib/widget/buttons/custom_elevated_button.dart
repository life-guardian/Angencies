// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageElevatedButton extends StatelessWidget {
  const ManageElevatedButton({
    super.key,
    required this.childWidget,
    this.color = const Color(0xff2F80ED),
    required this.onPressed,
    this.isButtonEnabled = true,
  });
  final Widget childWidget;
  final void Function() onPressed;
  final Color color;
  final bool isButtonEnabled;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        width: width / 2,
        child: ElevatedButton(
          onPressed: isButtonEnabled ? onPressed : () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
          child: childWidget,
        ),
      ),
    );
  }
}
