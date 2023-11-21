import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextfieldModal extends StatelessWidget {
  const TextfieldModal({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.name,
  });

  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(156, 158, 158, 158)),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.mulish(
          fontSize: 16,
        ),
      ),
    );
  }
}