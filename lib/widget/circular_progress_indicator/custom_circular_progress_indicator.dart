import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 25.w,
        width: 25.w,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
