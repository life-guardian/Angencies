import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          foregroundColor: (themeData.brightness == Brightness.light)
              ? const Color.fromARGB(185, 30, 35, 44)
              : const Color(0xffe1dcd3),
          side: BorderSide(
            color: (themeData.brightness == Brightness.light)
                ? const Color.fromARGB(32, 30, 35, 44)
                : const Color(0xffE1DCD3),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
      ),
    );
  }
}
