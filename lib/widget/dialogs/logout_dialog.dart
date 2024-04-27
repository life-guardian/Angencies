import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future logoutDialog(
        {required BuildContext context,
        required String titleText,
        required Function() onTap,
        Color actionButton1Color = Colors.blue,
        Color actionButton2Color = Colors.red,
        required String actionText2,
        required String contentText}) =>
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: const Color.fromARGB(155, 0, 0, 0),
      builder: (context) => FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: AlertDialog(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: CustomTextWidget(
            text: titleText,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
          content: CustomTextWidget(
            text: contentText,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: CustomTextWidget(
                  text: 'Cancel',
                  color: actionButton1Color,
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: onTap,
                child: CustomTextWidget(
                  text: actionText2,
                  color: actionButton2Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
