import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future customShowDialog(
        {required BuildContext context,
        required String titleText,
        required String contentText}) =>
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: const Color.fromARGB(155, 0, 0, 0),
      builder: (context) => AlertDialog(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
        title: Text(
          titleText,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        content: RichText(
          text: TextSpan(
            text: contentText,
            style: GoogleFonts.lato(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
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
    );
