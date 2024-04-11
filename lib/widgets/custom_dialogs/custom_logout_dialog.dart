import 'package:agencies_app/widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

Future customLogoutDialog(
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
            fontSize: 22,
          ),
          content: CustomTextWidget(
            text: contentText,
            fontSize: 20.0,
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
