import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

Future customShowDialog(
        {required BuildContext context,
        required String titleText,
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
            color: Theme.of(context).colorScheme.onBackground,
          ),
          content: CustomTextWidget(
            text: contentText,
            fontSize: 20.0,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: const Text('Ok'),
              ),
            ),
          ],
        ),
      ),
    );
