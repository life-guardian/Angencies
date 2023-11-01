import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.labelText,
    required this.dynamicControllerText,
  });

  final String labelText;
  final TextEditingController dynamicControllerText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dynamicControllerText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(162, 232, 236, 244),
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
        label: Text(
          labelText,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
