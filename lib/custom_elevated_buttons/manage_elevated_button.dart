import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageElevatedButton extends StatelessWidget {
  const ManageElevatedButton({
    super.key,
    required this.buttonText,
    required this.onButtonClick,
  });
  final String buttonText;
  final void Function() onButtonClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onButtonClick,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 40),
            backgroundColor: const Color(0xff2F80ED),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: Text(
          buttonText,
          style: GoogleFonts.mulish(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
